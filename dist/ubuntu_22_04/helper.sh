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

mesh_machine_meship () {
mesh_machine_nr

  return mesh_ip[${nr}]
}

mesh_machine_meship_master () {
  return mesh_ip[1]
}
