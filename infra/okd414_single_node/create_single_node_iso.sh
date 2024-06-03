OKD_VERSION=4.15.0-0.okd-2024-03-10-010116
ARCH=x86_64


function cores-installer() {
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

mkdir sno
cp install-config.yaml sno
./openshift-install --dir=sno create single-node-ignition-config

coreos-installer iso ignition embed -fi sno/bootstrap-in-place-for-live-iso.ign fcos-live.iso

