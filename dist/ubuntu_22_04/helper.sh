

mesh_machine () {
  commands
  h=$(hostname)
  interface=interfaces${h: -1}
  return ${interface}
}

