cp spark.env /tmp

apt-get install -y openjdk-11-jdk-headless zip
useradd -s /sbin/nologin -M spark -G x14

pushd /usr/lib/x14
mkdir -p /var/lib/x14/spark/
mkdir spark
pushd spark

wget https://dlcdn.apache.org/spark/spark-3.5.3/spark-3.5.3-bin-hadoop3.tgz
tar -zxf spark-3.5.3-bin-hadoop3.tgz
pushd spark-3.5.3-bin-hadoop3
# todo copy to env file
mkdir etc

mv -f /tmp/spark.env etc/env

mesh_machine_nr
nr=$?

mv -f conf/spark-env.sh.template conf/spark-env.sh
echo "SPARK_LOG_DIR=/var/lib/x14/spark/logs" >> conf/spark-env.sh

mv -f conf/spark-defaults.conf.template conf/spark-defaults.conf
echo "spark.jars.ivy=/var/lib/x14/spark/ivy" >> conf/spark-defaults.conf

mv conf/spark-defaults.conf.template conf/spark-defaults.conf
echo "spark.sql.streaming.stateStore.providerClass=org.apache.spark.sql.execution.streaming.state.RocksDBStateStoreProvider" >> conf/spark-defaults.conf

mkdir /var/lib/x14/spark/spark.local.dir
mkdir /var/lib/x14/spark/SPARK_LOCAL_DIRS
mkdir /var/lib/x14/spark/eventLog.dir
mkdir /var/lib/x14/spark/SPARK_WORKER_DIR
chown -R spark:x14 /var/lib/x14/spark/
chmod -R g+rwx /var/lib/x14/spark/

echo "spark.local.dir=/var/lib/x14/spark/spark.local.dir" >> conf/spark-defaults.conf
echo "spark.eventLog.dir=/var/lib/x14/spark/eventLog.dir" >> conf/spark-defaults.conf
echo "spark.serializer=org.apache.spark.serializer.KryoSerializer" >> conf/spark-defaults.conf


echo "spark.hadoop.fs.s3a.path.style.access=true" >> conf/spark-defaults.conf
echo "spark.hadoop.fs.s3a.access.key=labb"  >> conf/spark-defaults.conf
echo "spark.hadoop.fs.s3a.secret.key=password"  >> conf/spark-defaults.conf
echo "spark.hadoop.fs.s3a.endpoint=http://localhost:9000"  >> conf/spark-defaults.conf
echo "spark.hadoop.fs.s3a.impl=org.apache.hadoop.fs.s3a.S3AFileSystem"  >> conf/spark-defaults.conf

echo 'AWS_ACCESS_KEY_ID=labb' >> etc/env
echo 'AWS_SECRET_ACCESS_KEY=password' >> etc/env
echo 'AWS_REGION=us-east-1' >> etc/env 



# JDBC access
#echo "spark.jdbc.driver.url=jdbc:mariadb://localhost:3306/database" >> conf/spark-defaults.conf
#echo "spark.jdbc.driver.class=org.mariadb.jdbc.Driver" >> conf/spark-defaults.conf
#echo "spark.jdbc.host=localhost" >> conf/spark-defaults.conf
#echo "spark.jdbc.port=3306" >> conf/spark-defaults.conf
#echo "spark.jdbc.user=root" >> conf/spark-defaults.conf
#echo "spark.jdbc.password=password" >> conf/spark-defaults.conf

 
echo "spark.sql.execution.arrow.pyspark.enabled=true" >> conf/spark-defaults.conf

sed -i -e "s/SPARK_MASTER_HOST_REPLACE/${brokkr_mesh_ip[1]}/g" etc/env
sed -i -e "s/SPARK_LOCAL_IP_REPLACE/${brokkr_mesh_ip[$nr]}/g" etc/env
echo "SPARK_LOCAL_DIRS=/var/lib/x14/spark/SPARK_LOCAL_DIRS" >> etc/env
echo "SPARK_WORKER_DIR=/var/lib/x14/spark/SPARK_WORKER_DIR" >> etc/env

popd
popd

chown -R spark:x14 spark
chmod -R g+rwx spark
popd



# TODO in case of first node only
if [[ ${nr} -eq 2 ]]
then 
    echo "I AM MASTER_HOST=${brokkr_mesh_ip[1]}"
    mv -f spark-master.service /etc/systemd/system/
    systemctl enable spark-master
fi

mv -f spark-slave.service /etc/systemd/system/
systemctl enable spark-slave
