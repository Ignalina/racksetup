# For ubuntu , turn back to  interfaces

apt update
apt install -y ifupdown net-tools
cp grub /etc/default/grub
update-grub

cp interfaces /etc/network/interfaces

ifdown --force eth0
ifup eth0

unlink /etc/resolv.conf
echo nameserver 8.8.8.8 >> /etc/resolv.conf

#sudo dpkg -P cloud-init
rm -fr /etc/cloud/

systemctl disable --now systemd-resolved

