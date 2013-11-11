CREATE DATABASE library;
#Query OK, 1 row affected (0.00 sec)

USE library;
#Database changed

CREATE TABLE Branch
(
  BCode VARCHAR(20) NOT NULL,
  Librarian VARCHAR(20) NOT NULL,
  Holdings VARCHAR(30) NOT NULL,
  PRIMARY KEY(BCode)
);
#Query OK, 0 rows affected (0.11 sec)

SHOW COLUMNS FROM Branch;
-- +-----------+-------------+------+-----+---------+-------+
-- | Field     | Type        | Null | Key | Default | Extra |
-- +-----------+-------------+------+-----+---------+-------+
-- | BCode     | varchar(20) | NO   | PRI | NULL    |       |
-- | Librarian | varchar(20) | NO   |     | NULL    |       |
-- | Holdings  | varchar(30) | NO   |     | NULL    |       |
-- +-----------+-------------+------+-----+---------+-------+
-- 3 rows in set (0.00 sec)

INSERT INTO Branch VALUES
  ("B1", "John Smith", "2 Anglesea Rd"),
  ("B2", "Mary Jones", "34 Pearse St"),
  ("B3", "Francis Owens", "Grange X");
-- Query OK, 3 rows affected (0.05 sec)
-- Records: 3  Duplicates: 0  Warnings: 0

SELECT * FROM Branch;
-- +-------+---------------+---------------+
-- | BCode | Librarian     | Holdings      |
-- +-------+---------------+---------------+
-- | B1    | John Smith    | 2 Anglesea Rd |
-- | B2    | Mary Jones    | 34 Pearse St  |
-- | B3    | Francis Owens | Grange X      |
-- +-------+---------------+---------------+
-- 3 rows in set (0.00 sec)

CREATE TABLE Titles
  (
    Title VARCHAR(20) NOT NULL,
    Author VARCHAR(20) NOT NULL,
    Publisher VARCHAR(20) NOT NULL,
    PRIMARY KEY(Title)
  );

SHOW COLUMNS FROM Titles;
-- +-----------+-------------+------+-----+---------+-------+
-- | Field     | Type        | Null | Key | Default | Extra |
-- +-----------+-------------+------+-----+---------+-------+
-- | Title     | varchar(20) | NO   | PRI | NULL    |       |
-- | Author    | varchar(20) | NO   |     | NULL    |       |
-- | Publisher | varchar(20) | NO   |     | NULL    |       |
-- +-----------+-------------+------+-----+---------+-------+
-- 3 rows in set (0.00 sec)

INSERT INTO Titles VALUES
  ("Susannah", "Ann Brown", "Macmillan"),
  ("How to Fish", "Amy Fly", "Stop Press"),
  ("A History of Dublin", "David Little", "Wiley"),
  ("Computers", "Blaise Pascal", "Applewoods"),
  ("The Wife", "Ann Brown", "Macmillan");
-- Query OK, 5 rows affected (0.05 sec)
-- Records: 5  Duplicates: 0  Warnings: 0

SELECT * FROM Titles;
-- +---------------------+---------------+------------+
-- | Title               | Author        | Publisher  |
-- +---------------------+---------------+------------+
-- | A History of Dublin | David Little  | Wiley      |
-- | Computers           | Blaise Pascal | Applewoods |
-- | How to Fish         | Amy Fly       | Stop Press |
-- | Susannah            | Ann Brown     | Macmillan  |
-- | The Wife            | Ann Brown     | Macmillan  |
-- +---------------------+---------------+------------+
-- 5 rows in set (0.00 sec)

CREATE TABLE Holdings
(
  branch VARCHAR(4),
  Title VARCHAR(20),
  `#copies` TINYINT NOT NULL,
  PRIMARY KEY(branch, Title),
  FOREIGN KEY(branch) REFERENCES Branch(BCode),
  FOREIGN KEY(Title) REFERENCES Titles(Title)
);
-- Query OK, 0 rows affected (0.20 sec)

SHOW COLUMNS FROM Holdings;
-- +---------+-------------+------+-----+---------+-------+
-- | Field   | Type        | Null | Key | Default | Extra |
-- +---------+-------------+------+-----+---------+-------+
-- | branch  | varchar(4)  | NO   | PRI |         |       |
-- | Title   | varchar(20) | NO   | PRI |         |       |
-- | #copies | tinyint(4)  | NO   |     | NULL    |       |
-- +---------+-------------+------+-----+---------+-------+
-- 3 rows in set (0.00 sec)

INSERT INTO Holdings VALUES
  ("B1", "Susannah", 3),
  ("B1", "How to Fish", 2),
  ("B1", "A History of Dublin", 1),
  ("B2", "How to Fish", 4),
  ("B2", "Computers", 2),
  ("B2", "The Wife", 3),
  ("B3", "A History Of Dublin", 1),
  ("B3", "Computers", 4),
  ("B3", "Susannah", 3),
  ("B3", "The Wife", 1);
-- Query OK, 10 rows affected (0.04 sec)
-- Records: 10  Duplicates: 0  Warnings: 0

SELECT * FROM Holdings;
-- +--------+---------------------+---------+
-- | branch | Title               | #copies |
-- +--------+---------------------+---------+
-- | B1     | A History of Dublin |       1 |
-- | B1     | How to Fish         |       2 |
-- | B1     | Susannah            |       3 |
-- | B2     | Computers           |       2 |
-- | B2     | How to Fish         |       4 |
-- | B2     | The Wife            |       3 |
-- | B3     | A History Of Dublin |       1 |
-- | B3     | Computers           |       4 |
-- | B3     | Susannah            |       3 |
-- | B3     | The Wife            |       1 |
-- +--------+---------------------+---------+
-- 10 rows in set (0.00 sec)

#SQL statements to retrieve the names of all library books published by Macmillan
SELECT Title FROM Titles WHERE Publisher = "Macmillan";
-- +----------+
-- | Title    |
-- +----------+
-- | Susannah |
-- | The Wife |
-- +----------+
-- 2 rows in set (0.00 sec)

#SQL statements to retrieve branches that hold any books by Ann Brown (using a nested subquery)

SELECT DISTINCT(Branch) from Holdings WHERE Title in(SELECT Title FROM Titles WHERE Author = "Ann Brown");
-- +--------+
-- | Branch |
-- +--------+
-- | B1     |
-- | B2     |
-- | B3     |
-- +--------+
-- 3 rows in set (0.00 sec)

#SQL statements to retrieve branches that hold any books by Ann Brown (without using a nested subquery)

SELECT DISTINCT(branch) FROM Holdings NATURAL JOIN Titles WHERE Titles.Author = "Ann Brown";
-- +--------+
-- | branch |
-- +--------+
-- | B1     |
-- | B3     |
-- | B2     |
-- +--------+
-- 3 rows in set (0.00 sec)


#SQL statements to retrieve the total number of books held at each branch

SELECT branch, SUM(`#copies`) AS "Total number of books" FROM Holdings GROUP BY branch;
-- +--------+-----------------------+
-- | branch | Total number of books |
-- +--------+-----------------------+
-- | B1     |                     6 |
-- | B2     |                     9 |
-- | B3     |                     9 |
-- +--------+-----------------------+
-- 3 rows in set (0.00 sec)
