# THIS SOURCESINK MODULE SHOULD BE INSTALLED OUTSIDE A LAKE CLUSTER AND ON THE MYSQL/MARIADB MACHINE.
#


pushd /tmp


wget https://repo1.maven.org/maven2/io/debezium/debezium-connector-mysql/2.5.0.Final/debezium-connector-mysql-2.5.0.Final-plugin.tar.gz -O  debezium-connector-mysql.tar.gz
mkdir -p /usr/lib/x14/debezium_standalone
tar -zxf debezium-connector-mysql.tar.gz


popd

