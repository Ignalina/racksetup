mesh_machine_nr
nr=$?
if [[ $nr -eq 1 ]]
then
   echo "I AM MASTER_HOST=${brokkr_mesh_ip[1]}"
   dnf -y install nginx
   systemctl enable nginx
   #systemctl start nginx
fi



