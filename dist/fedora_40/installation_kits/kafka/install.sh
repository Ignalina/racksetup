mv server.properties /tmp

yum install -y java-11-openjdk-headless zip
useradd -s /sbin/nologin -M kafka -g x14

pushd /usr/lib/x14
mkdir -p /var/lib/x14/kafka/
mkdir -p /var/lib/x14/kafka/kraft-combined-logs
mkdir -p /var/lib/x14/kafka/metadata-logs
chown -R kafka:x14 /var/lib/x14/kafka/

mkdir kafka
pushd kafka
wget https://downloads.apache.org/kafka/3.6.2/kafka_2.12-3.6.2.tgz
tar -zxf kafka_2.12-3.6.2.tgz
pushd kafka_2.12-3.6.2


mesh_machine_nr
nr=$?

mv /tmp/server.properties config/kraft/server.properties

KAFKA_CLUSTER_ID="$(bin/kafka-storage.sh random-uuid)"
bin/kafka-storage.sh format -t $KAFKA_CLUSTER_ID -c config/kraft/server.properties


#mv -f conf/spark-defaults.conf.template conf/spark-defaults.conf
#echo "spark.sql.streaming.stateStore.providerClass=org.apache.spark.sql.execution.streaming.state.RocksDBStateStoreProvider" >> conf/spark-defaults.conf


#sed -i -e "s/SPARK_MASTER_HOST_REPLACE/${brokkr_mesh_ip[1]}/g" etc/env
#sed -i -e "s/SPARK_LOCAL_IP_REPLACE/${brokkr_mesh_ip[$nr]}/g" etc/env

popd
popd

chown -R kafka:x14 kafka
popd

if [[ ${nr} -eq 1 ]]
then 
    echo "I AM MASTER_HOST=${brokkr_mesh_ip[1]}"
fi

mv -f kafka.service /etc/systemd/system/
systemctl enable kafka

