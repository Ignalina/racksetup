# TODO configurable x14 project/companyname
x14scripts=$(realpath installation_kits/x14scripts)
config=$(realpath default_config)
PATH=${PATH}:${x14scripts}
echo ${PATH}

install_app.sh init ${config}
#install_app.sh mellanox ${config}
#install_app.sh mesh ${config}
#install_app.sh datadisk ${config}

#init 1
#install_app.sh createvar ${config}
reboot



