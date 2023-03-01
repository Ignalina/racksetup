#!/bin/bash


# Needs be run from dist/ubuntu_22_04 directory
# Known apps minio,spark,ballista,nginx


mesh_machine () {
  h=$(hostname)
  interface=interfaces${h: -1}
  return ${interface}
}

mesh_machine_nr () {
  h=$(hostname)
  nr=${h: -1}
  return ${nr}
}
app=$1
mesh_ip=("10.15.15.0" "10.15.15.50" "10.15.15.51" "10.15.15.52")




pushd installation_kits/${app}
source install.sh
popd
