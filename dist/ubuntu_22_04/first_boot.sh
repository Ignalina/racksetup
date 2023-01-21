# before cloning and running git is needed by "sudo apt-get install -y nano git git-lfs"

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
umount /mnt/newvar
echo "/dev/md0 /var xfs defaults 0 1" >> /etc/fstab

# create
mkdir /usr/lib/x14

reboot



