pushd installation_kits/minio
wget https://dl.min.io/server/minio/release/linux-amd64/archive/minio_20230125001954.0.0_amd64.deb -O minio.deb
sudo dpkg -i minio.deb

mkdir -p /var/lib/x14/minio/mnt/disk1
mkdir -p /var/lib/x14/minio/mnt/disk2
mkdir -p /var/lib/x14/minio/mnt/disk3
mkdir -p /var/lib/x14/minio/mnt/disk4

groupadd -r minio-user
useradd -M -r -g minio-user minio-user
chown -R minio-user:minio-user /var/lib/x14/minio/mnt

cp default.minio /etc/default/minio

cp minio.service /etc/systemd/system/
systemctl enable minio

systemctl start minio.service
popd
