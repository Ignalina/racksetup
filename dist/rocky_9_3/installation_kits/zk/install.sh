
pushd /tmp
yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel perl-Time-HiRes

wget https://dlcdn.apache.org/zookeeper/zookeeper-3.8.3/apache-zookeeper-3.8.3-bin.tar.gz -O zk.tar.gz
mkdir -p /usr/lib/x14/zookeeper/
mkdir -p /var/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/data

tar -zxf zk.tar.gz -C /usr/lib/x14/zookeeper
rm -rf /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo_sample.cfg
rm -rf zk.tar.gz
popd


mesh_machine_nr
nr=$?

echo "tickTime=2000" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg
echo "dataDir=/var/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/data" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg
echo $nr > /var/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/data/myid
echo "clientPort=218" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg

echo "initLimit=5" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg
echo "syncLimit=2" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg
echo "server.1=${brokkr_ethext_ip[1]}:2888:3888" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg
echo "server.2=${brokkr_ethext_ip[2]}:2888:3888" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg
echo "server.3=${brokkr_ethext_ip[3]}:2888:3888" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg
echo "autopurge.snapRetainCount=3" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg
echo "autopurge.purgeInterval=1" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg

echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk" > /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/java.env


adduser -m -r -g x14 zookeeper
chown -R zookeeper:x14 /usr/lib/x14/zookeeper
chown -R zookeeper:x14 /var/lib/x14/zookeeper

cp zookeeper.service /etc/systemd/system/
systemctl enable zookeeper.service
systemctl start zookeeper.service

systemctl status zookeeper.service

while ! /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/bin/zkCli.sh -server localhost:2181 'sleep 5'; do  sleep 5; done ;

echo "got passed zkcli localhost:2181"

if [[ ${nr} -eq 1 ]]
then 
    echo "I AM MASTER_HOST=${brokkr_mesh_ip[1]}"
fi
