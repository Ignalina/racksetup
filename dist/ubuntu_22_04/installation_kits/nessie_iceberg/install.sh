   apt-get -y install rocksdb-tools ant

#
# Use Ivy/ant to Download depdend jars described in ivy.xml into spark jars directory
#
   cp build.xml /tmp
   cp ivy.xml /tmp
   cp *.cfg /tmp
   cp nessie.service /tmp

   pushd /usr/lib/x14

   mkdir nessie
   pushd nessie

   wget https://dlcdn.apache.org/ant/ivy/2.5.1/apache-ivy-2.5.1-bin-with-deps.zip
   unzip apache-ivy-2.5.1-bin-with-deps.zip
   rm -rf *.zip
   cp /tmp/build.xml .
   cp /tmp/ivy.xml .
   ant resolve

#   cp lib/*.jar /usr/lib/x14/spark/spark-3.3.2-bin-hadoop3-scala2.13/jars/
   pushd /usr/lib/x14/spark/spark-3.3.2-bin-hadoop3-scala2.13/
   chown -R spark:x14 jars/
   
#spark-sql --packages "org.apache.iceberg:iceberg-spark-runtime-3.3_2.12:1.0.0,org.projectnessie:nessie-spark-extensions-3.3_2.12:0.44.0,software.amazon.awssdk:bundle:2.17.178,software.amazon.awssdk:url-connection-client:2.17.178" \
#spark-sql --packages "org.apache.iceberg:iceberg-spark-runtime-3.3_2.12:1.0.0,org.projectnessie:nessie-spark-extensions-3.3_2.12:0.44.0,software.amazon.awssdk:bundle:2.17.178,software.amazon.awssdk:url-connection-client:2.17.178" \
#--conf spark.sql.extensions="org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions,org.projectnessie.spark.extensions.NessieSparkSessionExtensions" \
#--conf spark.sql.catalog.nessie.uri=$NESSIE_URI \
#--conf spark.sql.catalog.nessie.ref=main \
#--conf spark.sql.catalog.nessie.authentication.type=BEARER \
#--conf spark.sql.catalog.nessie.authentication.token=$TOKEN \
#--conf spark.sql.catalog.nessie.catalog-impl=org.apache.iceberg.nessie.NessieCatalog \
#--conf spark.sql.catalog.nessie.warehouse=$WAREHOUSE \
#--conf spark.sql.catalog.nessie=org.apache.iceberg.spark.SparkCatalog \
#--conf spark.sql.catalog.nessie.io-impl=org.apache.iceberg.aws.s3.S3FileIO
   echo 'spark.sql.extensions="org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions,org.projectnessie.spark.extensions.NessieSparkSessionExtensions"' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.uri=http://${brokkr_mesh_ip[1]}:19120/api/v1' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.ref=main' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.catalog-impl=org.apache.iceberg.nessie.NessieCatalog' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.warehouse=s3a://nessie-catalogue' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie=org.apache.iceberg.spark.SparkCatalog' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.io-impl=org.apache.iceberg.aws.s3.S3FileIO' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.s3.endpoint=http://10.1.1.68:9000' >> conf/spark-defaults.conf

   echo "spark.ui.reverseProxy=true" >> conf/spark-defaults.conf
   echo "spark.ui.reverseProxyUrl=https://iceberg.x14.se" >> conf/spark-defaults.conf

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

      wget https://github.com/projectnessie/nessie/releases/download/nessie-0.51.1/nessie-quarkus-0.51.1-runner
      chmod +x nessie-quarkus-0.51.1-runner

      mkdir /var/lib/x14/nessie
      chown nessie: /var/lib/x14/nessie

      cp /tmp/nessie.service /etc/systemd/system/
      systemctl enable nessie

      chown -R nessie:x14 /usr/lib/x14/nessie
      systemctl start nessie
      systemctl start spark-master

      FILE=/etc/nginx
      if [ -d "$FILE" ]; then
          mv -f /tmp/iceberg.cfg /etc/nginx/sites-enabled/
          mv -f /tmp/nessie.cfg /etc/nginx/sites-enabled/
          systemctl restart nginx
      fi



   fi





# TEST WITH
#./spark-shell --master spark://10.15.15.50:7077 --packages org.projectnessie:nessie-spark-extensions-3.3_2.13:0.51.1,org.apache.iceberg:iceberg-spark-runtime-3.3_2.13:1.1.0,software.amazon.awssdk:bundle:2.17.178,software.amazon.awssdk:url-connection-client:2.17.178 --conf spark.sql.extensions="org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions,org.projectnessie.spark.extensions.NessieSparkSessionExtensions"

