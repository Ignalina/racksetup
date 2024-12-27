mesh_machine_nr
nr=$?

if [[ ${nr} -eq 1 ]]
then 
    echo "I AM MASTER_HOST=${brokkr_mesh_ip[1]}"

    dnf install -y mariadb-server expect
    systemctl start mariadb
    systemctl enable mariadb

    SECURE_MYSQL=$(expect -c "
       set timeout 10
       spawn mysql_secure_installation

       expect \"Enter current password for root (enter for none): \"
       send \"n\r\"
       expect \"Switch to unix_socket authentication \[Y/n\] \"
       send \"n\r\"
       expect \"Change the root password? \[Y/n\] \"
       send \"y\r\"
       expect \"New password: \"
       send \"123456\r\"
       expect \"Re-enter new password: \"
       send \"123456\r\"
       expect \"Remove anonymous users? \[Y/n\] \"
       send \"y\r\"
       expect \"Disallow root login remotely? \[Y/n\] \"
       send \"y\r\"
       expect \"Remove test database and access to it? \[Y/n\] \"
       send \"y\r\"
       expect \"Reload privilege tables now? \[Y/n\] \"
       send \"y\r\"
       expect eof
    ")
    # initial setup has been done . turn off so docker build process works etc..
systemctl stop mariadb

fi

#mysqladmin -u root -p version
