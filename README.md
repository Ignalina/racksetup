# racksetup X14 minicompute
Automate OS+DRIVER+MESH setup for servers built on Supermicro+Samsung 1733/1735+Mellanox ConnectX-6
![mesh](https://user-images.githubusercontent.com/33436048/185506672-ce6c84ed-4419-404d-95bf-624016278cbb.svg)


### TODO list
0) DONE install Mellanox , see dist/ubuntu_22_04/first_boot.sh
1) DONE revert ubuntu 22.0 to interfaces instead of netplan
2) DONE Configure mesh according to https://pve.proxmox.com/wiki/Full_Mesh_Network_for_Ceph_Server

Since all of above is fairly automated/scripted I can now proceed to teardown

3) setup boot disk + os (cloudinit) via IPMI / redfish

### LICENSE
NVIDIA licensed software,Its either Fetched install time or/and available in this repo as git LFS.

* mft-4.22.1-11-x86_64-deb.tgz
* MLNX_OFED_LINUX-5.8-1.1.2.1-ubuntu22.04-x86_64.tgz
