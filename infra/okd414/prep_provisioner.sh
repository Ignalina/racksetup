# From https://docs.okd.io/latest/installing/installing_bare_metal_ipi/ipi-install-installation-workflow.html

sudo rpm-ostree refresh-md
sudo rpm-ostree install libvirt qemu-kvm python3-devel ipmitool
sudo systemctl reboot

