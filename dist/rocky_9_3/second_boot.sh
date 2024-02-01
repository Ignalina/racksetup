# before cloning and running git is needed by "sudo yum install -y nano git git-lfs"
# TODO configurable x14 project/companyname
x14scripts=$(realpath installation_kits/x14scripts)
config=$(realpath default_config)
PATH=${PATH}:${x14scripts}
echo ${PATH}

#install_app.sh zk ${config}
#install_app.sh solr ${config}
#install_app.sh nginx ${config}
#install_app.sh admindb ${config}
#install_app.sh singleminio ${config}
#install_app.sh spark ${config}
#install_app.sh delta ${config}
#install_app.sh kyuubi ${config}
install_app.sh ranger ${config}



