cp spark.env /tmp

apt-get install -y openjdk-17-jdk-headless zip
useradd -s /sbin/nologin -M spark -G x14

pushd /usr/lib/x14
mkdir spark
pushd spark

wget https://dlcdn.apache.org/spark/spark-3.3.2/spark-3.3.2-bin-hadoop3-scala2.13.tgz
tar -zxf spark-3.3.2-bin-hadoop3-scala2.13.tgz
pushd spark-3.3.2-bin-hadoop3-scala2.13
# todo copy to env file
mkdir etc

mv /tmp/spark.env etc/env

mesh_machine_nr
nr=$?
if [[ $nr -eq 1 ]]
then
   echo "I AM MASTER"
mv conf/conf/spark-defaults.conf.template conf/conf/spark-defaults.conf
echo "spark.ui.reverseProxy=true" >> conf/conf/spark-defaults.conf
echo "spark.ui.reverseProxyUrl=https://spark.x14.se" >> conf/conf/spark-defaults.conf

fi

sed -i -e "s/SPARK_MASTER_HOST_REPLACE/${mesh_ip[1]}/g" etc/env
sed -i -e "s/SPARK_LOCAL_IP_REPLACE/${mesh_ip[$nr]}/g" etc/env


popd
popd

chown -R spark:x14 spark
popd



# TODO in case of first node only
mesh_machine_nr
if [[ $? -eq 1 ]]
then 
    cp spark-master.service /etc/systemd/system/
    systemctl enable spark-master
fi

cp spark-slave.service /etc/systemd/system/
systemctl enable spark-slave
