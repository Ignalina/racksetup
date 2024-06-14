#
# PRE:

# 1-install butane , by building it or on fedora "sudo dnf install -y butane"
#
# 2-Setup upp dns 
# zone file extract below --->
# quay  IN      A       10.1.1.108
# api.okd414      IN      A      10.1.1.111
# api-int.okd414  IN      A       10.1.1.111
# *.apps.okd414   IN      A       19.1.1.111
# <--- end of zone file extract
# 3 create an pull-secret.txt from https://console.redhat.com/openshift/install/pull-secret 

OKD_VERSION=4.15.0-0.okd-2024-03-10-010116
ARCH=x86_64

function create-vm () {
cp fcos-live.iso /var/lib/libvirt/images/fcos-live.x86_64.iso

virt-install --name="master-sno" \
    --vcpus=4 \
    --ram=16384 \
    --disk path=${PWD}/master-snp.qcow2,bus=sata,size=120 \
    --network network=default,model=virtio \
    --boot menu=on \
    --console pty,target_type=serial \
    --cpu host-passthrough \
    --cdrom /var/lib/libvirt/images/fcos-live.x86_64.iso \
    --os-variant "fedora-coreos-stable" &
virsh console master-sno &
}


function coreos-installer() {
  podman run --privileged --pull always --rm -v /dev:/dev -v /run/udev:/run/udev -v $PWD:/data -w /data quay.io/coreos/coreos-installer:release $1 $2 $3 $4 $5 $6
}

if [ ! -f oc ]; then
   curl -L https://github.com/okd-project/okd/releases/download/$OKD_VERSION/openshift-client-linux-$OKD_VERSION.tar.gz -o oc.tar.gz
   tar zxf oc.tar.gz
   chmod +x oc
fi

if [ ! -f openshift-install ]; then
   curl -L https://github.com/okd-project/okd/releases/download/$OKD_VERSION/openshift-install-linux-$OKD_VERSION.tar.gz -o openshift-install-linux.tar.gz
   tar zxvf openshift-install-linux.tar.gz
   chmod +x openshift-install
fi

if [ ! -f fcos-live.iso ]; then
   ISO_URL=$(./openshift-install coreos print-stream-json | grep location | grep $ARCH | grep iso | cut -d\" -f4)
   curl -L $ISO_URL -o fcos-live.iso
fi

cp install-config.temple install-config.yaml
echo "pullSecret: '$(<pull-secret.txt)'" >> install-config.yaml

echo "sshKey: |" >> install-config.yaml
echo "  $(<~/.ssh/id_rsa.pub)" >> install-config.yaml

echo "additionalTrustBundle: |" >> install-config.yaml
cat ca.pem >> install-config.yaml



rm -rf sno
mkdir sno
cp install-config.yaml sno

#./openshift-install --dir=sno create manifests

#butane 01-master-custom.bu -o sno/openshift/01-master-custom.yaml
./openshift-install --dir=sno create single-node-ignition-config
coreos-installer iso ignition embed -fi sno/bootstrap-in-place-for-live-iso.ign fcos-live.iso
##butane 01-master-custom.bu -p -r -o 01-master-custom.ign
##coreos-installer iso customize -f --dest-ignition 01-master-custom.ign fcos-live.iso


# Remove this if you manually deploy "cfos-live.iso" to your hardware.
create-vm

# The wait line below only works if IP is resolved by DNS
# 
#./openshift-install --dir=sno wait-for install-complete
