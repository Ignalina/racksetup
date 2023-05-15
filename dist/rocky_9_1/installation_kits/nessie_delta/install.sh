dnf -y install epel-release
dnf -y install ant rocksdb

#
# Use Ivy/ant to Download depdend jars described in ivy.xml into spark jars directory
#
   mv -f *.conf /tmp
   mv -f nessie.service /tmp

   pushd /usr/lib/x14

   mkdir nessie
   pushd nessie


   pushd /usr/lib/x14/spark/spark-3.3.2-bin-hadoop3/
   chown -R spark:x14 jars/

   echo 'spark.jars.packages=org.apache.hadoop:hadoop-aws:3.3.2,org.mariadb.jdbc:mariadb-java-client:3.1.3,org.projectnessie.nessie-integrations:nessie-deltalake:0.58.1,org.projectnessie.nessie-integrations:nessie-spark-3.2-extensions:0.58.1,software.amazon.awssdk:sts:2.20.18,software.amazon.awssdk:s3:2.20.18,software.amazon.awssdk:url-connection-client:2.20.18' >> conf/spark-defaults.conf
   echo 'spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension,org.projectnessie.spark.extensions.NessieSpark32SessionExtensions' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.uri=http://${brokkr_mesh_ip[1]}:19120/api/v1' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.ref=main' >> conf/spark-defaults.conf
#   echo 'spark.sql.catalog.nessie.catalog-impl=' >> conf/spark-defaults.conf
   echo 'spark.delta.logStore.class=org.projectnessie.deltalake.NessieLogStore' >> conf/spark-defaults.conf
   echo 'spark.delta.logFileHandler.class=org.projectnessie.deltalake.NessieLogFileMetaParser' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.warehouse=s3a://nessie-catalogue' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie=org.apache.spark.sql.delta.catalog.DeltaCatalog' >> conf/spark-defaults.conf
#   echo 'spark.sql.catalog.nessie.io-impl=org.apache.iceberg.aws.s3.S3FileIO' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.s3.endpoint=http://10.1.1.68:9000' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.s3.path-style-access=true' >> conf/spark-defaults.conf
   echo 'spark.sql.defaultCatalog=nessie' >> conf/spark-defaults.conf
   
   
   
   echo "spark.ui.reverseProxy=true" >> conf/spark-defaults.conf
   echo "spark.ui.reverseProxyUrl=https://delta.x14.se" >> conf/spark-defaults.conf


   popd

   systemctl stop spark-slave

   mesh_machine_nr
   nr=$?
   if [[ $nr -eq 1 ]]
   then
      echo "I AM MASTER"
      systemctl stop spark-master

      useradd -s /sbin/nologin -M nessie -G x14

      wget https://github.com/projectnessie/nessie/releases/download/nessie-0.58.1/nessie-quarkus-0.58.1-runner
      chmod +x nessie-quarkus-0.58.1-runner
      mkdir /var/lib/x14/nessie
      chown nessie:x14 /var/lib/x14/nessie

      mv -f /tmp/nessie.service /etc/systemd/system/
      systemctl enable nessie

      chown -R nessie:x14 /usr/lib/x14/nessie
      systemctl start nessie
      systemctl start spark-master


      FILE=/etc/nginx
      if [ -d "$FILE" ]; then
          mv -f /tmp/delta.conf /etc/nginx/conf.d/
          mv -f /tmp/nessie.conf /etc/nginx/conf.d/
          systemctl restart nginx
      fi


   fi




# TESTED AND WORKED WITH
#./spark-shell --master spark://10.15.15.50:7077 --packages org.projectnessie:nessie-spark-extensions-3.3_2.12:0.54.0,org.apache.iceberg:iceberg-spark-runtime-3.3_2.12:1.2.0,software.amazon.awssdk:bundle:2.17.257,software.amazon.awssdk:url-connection-client:2.17.257 --conf spark.sql.extensions="org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions,org.projectnessie.spark.extensions.NessieSparkSessionExtensions"


# export AWS_ACCESS_KEY_ID=labb
# export AWS_SECRET_ACCESS_KEY=password
# export AWS_REGION=us-east-1

#./spark-sql --master spark://10.1.1.93:7077 --packages org.projectnessie:nessie-spark-extensions-3.3_2.12:0.54.0,org.apache.iceberg:iceberg-spark-runtime-3.3_2.12:1.2.0,software.amazon.awssdk:bundle:2.17.267,software.amazon.awssdk:url-connection-client:2.17.257 --conf spark.sql.extensions="org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions,org.projectnessie.spark.extensions.NessieSparkSessionExtensions"
# use nessie;
# CREATE TABLE demo3 (id bigint, data string) ;
