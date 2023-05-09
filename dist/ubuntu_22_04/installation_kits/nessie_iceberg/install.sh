   apt-get -y install rocksdb-tools ant

   mv -f *.conf /tmp
   mv -f nessie.service /tmp

   pushd /usr/lib/x14

   mkdir nessie
   pushd nessie

   pushd /usr/lib/x14/spark/spark-3.3.2-bin-hadoop3/
   chown -R spark:x14 jars/
   
   echo 'spark.jars.packages=org.mariadb.jdbc:mariadb-java-client:3.1.3,org.projectnessie.nessie-integrations:nessie-spark-extensions-3.3_2.12:0.54.0,org.apache.iceberg:iceberg-spark-runtime-3.3_2.12:1.2.0,software.amazon.awssdk:sts:2.20.18,software.amazon.awssdk:s3:2.20.18,software.amazon.awssdk:url-connection-client:2.20.18' >> conf/spark-defaults.conf
   echo 'spark.sql.extensions="org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions,org.projectnessie.spark.extensions.NessieSparkSessionExtensions"' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.uri=http://localhost:19120/api/v1' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.ref=main' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.catalog-impl=org.apache.iceberg.nessie.NessieCatalog' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.warehouse=s3a://nessie-catalogue' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie=org.apache.iceberg.spark.SparkCatalog' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.io-impl=org.apache.iceberg.aws.s3.S3FileIO' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.s3.endpoint=http://locahost:9000' >> conf/spark-defaults.conf
   echo 'spark.sql.defaultCatalog=nessie' >> conf/spark-defaults.conf

   echo 'AWS_ACCESS_KEY_ID=labb' >> etc/env
   echo 'AWS_SECRET_ACCESS_KEY=password' >> etc/env
   echo 'AWS_REGION=us-east-1' >> etc/env 
   #export AWS_REGION=xxxxxxxxxxxx

   popd

   systemctl stop spark-slave

   mesh_machine_nr
   nr=$?
   if [[ $nr -eq 1 ]]
   then
      echo "I AM MASTER"
      systemctl stop spark-master

      useradd -s /sbin/nologin -M nessie -G x14

      wget https://github.com/projectnessie/nessie/releases/download/nessie-0.54.0/nessie-quarkus-0.54.0-runner
      chmod +x nessie-quarkus-0.54.0-runner
      mkdir /var/lib/x14/nessie
      chown nessie:x14 /var/lib/x14/nessie

      mv -f /tmp/nessie.service /etc/systemd/system/
      systemctl enable nessie

      chown -R nessie:x14 /usr/lib/x14/nessie
      systemctl start nessie
      systemctl start spark-master

      FILE=/etc/nginx
      if [ -d "$FILE" ]; then
          mv -f /tmp/iceberg.conf /etc/nginx/sites-enabled/
          mv -f /tmp/nessie.conf /etc/nginx/sites-enabled/
          systemctl restart nginx
      fi



   fi





# TESTED WITH
#./spark-shell --master spark://10.15.15.50:7077 --packages org.projectnessie:nessie-spark-extensions-3.3_2.12:0.54.0,org.apache.iceberg:iceberg-spark-runtime-3.3_2.12:1>



