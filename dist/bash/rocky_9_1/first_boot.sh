# before cloning and running git is needed by "sudo yum install -y nano git git-lfs"
# TODO configurable x14 project/companyname

config=$(realpath default_config)

./install_app.sh init ${config} 
./install_app.sh mellanox ${config}
#./install_app.sh mesh ${config}
./install_app.sh datadisk ${config}

init 1
./install_app.sh createvar ${config}
reboot



