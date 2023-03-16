
mesh_machine_nr
nr=$?
if [[ $nr -eq 1 ]]
then
   echo "I AM MASTER"
   useradd -s /sbin/nologin -M nessie -G x14


   apt-get -y install rocksdb-tools ant
   pushd /usr/lib/x14
   wget https://dlcdn.apache.org//ant/ivy/2.5.1/apache-ivy-2.5.1-bin-with-deps.zip
   unzip apache-ivy-2.5.1-bin-with-deps.zip
   ant resolve
   cp lib/*.jar /usr/lib/x14/spark/jar/

   mkdir nessie
   pushd nessie
   wget https://github.com/projectnessie/nessie/releases/download/nessie-0.51.1/nessie-quarkus-0.51.1-runner
   chmod +x
   cp nessie.service /etc/systemd/system/
   systemctl enable nessie
   popd
   popd
   chown -R nessie:x14 /usr/lib/x14/nessie
   systemctl start nessie


fi
