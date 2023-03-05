mdadm --create --verbose /dev/md0 --level=0 /dev/${brokkr_md0_device[0]} /dev/${brokr_md0_device[1]}
mdadm --detail --scan >> /etc/mdadm.conf
echo "/dev/md0 /var xfs defaults 0 1" >> /etc/fstab

 
