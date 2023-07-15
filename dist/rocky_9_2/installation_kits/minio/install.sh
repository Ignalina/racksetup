pushd /tmp
wget https://dl.min.io/server/minio/release/linux-amd64/archive/minio-20230324214123.0.0.x86_64.rpm -O minio.rpm
rpm -Uvh minio.rpm
rm minio.rpm
popd
firewall-cmd --zone=public --add-port=9000/tcp --permanent
firewall-cmd --zone=public --add-port=9001/tcp --permanent
firewall-cmd --reload


mkdir -p /var/lib/x14/minio/mnt/disk1/minio
mkdir -p /var/lib/x14/minio/mnt/disk2/minio
mkdir -p /var/lib/x14/minio/mnt/disk3/minio
mkdir -p /var/lib/x14/minio/mnt/disk4/minio

groupadd -r minio-user
useradd -M -r -g minio-user minio-user
chown -R minio-user:minio-user /var/lib/x14/minio/mnt

cp default.minio /etc/default/minio

cp minio.service /etc/systemd/system/
systemctl enable minio

systemctl start minio.service
