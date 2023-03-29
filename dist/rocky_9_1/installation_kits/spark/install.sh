cp spark.env /tmp

yum install -y java-11-openjdk-headless zip
useradd -s /sbin/nologin -M spark -G x14

pushd /usr/lib/x14
mkdir -p /var/lib/x14/spark/
mkdir spark
pushd spark

wget https://dlcdn.apache.org/spark/spark-3.3.2/spark-3.3.2-bin-hadoop3-scala2.13.tgz
tar -zxf spark-3.3.2-bin-hadoop3-scala2.13.tgz
pushd spark-3.3.2-bin-hadoop3-scala2.13
# todo copy to env file
mkdir etc

mv -f /tmp/spark.env etc/env

mesh_machine_nr
nr=$?
if [[ $nr -eq 1 ]]
then
   echo "I AM MASTER_HOST=${brokkr_mesh_ip[1]}"
fi
  mv -f conf/spark-defaults.conf.template conf/spark-defaults.conf
 echo "spark.sql.streaming.stateStore.providerClass=org.apache.spark.sql.execution.streaming.state.RocksDBStateStoreProvider" >> conf/spark-defaults.conf

 mkdir /var/lib/x14/spark/spark.local.dir
 mkdir /var/lib/x14/spark/SPARK_LOCAL_DIRS
 mkdir /var/lib/x14/spark/eventLog.dir
 mkdir /var/lib/x14/spark/SPARK_WORKER_DIR
 chown -R spark: /var/lib/x14/spark/

 echo "spark.local.dir=/var/lib/x14/spark/spark.local.dir" >> conf/spark-defaults.conf
 echo "spark.eventLog.dir=/var/lib/x14/spark/eventLog.dir" >> conf/spark-defaults.conf
 echo "spark.serializer=org.apache.spark.serializer.KryoSerializer" >> conf/spark-defaults.conf


sed -i -e "s/SPARK_MASTER_HOST_REPLACE/${brokkr_mesh_ip[1]}/g" etc/env
sed -i -e "s/SPARK_LOCAL_IP_REPLACE/${brokkr_mesh_ip[$nr]}/g" etc/env
echo "SPARK_LOCAL_DIRS=/var/lib/x14/spark/SPARK_LOCAL_DIRS" >> etc/env
echo "SPARK_WORKER_DIR=/var/lib/x14/spark/SPARK_WORKER_DIR" >> etc/env

popd
popd

chown -R spark:x14 spark
popd

# TODO in case of first node only
mesh_machine_nr
if [[ $? -eq 1 ]]
then 
    mv -f spark-master.service /etc/systemd/system/
    systemctl enable spark-master
fi

mv -f spark-slave.service /etc/systemd/system/
systemctl enable spark-slave

