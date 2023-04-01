# before cloning and running git is needed by "sudo yum install -y nano git git-lfs"
# TODO configurable x14 project/companyname

config=$(realpath default_config)

#./install_app.sh init ${config} 
#./install_app.sh ${config} mellanox ${config}
#./install_app.sh ${config} revert ${config}
./install_app.sh datadisk ${config}
exit

init 1
./install_app.sh createvar ${config}
reboot



