mesh_machine_nr
nr=$?
if [[ $nr -eq 1 ]]
then
   echo "I AM MASTER_HOST=${brokkr_mesh_ip[1]}"

   yum install -y java-11-openjdk-headless zip
   useradd -s /sbin/nologin -M zeppelin -G x14

   pushd /usr/lib/x14
   mkdir -p /var/lib/x14/zeppelin/
   mkdir -p zeppelin
   pushd zeppelin
   wget https://dlcdn.apache.org/zeppelin/zeppelin-0.10.1/zeppelin-0.10.1-bin-all.tgz
   tar -zxf zeppelin-0.10.1-bin-all.tgz

   popd
   popd
fi
