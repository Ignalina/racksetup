
pushd /tmp

wget https://dlcdn.apache.org/zookeeper/zookeeper-3.8.3/apache-zookeeper-3.8.3-bin.tar.gz -O zk.tar.gz
mkdir -p /usr/lib/x14/zookeeper/
mkdir -p /var/lib/x14/zookeeper/

tar -zxf zk.tar.gz -C /usr/lib/x14/zookeeper
rm -rf /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo_sample.cfg
popd


mesh_machine_nr
nr=$?

echo "tickTime=2000" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg
echo "dataDir=/var/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/ranger" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg
echo "clientPort=218" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg

echo "initLimit=5" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg
echo "syncLimit=2" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg
echo "server.1=${brokkr_mesh_ip[1]}:2888:3888" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg
echo "server.2=${brokkr_mesh_ip[2]}:2888:3888" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg
echo "server.3=${brokkr_mesh_ip[3]}:2888:3888" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg
echo "autopurge.snapRetainCount=3" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg
echo "autopurge.purgeInterval=1" >> /usr/lib/x14/zookeeper/apache-zookeeper-3.8.3-bin/conf/zoo.cfg



adduser -m -r -g x14 zookeeper
chown -R zookeeper:x14 /usr/lib/x14/zookeeper
chown -R zookeeper:x14 /var/lib/x14/zookeeper

cp zookeeper.service /etc/systemd/system/
systemctl enable zookeeper.service
systemctl start zookeeper.service

