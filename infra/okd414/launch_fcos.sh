#
# create ignation file
#
function butane () {
  podman run --rm --interactive --security-opt label=disable --volume ${PWD}:/pwd --workdir /pwd quay.io/coreos/butane:release --pretty --strict $1 > $2
}

butane example.bu example.ign
#
# fetch image
#
FILE=fedora-coreos-40.20240504.3.0-qemu.x86_64.qcow2
if [ ! -f $FILE ]; then
    echo "Fetching image file"
   wget -nc https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/40.20240504.3.0/x86_64/fedora-coreos-40.20240504.3.0-qemu.x86_64.qcow2.xz
   unxz fedora-coreos-40.20240504.3.0-qemu.x86_64.qcow2.xz
fi
#
# create vm 
#

IGNITION_CONFIG="$PWD/example.ign"
IMAGE="$PWD/fedora-coreos-40.20240504.3.0-qemu.x86_64.qcow2"
VM_NAME="fcos-test-01"
VCPUS="6"
RAM_MB="4096"
STREAM="stable"
DISK_GB="10"
# For x86 / aarch64,
IGNITION_DEVICE_ARG=(--qemu-commandline="-fw_cfg name=opt/com.coreos/config,file=${IGNITION_CONFIG}")

# For s390x / ppc64le,
IGNITION_DEVICE_ARG=(--disk path="${IGNITION_CONFIG}",format=raw,readonly=on,serial=ignition,startup_policy=optional)

# Setup the correct SELinux label to allow access to the config
chcon --verbose --type svirt_home_t ${IGNITION_CONFIG}

virt-install --connect="qemu:///system" --name="${VM_NAME}" --vcpus="${VCPUS}" --memory="${RAM_MB}" \
        --os-variant="fedora-coreos-$STREAM" --import --graphics=none \
        --disk="size=${DISK_GB},backing_store=${IMAGE}" \
        --network bridge=virbr0 "${IGNITION_DEVICE_ARG[@]}"
