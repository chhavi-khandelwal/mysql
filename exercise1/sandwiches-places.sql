CREATE DATABASE sandwichesAndLocations;
#Query OK, 1 row affected (0.00 sec)

USE sandwichesAndLocations;
#Database changed

CREATE TABLE Tastes
(
  name VARCHAR(20) NOT NULL,
  filling VARCHAR(20) NOT NULL,
  PRIMARY KEY(name, filling)
);
#Query OK, 0 rows affected (0.15 sec)

SHOW COLUMNS FROM Tastes;
-- +---------+-------------+------+-----+---------+-------+
-- | Field   | Type        | Null | Key | Default | Extra |
-- +---------+-------------+------+-----+---------+-------+
-- | name    | varchar(20) | NO   | PRI | NULL    |       |
-- | filling | varchar(20) | NO   | PRI | NULL    |       |
-- +---------+-------------+------+-----+---------+-------+
-- 2 rows in set (0.00 sec)

INSERT INTO Tastes values
  ('Brown', 'Turkey'),
  ('Brown', 'Beef'),
  ('Brown', 'Ham'),
  ('Jones', 'Cheese'),
  ('Green', 'Beef'),
  ('Green', 'Turkey'),
  ('Green', 'Cheese');
#Query OK, 7 rows affected (0.05 sec)
#Records: 7  Duplicates: 0  Warnings: 0

SELECT * FROM Tastes;
-- +-------+---------+
-- | name  | filling |
-- +-------+---------+
-- | Brown | Beef    |
-- | Brown | Ham     |
-- | Brown | Turkey  |
-- | Green | Beef    |
-- | Green | Cheese  |
-- | Green | Turkey  |
-- | Jones | Cheese  |
-- +-------+---------+
#7 rows in set (0.00 sec)

CREATE TABLE Locations
(
  LNAME VARCHAR(20) NOT NULL,
  PHONE INT(7) NOT NULL,
  ADDRESS VARCHAR(30) NOT NULL,
  PRIMARY KEY(LNAME)
);
#Query OK, 0 rows affected (0.14 sec)

SHOW COLUMNS FROM Locations;
-- +---------+-------------+------+-----+---------+-------+
-- | Field   | Type        | Null | Key | Default | Extra |
-- +---------+-------------+------+-----+---------+-------+
-- | LNAME   | varchar(20) | NO   | PRI | NULL    |       |
-- | PHONE   | int(10)     | NO   |     | NULL    |       |
-- | ADDRESS | varchar(50) | NO   |     | NULL    |       |
-- +---------+-------------+------+-----+---------+-------+
#3 rows in set (0.00 sec)

INSERT INTO Locations VALUES
  ("Lincoln", 6834523, "Lincoln Place"),
  ("O'Neill's", 6742134, "Pearse St"),
  ("Old Nag", 7678132, "Dame St"),
  ("Buttery", 7023421, "College St");
#Query OK, 4 rows affected (0.05 sec)
#Records: 4  Duplicates: 0  Warnings: 0

SELECT * FROM Locations;
-- +-----------+---------+---------------+
-- | LNAME     | PHONE   | ADDRESS       |
-- +-----------+---------+---------------+
-- | Buttery   | 7023421 | College St    |
-- | Lincoln   | 6834523 | Lincoln Place |
-- | O'Neill's | 6742134 | Pearse St     |
-- | Old Nag   | 7678132 | Dame St       |
-- +-----------+---------+---------------+
#4 rows in set (0.00 sec)

CREATE TABLE SANDWICHES
(
  LOCATION VARCHAR(20) NOT NULL,
  BREAD VARCHAR(20) NOT NULL,
  FILLING VARCHAR(20) NOT NULL,
  PRICE DECIMAL(3,2),
  PRIMARY KEY(LOCATION, BREAD, FILLING),
  FOREIGN KEY(LOCATION) REFERENCES Locations(LNAME)
);
#Query OK, 0 rows affected (0.13 sec)

INSERT INTO SANDWICHES VALUES
  ("Lincoln", "Rye", "Ham", 1.25),
  ("O'Neill's", "White", "Cheese", 1.20),
  ("O'Neill's", "Whole", "Ham", 1.25),
  ("Old Nag", "Rye", "Beef", 1.35),
  ("Buttery", "White", "Cheese", 1.00),
  ("O'Neill's", "White", "Turkey", 1.35),
  ("Buttery", "White", "Ham", 1.10),
  ("Lincoln", "Rye", "Beef", 1.35),
  ("Lincoln", "White", "Ham", 1.30),
  ("Old Nag", "Rye", "Ham", 1.40);
#Query OK, 10 rows affected, 10 warnings (0.36 sec)
#Records: 10  Duplicates: 0  Warnings: 10

SELECT * FROM SANDWICHES;
-- +-----------+-------+---------+-------+
-- | LOCATION  | BREAD | FILLING | PRICE |
-- +-----------+-------+---------+-------+
-- | Buttery   | White | Cheese  |  1.00 |
-- | Buttery   | White | Ham     |  1.10 |
-- | Lincoln   | Rye   | Beef    |  1.35 |
-- | Lincoln   | Rye   | Ham     |  1.25 |
-- | Lincoln   | White | Ham     |  1.30 |
-- | O'Neill's | White | Cheese  |  1.20 |
-- | O'Neill's | White | Turkey  |  1.35 |
-- | O'Neill's | Whole | Ham     |  1.25 |
-- | Old Nag   | Rye   | Beef    |  1.35 |
-- | Old Nag   | Rye   | Ham     |  1.40 |
-- +-----------+-------+---------+-------+
#10 rows in set (0.00 sec)

#SQL statements to retrieve places where Jones can eat (using a nested subquery)

SELECT LOCATION FROM SANDWICHES WHERE filling in (SELECT filling FROM Tastes WHERE name = "Jones");
-- +-----------+
-- | LOCATION  |
-- +-----------+
-- | Buttery   |
-- | O'Neill's |
-- +-----------+
#2 rows in set (0.01 sec)

#SQL statements to retrieve places where Jones can eat (without using a nested subquery) 

SELECT LOCATION FROM SANDWICHES NATURAL JOIN Tastes WHERE Tastes.name = "Jones";
-- +-----------+
-- | LOCATION  |
-- +-----------+
-- | Buttery   |
-- | O'Neill's |
-- +-----------+
#2 rows in set (0.00 sec)

#SQL statements to retrieve for each location the number of people who can eat there

SELECT LOCATION, COUNT(DISTINCT name) FROM SANDWICHES NATURAL JOIN Tastes GROUP BY LOCATION;
-- +-----------+----------------------+
-- | LOCATION  | COUNT(DISTINCT name) |
-- +-----------+----------------------+
-- | Buttery   |                    3 |
-- | Lincoln   |                    2 |
-- | O'Neill's |                    3 |
-- | Old Nag   |                    2 |
-- +-----------+----------------------+
#4 rows in set (0.01 sec)