# TODO configurable x14 project/companyname
x14scripts=$(realpath installation_kits/x14scripts)
config=$(realpath default_config)
PATH=${PATH}:${x14scripts}

packages=$(realpath packages.sh)
source ${packages}




