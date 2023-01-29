wget https://dl.min.io/server/minio/release/linux-amd64/archive/minio_20230125001954.0.0_amd64.deb -O minio.deb
sudo dpkg -i minio.deb

mkdir -p /var/lib/x14/minio/disk1

groupadd -r minio-user
useradd -M -r -g minio-user minio-user
chown minio-user:minio-user /var/lib/x14/minio/disk1

cp minio.service /etc/systemd/system/
