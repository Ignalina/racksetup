# racksetup X14 minicompute
Automated setup for fast data applience.

| Feature  | Ubuntu 22.04  | Rocky8.7 | Rocky9.2 |
| :------------ |:---------------:| -----:| -----:|
| Iceberg  | y |    n |  y|
| Delta 3.0.0 | n | n | y|
| Minio-S3 | y | n | y|
| Single Minio-S3 | y | y | y|

Optimal setup on baremetall (X14 v2023 using Supermicro+Samsung 9a3/1733/1735+Mellanox ConnectX-6)

| Feature  | Ubuntu 22.04  | Rocky8.7 | Rocky9.2 |
| :------------ |:---------------:| -----:| -----:|
| Redfish OS install | n | n | n|
| Mellanox  | y | y | y|
| Mesh  | y | n | y|

![mesh](https://user-images.githubusercontent.com/33436048/185506672-ce6c84ed-4419-404d-95bf-624016278cbb.svg)





### TODO list
0) DONE install Mellanox , see dist/ubuntu_22_04/first_boot.sh
1) DONE revert ubuntu 22.0 to interfaces instead of netplan
2) DONE Configure mesh according to https://pve.proxmox.com/wiki/Full_Mesh_Network_for_Ceph_Server
3) DONE Instead of reverting , use network manager for mesh config.
4) TODO cleanup remove hardcoded IP etc

Since all of above is fairly automated/scripted I can now proceed bootstrap OS via IPMI

5) setup boot disk + os (cloudinit) via IPMI / redfish

### LICENSE
NVIDIA licensed software,Its either Fetched install time or/and available in this repo as git LFS.

* mft-4.22.1-11-x86_64-deb.tgz
* MLNX_OFED_LINUX-5.8-1.1.2.1-ubuntu22.04-x86_64.tgz
