dnf -y install epel-release
dnf -y install ant rocksdb

#
# Use Ivy/ant to Download depdend jars described in ivy.xml into spark jars directory
#
#   mv -f build.xml /tmp
#   mv -f ivy.xml /tmp
   mv -f *.conf /tmp
   mv -f nessie.service /tmp

   pushd /usr/lib/x14

   mkdir nessie
   pushd nessie

# Fetch jars for future offline installation
#   wget https://dlcdn.apache.org/ant/ivy/2.5.1/apache-ivy-2.5.1-bin-with-deps.zip
#   unzip apache-ivy-2.5.1-bin-with-deps.zip
#   rm -rf *.zip
#   mv -f /tmp/build.xml .
#   mv -f /tmp/ivy.xml .
#   ant resolve
# Disabled current fetched jars to much probs.
#   cp lib/*.jar /usr/lib/x14/spark/spark-3.3.2-bin-hadoop3-scala2.13/jars/

   pushd /usr/lib/x14/spark/spark-3.4.0-bin-hadoop3/
   chown -R spark:x14 jars/

   echo 'spark.jars.packages=org.apache.hadoop:hadoop-aws:3.4.0,org.mariadb.jdbc:mariadb-java-client:3.1.3,org.projectnessie.nessie-integrations:nessie-spark-extensions-3.4_2.12:0.60.1,org.apache.iceberg:iceberg-spark-runtime-3.4_2.12:1.3.0,software.amazon.awssdk:sts:2.20.18,software.amazon.awssdk:s3:2.20.18,software.amazon.awssdk:url-connection-client:2.20.18' >> conf/spark-defaults.conf
   echo 'spark.sql.extensions=org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions,org.projectnessie.spark.extensions.NessieSparkSessionExtensions' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.uri=http://${brokkr_mesh_ip[1]}:19120/api/v1' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.ref=main' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.catalog-impl=org.apache.iceberg.nessie.NessieCatalog' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.warehouse=s3a://nessie-catalogue' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie=org.apache.iceberg.spark.SparkCatalog' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.io-impl=org.apache.iceberg.aws.s3.S3FileIO' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.s3.endpoint=http://10.1.1.68:9000' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.s3.path-style-access=true' >> conf/spark-defaults.conf
   echo 'spark.sql.defaultCatalog=nessie' >> conf/spark-defaults.conf
   
   
   
   echo "spark.ui.reverseProxy=true" >> conf/spark-defaults.conf
   echo "spark.ui.reverseProxyUrl=https://iceberg.x14.se" >> conf/spark-defaults.conf


   popd

   systemctl stop spark-slave

   mesh_machine_nr
   nr=$?
   if [[ $nr -eq 1 ]]
   then
      echo "I AM MASTER"
      systemctl stop spark-master

      useradd -s /sbin/nologin -M nessie -g x14

      wget https://github.com/projectnessie/nessie/releases/download/nessie-0.60.1/nessie-quarkus-0.60.1-runner
      chmod +x nessie-quarkus-0.60.1-runner
      mkdir /var/lib/x14/nessie
      chown nessie:x14 /var/lib/x14/nessie

      mv -f /tmp/nessie.service /etc/systemd/system/
      systemctl enable nessie

      chown -R nessie:x14 /usr/lib/x14/nessie
      systemctl start nessie
      systemctl start spark-master


      FILE=/etc/nginx
      if [ -d "$FILE" ]; then
          mv -f /tmp/iceberg.conf /etc/nginx/conf.d/
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
