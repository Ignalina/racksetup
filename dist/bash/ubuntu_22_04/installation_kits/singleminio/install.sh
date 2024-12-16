pushd /tmp
 wget https://dl.min.io/server/minio/release/linux-amd64/archive/minio_20230504214430.0.0_amd64.deb -O minio.deb
 dpkg -i minio.deb
 rm minio.deb
popd

#firewall-cmd --zone=public --add-port=9000/tcp --permanent
#firewall-cmd --zone=public --add-port=9001/tcp --permanent
#firewall-cmd --reload


mkdir -p /var/lib/x14/minio/mnt/disk1/minio

groupadd -r minio-user
useradd -M -r -g minio-user minio-user
mkdir -p /var/lib/x14/minio/mnt
chown -R minio-user:minio-user /var/lib/x14/minio/mnt

mv -f default.minio /etc/default/minio

systemctl enable minio
systemctl start minio.service
