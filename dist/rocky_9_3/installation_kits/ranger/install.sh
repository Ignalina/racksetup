pushd /tmp
yum install -y java-1.8.0-openjdk-headless
wget https://downloads.apache.org/ranger/2.4.0/apache-ranger-2.4.0.tar.gz -o ranger.tar.gz
tar -zxf ranger.tar.gz
cd apache apache-ranger-2.4.0
export JAVA_HOME=/usr/lib/jvm/jre-1.8.0/
export PATH=$JAVA_HOME/bin:$PATH
mvn clean compile package install
popd


mkdir -p /usr/lib/x14/ranger
mkdir -p /var/lib/x14/ranger

groupadd -r ranger
useradd -M -r -g ranger ranger
chown -R ranger:ranger /var/lib/x14/ranger
chown -R ranger:ranger /usr/lib/x14/ranger

#cp ranger.service /etc/systemd/system/
#systemctl enable ranger

#systemctl start ranger.service
