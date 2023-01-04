sudo apt-get install -y nano git git-lfs
# DONT FORGET TO SET AFTER UPDATE OR NEW CARD 
# lspci | grep -i mellanox
# sudo mstconfig -d 41:00.0 set LINK_TYPE_P1=2


#
# Mellanox
sudo apt-get install -y gcc make dkms python2

wget https://www.mellanox.com/downloads/MFT/mft-4.22.1-11-x86_64-deb.tgz
tar -zxf mft-4.22.1-11-x86_64-deb.tgz
cd mft-4.22.1-11-x86_64-deb
sudo ./install.sh
cd ..
wget https://www.mellanox.com/downloads/ofed/MLNX_EN-5.7-1.0.2.0/mlnx-en-5.7-1.0.2.0-ubuntu22.04-x86_64.tgz
tar -zxf mlnx-en-5.7-1.0.2.0-ubuntu22.04-x86_64.tgz
cd mlnx-en-5.7-1.0.2.0-ubuntu22.04-x86_64
sudo ./install --eth-only


# to load directly /etc/init.d/mlnx-en.d restart

# sudo mlnx_tune <-- gives info


# For ubuntu , turn back to  interfaces

source revert.sh

# Mount 1735 main storage
sudo mkfs.ext4 -f /dev/nvme1n1
mkdir -p /nvme/s1735_1
mount /dev/nvme1n1 /nvme/s1735_1
