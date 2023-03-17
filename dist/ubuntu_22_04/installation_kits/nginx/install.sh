export NEEDRESTART_MODE=a

apt-get -y install nginx
cp *.cfg /etc/nginx/sites-enabled
systemctl enable nginx
systemctl start nginx

