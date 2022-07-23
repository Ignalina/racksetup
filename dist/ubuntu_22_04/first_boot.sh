#
#
#

# Install packages via apt-get
apt-get install -qy $(cat "toolbox/pkgs/ubuntu-jammy.txt")

# Install packages via PyPI
pip3 install meson ninja pyelftools
