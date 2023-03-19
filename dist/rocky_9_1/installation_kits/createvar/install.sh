

mkfs.xfs -f /dev/md0
mkdir /mnt/newvar
mount  /dev/md0 /mnt/newvar
 
# move existing var and create x14 
# init 1 needed for below
cp -apx /var/* /mnt/newvar
rm -rf /var/*
mkdir -p /mnt/newvar/lib/x14
chown -R x14:x14 /mnt/newvar/lib/x14
umount /mnt/newvar
