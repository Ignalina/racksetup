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

#rm -rf eth0.nmconnection


h=$(hostname -s)
h_number=${h: -1}
h_interface=${brokkr_ethext_interface_name[${h_number}]}
h_ip=${brokkr_ethext_interface_ip[${h_number}]}

$brokkr_gotplexe eth0.nmconnection --set ethext_gatway=${brokkr_ethext_gateway}  --set eth0=${brokkr_net_interface_name["eth0"]} --set eth0_ip=${h_ip} > /etc/NetworkManager/system-connections/${brokkr_net_interface_name["eth0"]}.nmconnection

#systemctl start NetworkManager
#nmcli connection reload
