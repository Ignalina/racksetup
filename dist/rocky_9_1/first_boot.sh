# before cloning and running git is needed by "sudo apt-get install -y nano git git-lfs"
# TODO configurable x14 project/companyname
yum -y update
yum -y install golang-go
go install github.com/belitre/gotpl@latest


groupadd x14
useradd -s /sbin/nologin -M x14 -g x14

mkdir /usr/lib/x14
chown -R x14:x14 /usr/lib/x14

cat append.hosts >> /etc/hosts

./install_app.sh mellanox
#./install_app.sh revert
./install_app.sh datadisk


init 1
./install_app.sh createvar
reboot



