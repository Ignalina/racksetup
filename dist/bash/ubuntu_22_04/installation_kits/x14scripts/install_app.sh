#!/bin/bash

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

apt-get update
apt-get -y install golang-go
go install github.com/belitre/gotpl@latest

brokkr_app=$1
brokkr_app_param=$2
brokkr_gotplexe=$(go env GOPATH)/bin/gotpl



source installation_kits/x14scripts/pki.sh
pushd installation_kits/${brokkr_app}
source ${brokkr_app_param}
source install.sh "${@:3}"
popd
