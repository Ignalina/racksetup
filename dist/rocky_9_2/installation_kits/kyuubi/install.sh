mesh_machine_nr
nr=$?
if [[ $nr -eq 1 ]]
then
   echo "I AM MASTER_HOST=${brokkr_mesh_ip[1]}"

   yum install -y java-11-openjdk-headless zip
   useradd -s /sbin/nologin -M kyuubi -G x14

   pushd /usr/lib/x14
   mkdir -p /var/lib/x14/kyuubi/
   mkdir -p kyuubi
   pushd kyuubi
   wget https://dlcdn.apache.org/kyuubi/kyuubi-1.7.0/apache-kyuubi-1.7.0-bin.tgz
   tar -zxf apache-kyuubi-1.7.0-bin.tgz

   popd
   popd
fi
