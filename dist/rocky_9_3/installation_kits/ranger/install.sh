pushd /tmp
yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel maven gcc bzip2 fontconfig diffutils bc tzdata git

wget https://downloads.apache.org/ranger/2.4.0/apache-ranger-2.4.0.tar.gz 
tar -zxf apache-ranger-2.4.0.tar.gz
cd apache-ranger-2.4.0
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
export PATH=$JAVA_HOME/bin:$PATH
export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=512m"
mvn  -DskipJSTests clean compile package install

popd


mkdir -p /usr/lib/x14/ranger
mkdir -p /var/lib/x14/ranger
cp apache-ranger-2.4.0/target/ranger-2.4.0-admin.tar.gz .
tar -xvf ranger-2.4.0-admin.tar.gz


# Fetch mssql connector
wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.26.tar.gz
tar -xvf mysql-connector-java-8.0.26.tar.gz
mv mysql-connector-java-8.0.26/mysql-connector-java-8.0.26.jar mysql-connector-java.jar


groupadd -r ranger
useradd -M -r -g ranger ranger
chown -R ranger:ranger /var/lib/x14/ranger
chown -R ranger:ranger /usr/lib/x14/ranger

#cp ranger.service /etc/systemd/system/
#systemctl enable ranger

#systemctl start ranger.service
