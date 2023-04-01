# before cloning and running git is needed by "sudo apt-get install -y nano git git-lfs"
# TODO configurable x14 project/companyname

./install_app.sh init
./install_app.sh mellanox
./install_app.sh revert
./install_app.sh datadisk md0


init 1
./install_app.sh createvar md0
reboot



