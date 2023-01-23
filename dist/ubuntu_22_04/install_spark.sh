apt-get install -y openjdk-17-jdk-headless zip
useradd -s /sbin/nologin -M spark -G x14

cd /usr/lib/x14
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

# TODO in case of first node only
cp dist/ubuntu_22_04/systemd/spark-master.service /etc/systemd/system/
systemctl enable spark-master

cp dist/ubuntu_22_04/systemd/spark-slave.service /etc/systemd/system/
systemctl enable spark-slave
