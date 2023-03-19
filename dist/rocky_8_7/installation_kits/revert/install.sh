

# For ubuntu , turn back to  interfaces
#export NEEDRESTART_MODE=a
yum -y install network-scripts
systemctl stop NetworkManager
systemctl disable NetworkManager


#apt install -y ifupdown net-tools bridge-utils
#cp grub /etc/default/grub
#update-grub
#
# Figure out which machine in mesh
#
h=$(hostname -s)
interface=interfaces${h: -1}

$brokkr_gotplexe ${interface}.tpl --set eth0=${brokkr_mesh_interface_name["eth0"]} --set eth1=${brokkr_mesh_interface_name["eth1"]} --set eth2=${brokkr_mesh_interface_name["eth2"]} --set eth3=${brokkr_mesh_interface_name["eth3"]} > /etc/network/interfaces

ifdown --force eth0
ifup eth0

unlink /etc/resolv.conf
echo nameserver 8.8.8.8 >> /etc/resolv.conf

#sudo dpkg -P cloud-init
#rm -fr /etc/cloud/

#systemctl disable --now systemd-resolved

systemctl enable network
service network restart
