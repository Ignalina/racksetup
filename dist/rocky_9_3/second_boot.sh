# before cloning and running git is needed by "sudo yum install -y nano git git-lfs"
# TODO configurable x14 project/companyname
x14scripts=$(realpath installation_kits/x14scripts)
config=$(realpath default_config)
PATH=${PATH}:${x14scripts}

packages=$(realpath packages.sh)
source ${packages}



