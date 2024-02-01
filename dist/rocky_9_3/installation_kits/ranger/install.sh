mesh_machine_nr
nr=$?

if [[ ${nr} -eq 1 ]]
then 
    echo "I AM MASTER_HOST=${brokkr_mesh_ip[1]}"

    mariadb -u root < create_mariadb_user.sql


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
    cp install.properties /tmp

    mkdir -p /usr/lib/x14/ranger
    pushd /usr/lib/x14/ranger

       cp /tmp/apache-ranger-2.4.0/target/ranger-2.4.0-admin.tar.gz .
       tar -xvf ranger-2.4.0-admin.tar.gz

       pushd ranger-2.4.0-admin

# Fetch mssql connector

          pushd /tmp
             wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.26.tar.gz
             tar -xvf mysql-connector-java-8.0.26.tar.gz
          popd

          mv /tmp/mysql-connector-java-8.0.26/mysql-connector-java-8.0.26.jar mysql-connector-java.jar
# CPOY intsall.properties 


          adduser -m -r -g x14 ranger
          mkdir -p /var/lib/x14/ranger

          chown -R ranger:x14 /var/lib/x14/ranger
          chown -R ranger:x14 /usr/lib/x14/ranger

	  cat /tmp/install.properties >> install.properties
          echo "audit_solr_urls=http://${brokkr_ethext_ip[1]}:8983/solr/ranger_audits" >> install.properties
          echo "audit_solr_zookeepers=${brokkr_ethext_ip[1]}:2181,${brokkr_ethext_ip[2]}:2181,${brokkr_ethext_ip[3]}:2181/solr" >> install.properties
#          echo "audit_solr_collection=" >> install.properties
# audit_solr_no_shards
          ./setup.sh
# this should not be necessary but something if i gave correct input in install.properties	  
	  cp  /usr/lib/x14/ranger/ranger-2.4.0-admin/mysql-connector-java.jar /usr/lib/x14/ranger/ranger-2.4.0-admin/ews/webapp/WEB-INF/lib/
       popd
    popd


    cp rangeradmin.service /etc/systemd/system/
    systemctl enable rangeradmin
    systemctl start rangeradmin.service

fi
