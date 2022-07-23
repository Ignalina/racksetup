#
#
#

# Install packages via apt-get
apt-get install -qy $(cat "toolbox/pkgs/ubuntu-jammy.txt")

# Install packages via PyPI
pip3 install meson ninja pyelftools

# configure xNVMe and build dependencies (fio, liburing, and SPDK)
meson setup builddir

# build xNVMe
meson compile -C builddir

# install xNVMe
meson install -C builddir

# uninstall xNVMe
# cd builddir && meson --internal uninstall
