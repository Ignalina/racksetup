# before cloning and running git is needed by "sudo apt-get install -y nano git git-lfs"
# TODO configurable x14 project/companyname
#apt-get -y install golang-go
#go install github.com/belitre/gotpl@latest


#groupadd x14
#useradd -s /sbin/nologin -M x14 -g x14

#mkdir /usr/lib/x14
#chown -R x14:x14 /usr/lib/x14

#cat append.hosts >> /etc/hosts

#install_app mellanox
./install_app revert
./install_app datadisk


init 1


./install_app createvar
reboot



