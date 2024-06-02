# From https://docs.okd.io/latest/installing/installing_bare_metal_ipi/ipi-install-installation-workflow.html

sudo useradd kni
#passwd kni
echo "kni ALL=(root) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/kni
sudo chmod 0440 /etc/sudoers.d/kni
sudo su - kni -c "mkdir /home/kni/.ssh"
sudo su - kni -c "ssh-keygen -t ed25519 -f /home/kni/.ssh/id_rsa -N ''"
sudo su - kni
sudo dnf install -y libvirt qemu-kvm mkisofs python3-devel jq ipmitool

sudo usermod --append --groups libvirt kni
sudo systemctl start firewalld
sudo firewall-cmd --zone=public --add-service=http --permanent
sudo firewall-cmd --reload
sudo systemctl enable libvirtd --now
sudo virsh pool-define-as --name default --type dir --target /var/lib/libvirt/images
sudo virsh pool-start default
sudo virsh pool-autostart default
sudo mkdir /var/home/kni/.ssh
sudo cp id_rsa.pub /var/home/kni/.ssh/
sudo chown -R kni: /var/home/kni/.ssh

