# racksetup
Automate OS+DRIVER+MESH setup for servers built on Supermicro+Samsung 1733/1735+Mellanox ConnectX-6


0) DONE install xnvme + Mellanox , see dist/ubuntu_22_04/first_boot.sh
1) DONE revert ubuntu 22.0 to interfaces instead of netplan
2) DONE Configure mesh according to https://pve.proxmox.com/wiki/Full_Mesh_Network_for_Ceph_Server

Since all of above is fairly automated/scripted I can now proceed to teardown

3) setup boot disk + os (cloudinit) via IPMI / redfish
