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

#
# TODO Populate this settings from included file
#
brokkr_gotplexe=$(go env GOPATH)/bin/gotpl
brokkr_mesh_ip=("10.15.15.0" "10.15.15.50" "10.15.15.51" "10.15.15.52")
#brokkr_mesh_name=("valkyria" "valkyria1" "valkyria2" "valkyria3")
brokkr_mesh_name=("rv9" "r9v1.x14.se" "r9v2.x14.se" "r9v3.x14.se")
brokkr_mesh_interface=("eth" "eth0" "eth1" "eth2")
declare -A brokkr_mesh_interface_name
#brokkr_mesh_interface_name+=( ["eth0"]=eth0 ["eth1"]=eth1 ["eth2"]=eth2 ["eth3"]=eth3 )
brokkr_mesh_interface_name+=( ["eth0"]=enp6s18 ["eth1"]=enp6s19 ["eth2"]=enp6s20 ["eth3"]=enp6s21 )
#brokkr_md0_device=("nvme1n1" "nvme2n1")
brokkr_md0_device=("vdb" "vdc")


pushd installation_kits/${brokkr_app}
source install.sh
popd
