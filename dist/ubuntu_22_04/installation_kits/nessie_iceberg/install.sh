
mesh_machine_nr
nr=$?
if [[ $nr -eq 1 ]]
then
   echo "I AM MASTER"
   useradd -s /sbin/nologin -M nessie -G x14


   apt-get -y install rocksdb-tools ant
   cp build.xml /tmp
   cp ivy.xml /tmp
   pushd /usr/lib/x14
  
   mkdir nessie
   pushd nessie

   wget https://dlcdn.apache.org//ant/ivy/2.5.1/apache-ivy-2.5.1-bin-with-deps.zip
   unzip apache-ivy-2.5.1-bin-with-deps.zip
   cp /tmp/build.xml .
   cp /tmp/ivy.xml .
   ant resolve
   cp lib/*.jar /usr/lib/x14/spark/spark-3.3.2-bin-hadoop3-scala2.13/jars/


   wget https://github.com/projectnessie/nessie/releases/download/nessie-0.51.1/nessie-quarkus-0.51.1-runner
   chmod +x nessie-quarkus-0.51.1-runner
   popd
   popd
   cp nessie.service /etc/systemd/system/
   systemctl enable nessie

   chown -R nessie:x14 /usr/lib/x14/nessie
   systemctl stop spark
   systemctl start nessie
   systemctl start spark

fi
