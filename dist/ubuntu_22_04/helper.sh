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
