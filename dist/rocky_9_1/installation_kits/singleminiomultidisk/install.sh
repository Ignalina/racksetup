pushd /tmp
 wget https://dl.min.io/server/minio/release/linux-amd64/archive/minio-20230324214123.0.0.x86_64.rpm -O minio.rpm
 rpm -Uvh minio.rpm
 rm minio.rpm
popd


#mkdir -p /var/lib/x14/minio/mnt/disk1/minio

groupadd -r minio-user
useradd -M -r -g minio-user minio-user
mkdir -p /var/lib/x14/minio/mnt
chown -R minio-user:minio-user /var/lib/x14/minio/mnt

cp default.minio /etc/default/minio
# mdadm --stop /dev/md*
mkfs.xfs /dev/nvme1n1 -L DISK1 -f
mkfs.xfs /dev/nvme2n1 -L DISK2 -f
mkfs.xfs /dev/nvme3n1 -L DISK3 -f
mkfs.xfs /dev/nvme4n1 -L DISK4 -f

mkdir /var/lib/x14/minio/mnt/disk1
mkdir /var/lib/x14/minio/mnt/disk2
mkdir /var/lib/x14/minio/mnt/disk3
mkdir /var/lib/x14/minio/mnt/disk4

chown minio-user:x14 /var/lib/x14/minio/mnt/disk1
chown minio-user:x14 /var/lib/x14/minio/mnt/disk2
chown minio-user:x14 /var/lib/x14/minio/mnt/disk3
chown minio-user:x14 /var/lib/x14/minio/mnt/disk4
cat fstab >> /etc/fstab
mount -a

systemctl enable minio
systemctl start minio.service
