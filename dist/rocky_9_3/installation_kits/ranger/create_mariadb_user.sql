CREATE USER 'ranger'@'%' IDENTIFIED BY 'changeme';
GRANT ALL PRIVILEGES ON *.* TO 'ranger'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

ALTER USER 'root'@'%' IDENTIFIED BY 'changeme';
flush privileges;
exit;
