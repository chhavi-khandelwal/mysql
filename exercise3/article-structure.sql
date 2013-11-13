CREATE DATABASE articleDB;
-- Query OK, 1 row affected (0.00 sec)

USE articleDB;
-- Database changed

 CREATE TABLE Users 
(
  id INT NOT NULL,
  name VARCHAR(20) NOT NULL,
  type ENUM('admin', 'normal') DEFAULT 'normal' NOT NULL,
  PRIMARY KEY(id)
);
-- Query OK, 0 rows affected (0.14 sec)

DESC Users;
-- +-------+------------------------+------+-----+---------+-------+
-- | Field | Type                   | Null | Key | Default | Extra |
-- +-------+------------------------+------+-----+---------+-------+
-- | id    | int(11)                | NO   | PRI | NULL    |       |
-- | name  | varchar(20)            | NO   |     | NULL    |       |
-- | type  | enum('admin','normal') | NO   |     | normal  |       |
-- +-------+------------------------+------+-----+---------+-------+
-- 3 rows in set (0.00 sec)

INSERT INTO Users VALUES
(1, "user1", "admin"), 
(2, "user2", "default"), 
(3, "user3", "default"),
(4, "user4", "admin"),
(5, "user5", "default");
-- Query OK, 5 rows affected, 3 warnings (0.06 sec)
-- Records: 5  Duplicates: 0  Warnings: 3

SELECT * FROM Users;
-- +----+-------+--------+
-- | id | name  | type   |
-- +----+-------+--------+
-- |  1 | user1 | admin  |
-- |  2 | user2 | normal |
-- |  3 | user3 | normal |
-- |  4 | user4 | admin  |
-- |  5 | user5 | normal |
-- +----+-------+--------+
-- 5 rows in set (0.00 sec)

CREATE TABLE Categories
(
  id INT NOT NULL,
  category VARCHAR(20) NOT NULL,
  PRIMARY KEY(id)
);
-- Query OK, 0 rows affected (0.19 sec)

DESC Categories;
-- +----------+-------------+------+-----+---------+-------+
-- | Field    | Type        | Null | Key | Default | Extra |
-- +----------+-------------+------+-----+---------+-------+
-- | id       | int(11)     | NO   | PRI | NULL    |       |
-- | category | varchar(20) | NO   | UNI | NULL    |       |
-- +----------+-------------+------+-----+---------+-------+
-- 2 rows in set (0.00 sec)

INSERT INTO Categories VALUES
(1, "art"),
(2, "technology"),
(3, "fashion"),
(4, "politics"),
(5, "education");
-- Query OK, 5 rows affected (0.05 sec)
-- Records: 5  Duplicates: 0  Warnings: 0

SELECT * FROM Categories; 
-- +----+------------+
-- | id | category   |
-- +----+------------+
-- |  1 | art        |
-- |  5 | education  |
-- |  3 | fashion    |
-- |  4 | politics   |
-- |  2 | technology |
-- +----+------------+
-- 5 rows in set (0.00 sec)

CREATE TABLE Articles
(
  id INT NOT NULL,
  content TEXT NOT NULL,
  user_id INT NOT NULL,
  category_id INT NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(user_id) REFERENCES Users(id),
  FOREIGN KEY(category_id) REFERENCES Categories(id)
);
-- Query OK, 0 rows affected (0.19 sec)

DESC Articles;
-- +-------------+---------+------+-----+---------+-------+
-- | Field       | Type    | Null | Key | Default | Extra |
-- +-------------+---------+------+-----+---------+-------+
-- | id          | int(11) | NO   | PRI | NULL    |       |
-- | content     | text    | NO   |     | NULL    |       |
-- | user_id     | int(11) | NO   | MUL | NULL    |       |
-- | category_id | int(11) | NO   | MUL | NULL    |       |
-- +-------------+---------+------+-----+---------+-------+
-- 4 rows in set (0.00 sec)

INSERT INTO Articles VALUES 
(1, "content1", 2, 3),
(2, "content2", 2, 4),
(3, "content3", 3, 5),
(4, "content4", 1, 1),
(5, "content5", 1, 5), 
(6, "content6", 4, 2), 
(7, "content7", 4, 1), 
(8, "content8", 5, 3), 
(9, "content9", 5, 4), 
(10, "content10", 3, 2); 
-- Query OK, 10 rows affected (0.05 sec)
-- Records: 10  Duplicates: 0  Warnings: 0

SELECT * FROM Articles;
-- +----+-----------+---------+-------------+
-- | id | content   | user_id | category_id |
-- +----+-----------+---------+-------------+
-- |  1 | content1  |       2 |           3 |
-- |  2 | content2  |       2 |           4 |
-- |  3 | content3  |       3 |           5 |
-- |  4 | content4  |       1 |           1 |
-- |  5 | content5  |       1 |           5 |
-- |  6 | content6  |       4 |           2 |
-- |  7 | content7  |       4 |           1 |
-- |  8 | content8  |       5 |           3 |
-- |  9 | content9  |       5 |           4 |
-- | 10 | content10 |       3 |           2 |
-- +----+-----------+---------+-------------+
-- 10 rows in set (0.00 sec)

CREATE TABLE Comments
(
  id INT NOT NULL,
  comment TEXT NOT NULL,
  user_id INT NOT NULL,
  article_id INT NOT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY(user_id) REFERENCES Users(id),
  FOREIGN KEY(article_id) REFERENCES Articles(id)
);
-- Query OK, 0 rows affected (0.22 sec)

