

# For ubuntu , turn back to  interfaces
export NEEDRESTART_MODE=a
apt update
apt install -y ifupdown net-tools
cp grub /etc/default/grub
update-grub
#
# Figure out which machine in mesh
#
h=$(hostname -s)
interface=interfaces${h: -1}

$brokkr_gotplexe ${interface}.tpl --set eth0=${brokkr_mesh_interface_name["eth0"]} --set eth1=${brokkr_mesh_interface_name["eth1"]} --set eth2=${brokkr_mesh_interface_name["eth2"]} --set eth2=${brokkr_mesh_interface_name["eth2"]} > /etc/network/interfaces

cp ${interface} /etc/network/interfaces
eth0=${brokkr_mesh_interface_name["eth0"]}
ifdown --force ${eth0}
ifup ${eth0}

unlink /etc/resolv.conf
echo nameserver 8.8.8.8 >> /etc/resolv.conf

#sudo dpkg -P cloud-init
rm -fr /etc/cloud/

systemctl disable --now systemd-resolved

