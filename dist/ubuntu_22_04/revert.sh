# For ubuntu , turn back to  interfaces

sudo apt update
sudo apt install -y ifupdown net-tools
sodu cp grub /etc/default/grub
sudo update-grub

sudo cp interfaces /etc/network/interfaces

sudo ifdown --force eth0
sudo ifup eth0

sudo unlink /etc/resolv.conf
sudo echo nameserver 8.8.8.8 >> /etc/resolv.conf

#sudo dpkg -P cloud-init
sudo rm -fr /etc/cloud/

sudo systemctl disable --now systemd-resolved

