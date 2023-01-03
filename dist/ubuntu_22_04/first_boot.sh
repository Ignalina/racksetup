sudo apt-get install -y nano git git-lfs

#
# Mellanox
wget https://www.mellanox.com/downloads/MFT/mft-4.22.1-11-x86_64-deb.tgz
tar -zxf mft-4.22.1-11-x86_64-deb.tgz
cd mft-4.22.1-11-x86_64-deb
sudo ./install.sh
cd ..
#wget mlnx-en-5.7-1.0.2.0-ubuntu22.04-x86_64.tgz
tar -zxf MLNX_OFED_LINUX-5.8-1.1.2.1-ubuntu22.04-x86_64.tgz
cd MLNX_OFED_LINUX-5.8-1.1.2.1-ubuntu22.04-x86_64
sudo apt-get install dkms python2
sudo ./install --eth-only

# sudo mlnx_tune <-- gives info


# For ubuntu , turn back to  interfaces

source revert.sh

# Mount 
sudo mkfs.ext4 /dev/nvme2n1
