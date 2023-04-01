device=$1
mdadm --create --verbose /dev/${device} --raid-devices=2 --level=0 /dev/${brokkr_md0_device[0]} /dev/${brokkr_md0_device[1]}
mdadm --detail --scan >> /etc/mdadm.conf
echo "/dev/${device} /var xfs defaults 0 1" >> /etc/fstab
update-initramfs -u

 
