# before cloning and running git is needed by "sudo apt-get install -y nano git git-lfs"
# TODO configurable x14 project/companyname

groupadd x14
useradd -s /sbin/nologin -M x14 -G x14

mkdir /usr/lib/x14
chown -R x14:x14 /usr/lib/x14

source install_mellanox.sh
# reverting ubuntus network to traditional for the mesh
source revert.sh

# in future create the md0 here instead of ubuntu installer
# mdadm --create --verbose /dev/md0 --level=0 /dev/nvme1n1 /dev/nvme2n1
# mdadm --detail --scan >> /etc/mdadm.conf

mkfs.xfs -f /dev/md0
mkdir /mnt/newvar
mount  /dev/md0 /mnt/newvar

# move existing var and create x14 
init 1
cp -apx /var/* /mnt/newvar
rm -rf /var/*
mkdir -p /mnt/newvar/lib/x14
chown -R x14:x14 /mnt/newvar/lib/x14
umount /mnt/newvar
echo "/dev/md0 /var xfs defaults 0 1" >> /etc/fstab


reboot



