dnf -y update
dnf -y install golang wget tar NetworkManager-config-server

setenforce 0
echo "SELINUX=disabled" > /etc/selinux/config
echo "SELINUXTYPE=targeted" >> /etc/selinux/config

go install github.com/belitre/gotpl@latest


groupadd x14
useradd -s /sbin/nologin -M x14 -g x14

mkdir /usr/lib/x14
chown -R x14:x14 /usr/lib/x14
mkdir -p /var/lib/x14
chown -R x14:x14 /var/lib/x14

systemctl stop firewalld
systemctl disable firewalld

### prepare mesh possible setup 
mesh_gen_hosts

### Set hostname and ip number
systemctl stop NetworkManager

h=$(hostname -s)
h_number=${h: -1}
h_interface=${brokkr_eth_ext_interface_name[${h_number}]}
h_ip=${brokkr_eth_ext_interface_ip[${h_number}]}


$brokkr_gotplexe eth_ext.nmconnection --set eth_ext=${h_interface} --set eth_ext_ip=${h_ip}

systemctl start NetworkManager
nmcli connection reload
# NOTE gives error if other side is not up
#nmcli con up ${brokkr_mesh_interface_name["eth2"]}
#nmcli con up ${brokkr_mesh_interface_name["eth3"]}


