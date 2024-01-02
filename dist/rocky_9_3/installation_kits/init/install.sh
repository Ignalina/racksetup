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

systemctl stop firewalld.service
systemctl disable firewalld.service

mesh_gen_hosts
