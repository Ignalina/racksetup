#
# xnvme 0.4.0
#

# Install packages via apt-get
apt-get install -qy $(cat "toolbox/pkgs/ubuntu-jammy.txt")

# Install packages via PyPI
pip3 install meson ninja pyelftools


git clone https://github.com/OpenMPDK/xNVMe.git xnvme
cd xnvme
# configure xNVMe and build dependencies (fio, liburing, and SPDK)
meson setup builddir

# build xNVMe
meson compile -C builddir

# install xNVMe
sudo meson install -C builddir

# uninstall xNVMe
# cd builddir && meson --internal uninstall


#
# Mellanox
# warning: below update only works if firmware not too old due to changed nvidia nameing

wget https://www.mellanox.com/downloads/firmware/mlxup/4.20.0/SFX/linux_x64/mlxup
#./mlxup --download-default -y --download-os Linux_x64 --download-type self_extractor
chmod +x mlxsup
sudo ./mlxup --online -y -u

#wget mlnx-en-5.6-2.0.9.0-ubuntu22.04-x86_64.tgz
tar -zxf mlnx-en-5.7-1.0.2.0-ubuntu22.04-x86_64.tgz
cd mlnx-en-5.7-1.0.2.0-ubuntu22.04-x86_64
sudo apt-get install dkms python2
sudo ./install --eth-only
#sudo dpkg -i ../DEBS/mlnx-ofed-kernel-utils_5.6-OFED.5.6.2.0.9.1_amd64.deb mlnx-en-eth-only_5.6-2.0.9.0_all.deb mlnx-tools_5.2.0-0.56209_amd64.deb mstflint_4.16.1-2.56209_amd64.deb mlnx-en-dkms_5.6-2.0.9.0.g9e75856_all.deb mlnx-en-eth-only_5.6-2.0.9.0_all.deb mlnx-en-utils_5.6-2.0.9.0.g9e75856_amd64.deb ofed-scripts_5.6-OFED.5.6.2.0.9_amd64.deb
#sudo dpkg -i  mlnx-tools_5.2.0-0.56209_amd64.deb mstflint_4.16.1-2.56209_amd64.deb mlnx-en-dkms_5.6-2.0.9.0.g9e75856_all.deb mlnx-en-eth-only_5.6-2.0.9.0_all.deb mlnx-en-utils_5.6-2.0.9.0.g9e75856_amd64.deb ofed-scripts_5.6-OFED.5.6.2.0.9_amd64.deb

# sudo mlnx_tune <-- gives info
