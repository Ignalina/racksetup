[connection]
id={{.eth2}}

type=ethernet
autoconnect-priority=-999
interface-name={{.eth2}}

[ethernet]

[ipv4]
address1=10.15.15.51/24
method=manual
route1=10.15.15.52/32

[ipv6]
addr-gen-mode=eui64
method=auto

[proxy]


