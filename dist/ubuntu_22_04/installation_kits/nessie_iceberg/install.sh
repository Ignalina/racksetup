
mesh_machine_nr
nr=$?
if [[ $nr -eq 1 ]]
then
   echo "I AM MASTER"
   useradd -s /sbin/nologin -M nessie -G x14


   apt-get -y install rocksdb-tools ant
   cp build.xml /tmp
   cp ivy.xml /tmp
   pushd /usr/lib/x14

   mkdir nessie
   pushd nessie

   wget https://dlcdn.apache.org//ant/ivy/2.5.1/apache-ivy-2.5.1-bin-with-deps.zip
   unzip apache-ivy-2.5.1-bin-with-deps.zip
   cp /tmp/build.xml .
   cp /tmp/ivy.xml .
   ant resolve
   
   cp lib/*.jar /usr/lib/x14/spark/spark-3.3.2-bin-hadoop3-scala2.13/jars/
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

   echo 'spark.sql.extensions="org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions,org.projectnessie.spark.extensions.NessieSparkSessionExtensions"' >> con/conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.uri=$NESSIE_URI' >> con/conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.ref=main' >> con/conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.catalog-impl=org.apache.iceberg.nessie.NessieCatalog' >> con/conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.warehouse=$WAREHOUSE' >> con/conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie=org.apache.iceberg.spark.SparkCatalog' >> con/conf/spark-defaults.conf
   echo 'spark.sql.catalog.nessie.io-impl=org.apache.iceberg.aws.s3.S3FileIO' >> con/conf/spark-defaults.conf


   echo '' >> con/conf/spark-defaults.conf


   popd

   wget https://github.com/projectnessie/nessie/releases/download/nessie-0.51.1/nessie-quarkus-0.51.1-runner
   chmod +x nessie-quarkus-0.51.1-runner

   popd
   popd
   cp nessie.service /etc/systemd/system/
   systemctl enable nessie

   chown -R nessie:x14 /usr/lib/x14/nessie



   systemctl stop spark
   systemctl start nessie
   systemctl start spark

fi