yum install -y mdadm
mdadm --stop /dev/md*

yes | mdadm --create --verbose /dev/${brokkr_md0} --raid-devices=2 --level=0 /dev/${brokkr_md0_device[0]} /dev/${brokkr_md0_device[1]}
mdadm --detail --scan >> /etc/mdadm.conf
echo "/dev/${brokkr_md0} /var xfs defaults 0 1" >> /etc/fstab
dracut --regenerate-all -f && grub2-mkconfig -o /boot/grub2/grub.cfg

 
