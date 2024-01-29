dnf -y update
dnf -y install golang wget


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

