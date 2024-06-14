sudo usermod --append --groups libvirt kni
sudo systemctl enable libvirtd --now
virsh pool-define-as --name default --type dir --target /var/lib/libvirt/images
virsh pool-start default
virsh pool-autostart default

OKD_VERSION=4.15.0-0.okd-2024-03-10-010116
ARCH=x86_64

function butane () {
  podman run --rm --interactive --security-opt label=disable --volume ${PWD}:/pwd --workdir /pwd quay.io/coreos/butane:release --pretty --strict $1 > $2
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

