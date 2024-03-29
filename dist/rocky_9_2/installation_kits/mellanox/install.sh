# DONT FORGET TO SET AFTER UPDATE OR NEW CARD 
# lspci | grep -i mellanox
# sudo mstconfig -d 41:00.0 set LINK_TYPE_P1=2
dnf install -y perl-sigtrap perl-File-* 

#
# Mellanox
yum install -y gcc make lsof pciutils  python2 python36

mkdir /usr/lib/x14/mellanox
chown x14:x14 /usr/lib/x14/mellanox
pushd /usr/lib/x14/mellanox

wget https://linux.mellanox.com/public/repo/mlnx_ofed/latest/rhel9.1/x86_64/mft-4.24.0-72.x86_64.rpm
rpm -i mft-4.24.0-72.x86_64.rpm

wget https://www.mellanox.com/downloads/ofed/MLNX_EN-5.9-0.5.6.0/mlnx-en-5.9-0.5.6.0-rhel9.1-x86_64.tgz

tar -zxf mlnx-en-5.9-0.5.6.0-rhel9.1-x86_64.tgz
pushd mlnx-en-5.9-0.5.6.0-rhel9.1-x86_64
yum install -y perl-sigtrap perl-File-Compare perl-File-Copy
./install --eth-only --force
popd

# to load directly /etc/init.d/mlnx-en.d restart

# sudo mlnx_tune <-- gives info

popd
