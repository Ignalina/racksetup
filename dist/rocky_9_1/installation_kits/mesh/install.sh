

# For ubuntu , turn back to  interfaces
systemctl stop NetworkManager

# Figure out which machine in mesh
#
h=$(hostname -s)
interface=interfaces${h: -1}


rm -rf ${brokkr_mesh_interface_name["eth2"]}.nmconnection
rm -rf ${brokkr_mesh_interface_name["eth3"]}.nmconnection

$brokkr_gotplexe ${interface}eth2.nmconnection --set eth0=${brokkr_mesh_interface_name["eth0"]} --set eth1=${brokkr_mesh_interface_name["eth1"]} --set eth2=${brokkr_mesh_interface_name["eth2"]} --set eth3=${brokkr_mesh_interface_name["eth3"]} > /etc/NetworkManager/system-connections/${brokkr_mesh_interface_name["eth2"]}.nmconnection
$brokkr_gotplexe ${interface}eth3.nmconnection --set eth0=${brokkr_mesh_interface_name["eth0"]} --set eth1=${brokkr_mesh_interface_name["eth1"]} --set eth2=${brokkr_mesh_interface_name["eth2"]} --set eth3=${brokkr_mesh_interface_name["eth3"]} > /etc/NetworkManager/system-connections/${brokkr_mesh_interface_name["eth3"]}.nmconnection


systemctl start NetworkManager
nmcli connection reload
