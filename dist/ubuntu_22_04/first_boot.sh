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
