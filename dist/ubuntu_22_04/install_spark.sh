source helper.sh

apt-get install -y openjdk-17-jdk-headless zip
useradd -s /sbin/nologin -M spark -G x14

pushd /usr/lib/x14
mkdir spark
pushd spark
curl -s "https://get.sdkman.io" | bash
source /root/.sdkman/bin/sdkman-init.sh
sdk install scala 2.13.8

wget https://dlcdn.apache.org/spark/spark-3.3.1/spark-3.3.1-bin-hadoop3-scala2.13.tgz
tar -zxf spark-3.3.1-bin-hadoop3-scala2.13.tgz
pushd spark-3.3.1-bin-hadoop3-scala2.13
# todo copy to env file
popd
popd 
popd

# TODO in case of first node only
mesh_machine_nr
if [[ $? -eq 1 ]]
then 
    cp systemd/spark-master.service /etc/systemd/system/
    systemctl enable spark-master
fi

cp systemd/spark-slave.service /etc/systemd/system/
systemctl enable spark-slave
