CREATE DATABASE bank;
-- Query OK, 1 row affected (0.00 sec)

USE bank;
-- Database Changed

CREATE TABLE users 
(   
	id INT AUTO_INCREMENT,   
	name VARCHAR(20) NOT NULL,   
	email VARCHAR(20) NOT NULL, 
	PRIMARY KEY(id)
);
-- Query OK, 0 rows affected (0.17 sec)

DESC users;
-- +-------+-------------+------+-----+---------+----------------+
-- | Field | Type        | Null | Key | Default | Extra          |
-- +-------+-------------+------+-----+---------+----------------+
-- | id    | int(11)     | NO   | PRI | NULL    | auto_increment |
-- | name  | varchar(20) | NO   |     | NULL    |                |
-- | email | varchar(20) | NO   |     | NULL    |                |
-- +-------+-------------+------+-----+---------+----------------+
-- 3 rows in set (0.00 sec)

INSERT INTO users 
(name, email) VALUES 
("userA", "a@gmail.com"), 
("userB", "b@gmail.com");
-- Query OK, 2 rows affected (0.05 sec)
-- Records: 2  Duplicates: 0  Warnings: 0

SELECT * FROM users;
-- +----+-------+-------------+
-- | id | name  | email       |
-- +----+-------+-------------+
-- |  1 | userA | a@gmail.com |
-- |  2 | userB | b@gmail.com |
-- +----+-------+-------------+
-- 2 rows in set (0.00 sec)

CREATE TABLE accounts
(   
	id INT AUTO_INCREMENT,
	account_no BIGINT(20) UNSIGNED NOT NULL,  
	balance DECIMAL(22,2) NOT NULL,
	user_id INT NOT NULL,
	PRIMARY KEY(id), 
	FOREIGN KEY(user_id) REFERENCES users(id)
);

DESC accounts;
-- +------------+---------------------+------+-----+---------+----------------+
-- | Field      | Type                | Null | Key | Default | Extra          |
-- +------------+---------------------+------+-----+---------+----------------+
-- | id         | int(11)             | NO   | PRI | NULL    | auto_increment |
-- | account_no | bigint(15) unsigned | NO   |     | NULL    |                |
-- | balance    | decimal(22,2)       | NO   |     | NULL    |                |
-- | user_id    | int(11)             | NO   | MUL | NULL    |                |
-- +------------+---------------------+------+-----+---------+----------------+
-- 4 rows in set (0.00 sec)


INSERT INTO accounts 
(account_no, balance, user_id) VALUES 
(123456, 4000.00, 1), 
(123457, 3000.00, 2);
-- Query OK, 2 rows affected (0.07 sec)
-- Records: 2  Duplicates: 0  Warnings: 0

SELECT * FROM accounts;
-- +----+------------+---------+---------+
-- | id | account_no | balance | user_id |
-- +----+------------+---------+---------+
-- |  1 |     123456 | 4000.00 |       1 |
-- |  2 |     123457 | 3000.00 |       2 |
-- +----+------------+---------+---------+
-- 2 rows in set (0.00 sec)


-- Queries:
-- Insert some raw data and do the following queries using mysql transaction statement:

-- i) userA is depositing 1000 Rs. his account
START TRANSACTION;
-- Query OK, 0 rows affected (0.00 sec)

SELECT * FROM users u INNER JOIN accounts a ON u.id = a.user_id FOR UPDATE;
-- +----+-------+-------------+----+------------+---------+---------+
-- | id | name  | email       | id | account_no | balance | user_id |
-- +----+-------+-------------+----+------------+---------+---------+
-- |  1 | userA | a@gmail.com |  1 |     123456 | 4000.00 |       1 |
-- |  2 | userB | b@gmail.com |  2 |     123457 | 3000.00 |       2 |
-- +----+-------+-------------+----+------------+---------+---------+
-- 2 rows in set (0.00 sec)

