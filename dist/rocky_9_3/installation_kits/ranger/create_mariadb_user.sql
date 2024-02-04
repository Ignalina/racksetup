CREATE USER 'ranger'@'%' IDENTIFIED BY 'changeme';
GRANT ALL PRIVILEGES ON *.* TO 'ranger'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE USER 'ranger'@'localhost' IDENTIFIED BY 'changeme';
GRANT ALL PRIVILEGES ON *.* TO 'ranger'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

ALTER USER 'root'@'%' IDENTIFIED BY 'changeme';
flush privileges;
exit;

ALTER USER 'root'@'localhost' IDENTIFIED BY 'changeme';
flush privileges;
exit;
