wget https://dl.min.io/server/minio/release/linux-amd64/archive/minio_20230125001954.0.0_amd64.deb -O minio.deb
sudo dpkg -i minio.deb

cp minio.service /etc/systemd/system/