DESC Comments;
-- +------------+---------+------+-----+---------+-------+
-- | Field      | Type    | Null | Key | Default | Extra |
-- +------------+---------+------+-----+---------+-------+
-- | id         | int(11) | NO   | PRI | NULL    |       |
-- | comment    | text    | YES  |     | NULL    |       |
-- | user_id    | int(11) | NO   | MUL | NULL    |       |
-- | article_id | int(11) | NO   | MUL | NULL    |       |
-- +------------+---------+------+-----+---------+-------+
-- 4 rows in set (0.00 sec)


INSERT INTO Comments VALUES
(1, "comment1", 1, 10),
(2, "comment2", 1, 2), 
(3, "comment3", 2, 3),
(4, "comment4", 3, 4),
(5, "comment5", 4, 1),
(6, "comment6", 5, 10),
(7, "comment7", 5, 3),
(8, "comment8", 4, 5),
(9, "comment9", 2, 5),
(10, "comment10", 3, 10);
-- Query OK, 10 rows affected (0.05 sec)
-- Records: 10  Duplicates: 0  Warnings: 0

SELECT * FROM Comments;
-- +----+-----------+---------+------------+
-- | id | comment   | user_id | article_id |
-- +----+-----------+---------+------------+
-- |  1 | comment1  |       1 |         10 |
-- |  2 | comment2  |       1 |          2 |
-- |  3 | comment3  |       2 |          3 |
-- |  4 | comment4  |       3 |          4 |
-- |  5 | comment5  |       4 |          1 |
-- |  6 | comment6  |       5 |         10 |
-- |  7 | comment7  |       5 |          3 |
-- |  8 | comment8  |       4 |          5SELECT c1.article_id FROM Comments c1 LEFT JOIN Comments c2 ON c1.article_id = c2.article_id AND c1.user_id = c2.user_id AND c1.id != c2.id GROUP BY c1.article_id HAVING COUNT(c2.id) = 0;
 |
-- |  9 | comment9  |       2 |          5 |
-- | 10 | comment10 |       3 |         10 |
-- +----+-----------+---------+------------+
-- 10 rows in set (0.00 sec)


#select all articles whose author is user3
SELECT a.id FROM Articles as a INNER JOIN Users as u ON u.id = a.user_id where u.name = "user3";
-- +----+
-- | id |
-- +----+
-- |  3 |
-- | 10 |
-- +----+
-- 2 rows in set (0.00 sec)

-- For all the articles being selected above, select all the articles and also the comments associated
-- with those articles in a single query (Do this using subquery also)
SELECT c.article_id, c.comment FROM Users as u, Comments as c, Articles as a WHERE u.id = a.user_id AND c.article_id = a.id AND u.name = "user3";
-- +------------+----------+
-- | article_id | comment  |
-- +------------+----------+
-- |          3 | comment3 |
-- |          3 | comment7 |
-- |         10 | comment1 |
-- |         10 | comment6 |
-- +------------+----------+
-- 4 rows in set (0.00 sec)
#subquery
SELECT article_id, comment FROM Comments WHERE article_id in (SELECT id FROM Articles WHERE user_id in (SELECT id FROM Users WHERE name = "user3"));
-- +------------+----------+
-- | article_id | comment  |
-- +------------+----------+
-- |         10 | comment1 |
-- |          3 | comment3 |
-- |         10 | comment6 |
-- |          3 | comment7 |
-- +------------+----------+
-- 4 rows in set (0.00 sec)

#Write a query to select all articles which do not have any comments (Do using subquery also)

SELECT a.id FROM Articles a LEFT JOIN Comments c ON a.id = c.article_id WHERE ISNULL(comment);
-- +----+
-- | id |
-- +----+
-- |  6 |
-- |  7 |
-- |  8 |
-- |  9 |
-- +----+
-- 4 rows in set (0.00 sec)

#SUBQUERY
SELECT id FROM Articles WHERE id NOT IN( SELECT article_id FROM Comments);
-- +----+
-- | id |
-- +----+
-- |  6 |
-- |  7 |
-- |  8 |
-- |  9 |
-- +----+
-- 4 rows in set (0.00 sec)

#Write a query to select article which has maximum comments

SELECT COUNT(article_id) INTO @max_val FROM Comments GROUP BY article_id DESC LIMIT 1;
-- Query OK, 1 row affected (0.00 sec)

SELECT article_id, COUNT(article_id) as maximum_value FROM Comments GROUP BY article_id HAVING maximum_value = @max_val;  
-- +------------+---------------+
-- | article_id | maximum_value |
-- +------------+---------------+
-- |         10 |             3 |
-- +------------+---------------+
-- 1 row in set (0.00 sec)

#Write a query to select article which does not have more than one comment by the same user
#using left join and group by
SELECT c1.article_id FROM Comments c1 LEFT JOIN Comments c2 ON c1.article_id = c2.article_id AND c1.user_id = c2.user_id AND c1.id != c2.id GROUP BY c1.article_id HAVING COUNT(c2.id) = 0;
-- +----+
-- | id |
-- +----+
-- |  1 |
-- |  2 |
-- |  3 |
-- |  4 |
-- |  5 |
-- |  6 |
-- |  7 |
-- |  8 |
-- |  9 |
-- | 10 |
-- +----+
-- 10 rows in set (0.00 sec)