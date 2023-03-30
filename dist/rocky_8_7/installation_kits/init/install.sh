dnf -y update
dnf -y install golang wget tar

setenforce 0
SELINUX=disable
SELINUXTYPE=targeted


go install github.com/belitre/gotpl@latest


groupadd x14
useradd -s /sbin/nologin -M x14 -g x14

mkdir /usr/lib/x14
chown -R x14:x14 /usr/lib/x14


mesh_gen_hosts
