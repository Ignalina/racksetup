
# Creds to  Saša Stamenković umpirsky https://gist.github.com/umpirsky
# Creds to  Steve Sybesma https://gist.github.com/ssybesma
# Script below is totally based on above mentioned users work. Some cleanup has been added.
# Run as root , worked on kubuntu 22.10
#sudo -s
apt-get -y install mdadm
apt-get -y install grub-efi-amd64
sgdisk -z /dev/nvme0n1
sgdisk -z /dev/nvme1n1
sgdisk -z /dev/nvme2n1
sgdisk -n 1:0:+40M -t 1:ef00 -c 1:"EFI System" /dev/nvme0n1
sgdisk -n 2:0:+96G -t 2:fd00 -c 2:"Linux RAID" /dev/nvme0n1
sgdisk -n 3:0:0 -t 3:fd00 -c 3:"Linux RAID" /dev/nvme0n1
sgdisk /dev/nvme0n1 -R /dev/nvme1n1 -G ### REPLICATES TO 2ND NVME AND RANDOMIZES GUID -- APPARENTLY CAN'T BE COMBINED W/ LINE BELOW; TWO VARIANTS FAILED TO COMBINE; NOT IMPORTANT?
sgdisk /dev/nvme0n1 -R /dev/nvme2n1 -G ### REPLICATES TO 3RD NVME AND RANDOMIZES GUID -- APPARENTLY CAN'T BE COMBINED W/ LINE ABOVE; TWO VARIANTS FAILED TO COMBINE; NOT IMPORTANT?
sleep 10
mkfs.fat -F 32 /dev/nvme0n1p1
rm -rf /tmp/nvme0*
mkdir /tmp/nvme0n1p1
mount /dev/nvme0n1p1 /tmp/nvme0n1p1
mkdir /tmp/nvme0n1p1/EFI
umount /dev/nvme0n1p1
# dmsetup table , and dmsetup remove X for prev existing like LVM
mdadm --manage /dev/md0 --stop
mdadm --manage /dev/md1 --stop
mdadm --remove /dev/md0
mdadm --remove /dev/md1
wipefs -a /dev/nvme*n1p1
wipefs -a /dev/nvme*n1p2
wipefs -a /dev/nvme*n1p3

sleep 10
mdadm --create /dev/md0 --force --level=0 --raid-disks=3 /dev/nvme[012]n1p2 ### ERROR RE: MORE DISKS ATTEMPTED (3) THAN ACTUALLY FOUND (2) IF ABOVE SGDISK LINES COMBINED
mdadm --create /dev/md1 --force --level=0 --raid-disks=3 /dev/nvme[012]n1p3 ### ERROR RE: MORE DISKS ATTEMPTED (3) THAN ACTUALLY FOUND (2) IF ABOVE SGDISK LINES COMBINED
sgdisk -z /dev/md0
sgdisk -z /dev/md1
sgdisk -N 1 -t 1:8200 -c 1:"Linux swap" /dev/md0
sgdisk -N 1 -t 1:8300 -c 1:"Linux filesystem" /dev/md1
