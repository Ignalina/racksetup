dnf -y install epel-release
dnf -y install ant rocksdb

   mv -f *.conf /tmp

   pushd /usr/lib/x14


   pushd /usr/lib/x14/spark/spark-3.5.0-bin-hadoop3/

   echo 'spark.jars.packages=io.delta:delta-spark_2.12:3.0.0,org.apache.hadoop:hadoop-aws:3.5.0,org.mariadb.jdbc:mariadb-java-client:3.1.3,software.amazon.awssdk:sts:2.20.18,software.amazon.awssdk:s3:2.20.18,software.amazon.awssdk:url-connection-client:2.20.18' >> conf/spark-defaults.conf
   echo 'spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.delta.warehouse=s3a://delta-catalogue' >> conf/spark-defaults.conf
   echo 'spark.sql.catalog.delta=org.apache.spark.sql.delta.catalog.DeltaCatalog' >> conf/spark-defaults.conf
   echo 'spark.sql.defaultCatalog=delta' >> conf/spark-defaults.conf
   
   
   
   echo "spark.ui.reverseProxy=true" >> conf/spark-defaults.conf
   echo "spark.ui.reverseProxyUrl=https://delta.x14.se" >> conf/spark-defaults.conf


   popd


   mesh_machine_nr
   nr=$?
   if [[ $nr -eq 1 ]]
   then
      echo "I AM MASTER"

      chown spark:x14 /var/lib/x14/spark


      FILE=/etc/nginx
      if [ -d "$FILE" ]; then
          sed -i -e "s/SPARK_MASTER_HOST_REPLACE/${brokkr_mesh_ip[1]}/g" /tmp/delta.conf
          mv -f /tmp/delta.conf /etc/nginx/conf.d/
          systemctl restart nginx
      fi


   fi




