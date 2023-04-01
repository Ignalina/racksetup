#!/bin/bash


# Needs be run from dist/ubuntu_22_04 directory
# Known apps minio,spark,ballista,nginx


mesh_machine () {
  h=$(hostname -s)
  interface=interfaces${h: -1}
  return ${interface}
}

mesh_machine_nr () {
  h=$(hostname -s)
  nr=${h: -1}
  return ${nr}
}

mesh_gen_hosts () {
  length=${#brokkr_mesh_name[@]}
 
# use C style for loop syntax to read all values and indexes
  for (( j=1; j<length; j++ ));
  do
    echo  "${brokkr_mesh_ip[$j]} ${brokkr_mesh_name[$j]}" >> /etc/hosts
  done
}

brokkr_app=$1
brokkr_app_param=$2
brokkr_gotplexe=$(go env GOPATH)/bin/gotpl

pushd installation_kits/${brokkr_app}
source ${brokkr_app_param}
source install.sh "${@:3}"
popd
