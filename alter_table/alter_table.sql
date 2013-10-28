CREATE DATABASE testing_db;

USE testing_db;

#Create a table named testing_table
CREATE TABLE testing_table
(
  name VARCHAR(50),
  contact_name VARCHAR(50),
  roll_no VARCHAR(20)
);

SHOW COLUMNS FROM testing_table;
-- +--------------+-------------+------+-----+---------+-------+
-- | Field        | Type        | Null | Key | Default | Extra |
-- +--------------+-------------+------+-----+---------+-------+
-- | name         | varchar(50) | YES  |     | NULL    |       |
-- | contact_name | varchar(50) | YES  |     | NULL    |       |
-- | roll_no      | varchar(20) | YES  |     | NULL    |       |
-- +--------------+-------------+------+-----+---------+-------+

#Delete column name
ALTER TABLE testing_table DROP name;

#rename contact_name to username
ALTER TABLE testing_table CHANGE contact_name username VARCHAR(255);

# Add two fields first_name, last_name.
ALTER TABLE testing_table
ADD COLUMN first_name VARCHAR(20),
ADD COLUMN last_name VARCHAR(20);

#change the type of roll_no to integer
ALTER TABLE testing_table
MODIFY roll_no INT;

SHOW COLUMNS FROM testing_table;
-- +--------------+-------------+------+-----+---------+-------+
-- | Field        | Type        | Null | Key | Default | Extra |
-- +--------------+-------------+------+-----+---------+-------+
-- | name         | varchar(50) | YES  |     | NULL    |       |
-- | contact_name | varchar(50) | YES  |     | NULL    |       |
-- | roll_no      | int(11)     | YES  |     | NULL    |       |
-- | first_name   | varchar(20) | YES  |     | NULL    |       |
-- | last_name    | varchar(20) | YES  |     | NULL    |       |
-- +--------------+-------------+------+-----+---------+-------+