CREATE DATABASE vtapp;
#Query OK, 1 row affected (0.00 sec)

USE vtapp;
#Database changed

CREATE USER 'vtapp_user'@'localhost' IDENTIFIED BY 'my_pass';
#Query OK, 0 rows affected (0.00 sec)

GRANT ALL PRIVILEGES ON vtapp.* TO 'vtapp_user'@'localhost'
  WITH GRANT OPTION;
#Query OK, 0 rows affected (0.00 sec)