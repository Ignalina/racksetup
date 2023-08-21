# before cloning and running git is needed by "sudo yum install -y nano git git-lfs"
# TODO configurable x14 project/companyname
x14scripts=$(realpath installation_kits/x14scripts)
config=$(realpath default_config)

${x14scripts}/install_app.sh init ${config} 
${x14scripts}/install_app.sh mellanox ${config}
#./install_app.sh mesh ${config}
${x14scripts}/install_app.sh datadisk ${config}

init 1
${x14scripts}/install_app.sh createvar ${config}
reboot



