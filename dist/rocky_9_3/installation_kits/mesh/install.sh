

systemctl stop NetworkManager

# Figure out which machine in mesh
# NOTE: Hostname is set on prev step (init)
h=$(hostname -s)
interface=interfaces${h: -1}

# to clear out existing
rm -rf ${brokkr_net_interface_name["eth2"]}.nmconnection
rm -rf ${brokkr_net_interface_name["eth3"]}.nmconnection

$brokkr_gotplexe ${interface}eth2.nmconnection --set eth0=${brokkr_net_interface_name["eth0"]} --set eth1=${brokkr_net_interface_name["eth1"]} --set eth2=${brokkr_net_interface_name["eth2"]} --set eth3=${brokkr_net_interface_name["eth3"]} > /etc/NetworkManager/system-connections/${brokkr_net_interface_name["eth2"]}.nmconnection
$brokkr_gotplexe ${interface}eth3.nmconnection --set eth0=${brokkr_net_interface_name["eth0"]} --set eth1=${brokkr_net_interface_name["eth1"]} --set eth2=${brokkr_net_interface_name["eth2"]} --set eth3=${brokkr_net_interface_name["eth3"]} > /etc/NetworkManager/system-connections/${brokkr_net_interface_name["eth3"]}.nmconnection


systemctl start NetworkManager
nmcli connection reload
# NOTE gives error if other side is not up
nmcli con up ${brokkr_net_interface_name["eth2"]}
nmcli con up ${brokkr_net_interface_name["eth3"]}
