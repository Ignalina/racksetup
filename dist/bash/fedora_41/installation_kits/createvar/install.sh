

mkfs.xfs -f /dev/${brokkr_md0}
mkdir /mnt/newvar
mount  /dev/${brokkr_md0} /mnt/newvar
 
# move existing var and create x14 
# init 1 needed for below
cp -apx /var/* /mnt/newvar
rm -rf /var/*
umount /mnt/newvar