UPDATE users u INNER JOIN accounts a ON u.id = a.user_id SET a.balance = a.balance + 1000 WHERE name = "userA";
-- Query OK, 1 row affected (0.00 sec)
-- Rows matched: 1  Changed: 1  Warnings: 0

COMMIT;
-- Query OK, 0 rows affected (0.04 sec)

SELECT * FROM accounts;
-- +----+------------+---------+---------+
-- | id | account_no | balance | user_id |
-- +----+------------+---------+---------+
-- |  1 |     123456 | 5000.00 |       1 |
-- |  2 |     123457 | 3000.00 |       2 |
-- +----+------------+---------+---------+
-- 2 rows in set (0.00 sec)

-- ii) userA is withdrawing 500 Rs.
START TRANSACTION;
-- Query OK, 0 rows affected (0.00 sec)

SELECT * FROM users u INNER JOIN accounts a ON u.id = a.user_id FOR UPDATE;
-- +----+-------+-------------+----+------------+---------+---------+
-- | id | name  | email       | id | account_no | balance | user_id |
-- +----+-------+-------------+----+------------+---------+---------+
-- |  1 | userA | a@gmail.com |  1 |     123456 | 5000.00 |       1 |
-- |  2 | userB | b@gmail.com |  2 |     123457 | 3000.00 |       2 |
-- +----+-------+-------------+----+------------+---------+---------+
-- 2 rows in set (0.00 sec)



UPDATE users u INNER JOIN accounts a ON u.id = a.user_id SET a.balance = a.balance - 500 WHERE name = "userA" AND a.balance >= 500 ;
-- Query OK, 1 row affected (0.00 sec)
-- Rows matched: 1  Changed: 1  Warnings: 0

COMMIT;
-- Query OK, 0 rows affected (0.04 sec)

SELECT * FROM accounts;
-- +----+------------+---------+---------+
-- | id | account_no | balance | user_id |
-- +----+------------+---------+---------+
-- |  1 |     123456 | 4500.00 |       1 |
-- |  2 |     123457 | 3000.00 |       2 |
-- +----+------------+---------+---------+
-- 2 rows in set (0.00 sec)

-- iii) userA is transferring 200 Rs to userB's account

 START TRANSACTION;
-- Query OK, 0 rows affected (0.00 sec)

SELECT * FROM users u INNER JOIN accounts a ON u.id = a.user_id FOR UPDATE;
-- +----+-------+-------------+----+------------+---------+---------+
-- | id | name  | email       | id | account_no | balance | user_id |
-- +----+-------+-------------+----+------------+---------+---------+
-- |  1 | userA | a@gmail.com |  1 |     123456 | 4500.00 |       1 |
-- |  2 | userB | b@gmail.com |  2 |     123457 | 3000.00 |       2 |
-- +----+-------+-------------+----+------------+---------+---------+
-- 2 rows in set (0.00 sec)


SELECT a.balance INTO @balance FROM users u INNER JOIN accounts a ON u.id = a.user_id WHERE name = "userA";

UPDATE users u INNER JOIN accounts a ON u.id = a.user_id SET a.balance = a.balance - 200 WHERE name = "userA" AND @balance >= 200;
-- Query OK, 1 row affected (0.00 sec)
-- Rows matched: 1  Changed: 1  Warnings: 0

UPDATE users u INNER JOIN accounts a ON u.id = a.user_id SET a.balance = a.balance + 200 WHERE name = "userB" AND @balance >= 200;
-- Query OK, 1 row affected (0.00 sec)
-- Rows matched: 1  Changed: 1  Warnings: 0

COMMIT;
-- Query OK, 0 rows affected (0.05 sec)

select * from accounts;
-- +----+------------+---------+---------+
-- | id | account_no | balance | user_id |
-- +----+------------+---------+---------+
-- |  1 |     123456 | 4300.00 |       1 |
-- |  2 |     123457 | 3200.00 |       2 |
-- +----+------------+---------+---------+
-- 2 rows in set (0.00 sec)
