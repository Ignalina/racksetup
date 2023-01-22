# DONT FORGET TO SET AFTER UPDATE OR NEW CARD 
# lspci | grep -i mellanox
# sudo mstconfig -d 41:00.0 set LINK_TYPE_P1=2


#
# Mellanox
export NEEDRESTART_MODE=a
apt-get install -y gcc make dkms python2
mkdir /usr/lib/x14/mellanox
chown x14:x14 /usr/lib/x14/mellanox
pushd /usr/lib/x14/mellanox

wget https://www.mellanox.com/downloads/MFT/mft-4.22.1-11-x86_64-deb.tgz
tar -zxf mft-4.22.1-11-x86_64-deb.tgz
pushd mft-4.22.1-11-x86_64-deb
./install.sh
popd

wget https://www.mellanox.com/downloads/ofed/MLNX_EN-5.7-1.0.2.0/mlnx-en-5.7-1.0.2.0-ubuntu22.04-x86_64.tgz
tar -zxf mlnx-en-5.7-1.0.2.0-ubuntu22.04-x86_64.tgz
pushd mlnx-en-5.7-1.0.2.0-ubuntu22.04-x86_64
./install --eth-only --force
popd

# to load directly /etc/init.d/mlnx-en.d restart

# sudo mlnx_tune <-- gives info

popd
