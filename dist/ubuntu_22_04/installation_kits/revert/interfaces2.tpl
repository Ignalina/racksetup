source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug eth0
iface eth0 inet dhcp


# MESH

iface eth1 inet manual


# Connected to Node3 (.52)
auto eth2
iface eth2 inet static
        address  10.15.15.51
        netmask  255.255.255.0
        up ip route add 10.15.15.52/32 dev {{.eth2}}
        down ip route del 10.15.15.52/32

# Connected to Node1 (.50)
auto eth3
iface eth3 inet static
        address  10.15.15.51
        netmask  255.255.255.0
        up ip route add 10.15.15.50/32 dev {{.eth3}}
        down ip route del 10.15.15.50/32

auto vmbr0
iface vmbr0 inet static
        address  192.168.2.51
        netmask  255.255.240.0
        gateway  192.168.2.1
        bridge_ports eth1
        bridge_stp off
        bridge_fd 0
