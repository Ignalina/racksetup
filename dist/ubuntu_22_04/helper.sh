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

mesh_ip=("10.15.15.0" "10.15.15.50" "10.15.15.51" "10.15.15.52")
