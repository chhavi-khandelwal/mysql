create database employeeManagement;
-- Query OK, 1 row affected (0.02 sec)

use employeeManagement;
-- Database changed

create table location ( id INT NOT NULL, regional_group varchar(255) NOT NULL, primary key(id));
-- Query OK, 0 rows affected (0.22 sec)

desc location;
-- +----------------+--------------+------+-----+---------+-------+
-- | Field          | Type         | Null | Key | Default | Extra |
-- +----------------+--------------+------+-----+---------+-------+
-- | id             | int(11)      | NO   | PRI | NULL    |       |
-- | regional_group | varchar(255) | NO   |     | NULL    |       |
-- +----------------+--------------+------+-----+---------+-------+
-- 2 rows in set (0.00 sec)

insert into location values 
  (122, "new york"),
  (123, "dallas"),
  (124, "chicago"),
  (167, "boston");
-- Query OK, 4 rows affected (0.12 sec)
-- Records: 4  Duplicates: 0  Warnings: 0

select * from location;
-- +-----+----------------+
-- | id  | regional_group |
-- +-----+----------------+
-- | 122 | new york       |
-- | 123 | dallas         |
-- | 124 | chicago        |
-- | 167 | boston         |
-- +-----+----------------+
-- 4 rows in set (0.00 sec)


create table department
  ( id int not null,
    name varchar(255) not null,
    location_id int not null,
    primary key(id),
    foreign key(location_id) references location(id),
    index(location_id) );
-- Query OK, 0 rows affected (0.17 sec)

desc department;
-- +-------------+--------------+------+-----+---------+-------+
-- | Field       | Type         | Null | Key | Default | Extra |
-- +-------------+--------------+------+-----+---------+-------+
-- | id          | int(11)      | NO   | PRI | NULL    |       |
-- | name        | varchar(255) | NO   |     | NULL    |       |
-- | location_id | int(11)      | NO   | MUL | NULL    |       |
-- +-------------+--------------+------+-----+---------+-------+
-- 3 rows in set (0.00 sec)


insert into department values
  (10, "accounting", 122),
  (20, "research", 124),
  (30, "sales", 123),
  (40, "operations", 167);
-- Query OK, 4 rows affected (0.04 sec)
-- Records: 4  Duplicates: 0  Warnings: 0

select * from department;
-- +----+------------+-------------+
-- | id | name       | location_id |
-- +----+------------+-------------+
-- | 10 | accounting |         122 |
-- | 20 | research   |         124 |
-- | 30 | sales      |         123 |
-- | 40 | operations |         167 |
-- +----+------------+-------------+
-- 4 rows in set (0.00 sec)


create table job ( id int not null, function varchar(255) not null, primary key(id));
-- Query OK, 0 rows affected (0.13 sec)

desc job;
-- +----------+--------------+------+-----+---------+-------+
-- | Field    | Type         | Null | Key | Default | Extra |
-- +----------+--------------+------+-----+---------+-------+
-- | id       | int(11)      | NO   | PRI | NULL    |       |
-- | function | varchar(255) | NO   |     | NULL    |       |
-- +----------+--------------+------+-----+---------+-------+
-- 2 rows in set (0.00 sec)



insert into job values
 (667, "clerk"),
 (668, "staff"),
 (669, "analyst"),
 (670, "salesperson"),
 (671, "manager"),
 (672, "president");
-- Query OK, 6 rows affected (0.05 sec)
-- Records: 6  Duplicates: 0  Warnings: 0

select * from job;
-- +-----+-------------+
-- | id  | function    |
-- +-----+-------------+
-- | 667 | clerk       |
-- | 668 | staff       |
-- | 669 | analyst     |
-- | 670 | salesperson |
-- | 671 | manager     |
-- | 672 | president   |
-- +-----+-------------+
-- 6 rows in set (0.00 sec)

create table employee ( id int not null, lastname varchar(255) not null, firstname varchar(255) not null, middlename varchar(255) not null, job_id int not null, manager_id int not null, hiredate date not null, salary decimal(10,2) not null, comm decimal(10,2), department_id int not null, primary key(id), foreign key(job_id) references job(id) , foreign key(department_id) references department(id), index(job_id), index(department_id) );
-- Query OK, 0 rows affected (0.21 sec)

insert into employee values
 (7369, "smith", "john", "q", 667, 7902, "1984-12-17", 800, null, 20), 
 (7499, "allen", "kevin", "j", 670, 7698, "1985-02-20", 1600, 300, 30),
 (7505, "doyle", "jean", "k", 671, 7839, "1985-04-04", 2850, null, 30),
 (7506, "dennis", "lynn", "s", 671, 7839, "1985-05-15", 2750, null, 30), 
 (7507, "baker", "leslie", "d", 671, 7839, "1985-06-15", 2200, null, 40), 
 (7521, "wark", "cynthia", "d", 670, 7698, "1985-06-22", 1250, 500, 30); 
-- Query OK, 6 rows affected (0.08 sec)
-- Records: 6  Duplicates: 0  Warnings: 0

select * from employee;
-- +------+----------+-----------+------------+--------+------------+------------+---------+--------+---------------+
-- | id   | lastname | firstname | middlename | job_id | manager_id | hiredate   | salary  | comm   | department_id |
-- +------+----------+-----------+------------+--------+------------+------------+---------+--------+---------------+
-- | 7369 | smith    | john      | q          |    667 |       7902 | 1984-12-17 |  800.00 |   NULL |            20 |
-- | 7499 | allen    | kevin     | j          |    670 |       7698 | 1985-02-20 | 1600.00 | 300.00 |            30 |
-- | 7505 | doyle    | jean      | k          |    671 |       7839 | 1985-04-04 | 2850.00 |   NULL |            30 |
-- | 7506 | dennis   | lynn      | s          |    671 |       7839 | 1985-05-15 | 2750.00 |   NULL |            30 |
-- | 7507 | baker    | leslie    | d          |    671 |       7839 | 1985-06-15 | 2200.00 |   NULL |            40 |
-- | 7521 | wark     | cynthia   | d          |    670 |       7698 | 1985-06-22 | 1250.00 | 500.00 |            30 |
-- +------+----------+-----------+------------+--------+------------+------------+---------+--------+---------------+
-- 6 rows in set (0.00 sec)


-- QUERIES
-- QUERY-1

SELECT id as "EMPLOYEES NOT RECEIVING ANY COMMISSION" FROM employee 
WHERE comm IS NULL;
-- +----------------------------------------+
-- | EMPLOYEES NOT RECEIVING ANY COMMISSION |
-- +----------------------------------------+
-- |                                   7369 |
-- |                                   7505 |
-- |                                   7506 |
-- |                                   7507 |
-- +----------------------------------------+
-- 4 rows in set (0.01 sec)

-- QUERY-2
SELECT COUNT(e.id) AS "EMPLOYEES IN NEW YORK" FROM location l INNER JOIN department d INNER JOIN employee e 
ON l.id = d.location_id AND d.id = e.department_id 
WHERE regional_group = "new york";  
-- +-----------------------+
-- | EMPLOYEES IN NEW YORK |
-- +-----------------------+
-- |                     0 |
-- +-----------------------+
-- 1 row in set (0.00 sec)

-- QUERY-3
select e1.* from department d inner join employee e1 
on d.id = e1.department_id left join 
employee e2 on e1.department_id = e2.department_id inner join 
job j on j.id = e2.job_id 
where e1.salary > e2.salary and j.function = "manager" 
group by e1.id;
-- +------+----------+-----------+------------+--------+------------+------------+---------+------+---------------+
-- | id   | lastname | firstname | middlename | job_id | manager_id | hiredate   | salary  | comm | department_id |
-- +------+----------+-----------+------------+--------+------------+------------+---------+------+---------------+
-- | 7505 | doyle    | jean      | k          |    671 |       7839 | 1985-04-04 | 2850.00 | NULL |            30 |
-- +------+----------+-----------+------------+--------+------------+------------+---------+------+---------------+
-- 1 row in set (0.00 sec)



-- QUERY-4
select * from employee where salary = (
  select salary from employee 
  group by salary
  order by salary 
  desc limit 1,1
);
-- +------+----------+-----------+------------+--------+------------+------------+---------+------+---------------+
-- | id   | lastname | firstname | middlename | job_id | manager_id | hiredate   | salary  | comm | department_id |
-- +------+----------+-----------+------------+--------+------------+------------+---------+------+---------------+
-- | 7506 | dennis   | lynn      | s          |    671 |       7839 | 1985-05-15 | 2750.00 | NULL |            30 |
-- +------+----------+-----------+------------+--------+------------+------------+---------+------+---------------+
-- 1 row in set (0.00 sec)



-- QUERY-5
SELECT d.name AS DEPARTMENT, e.* FROM employee e INNER JOIN department d ON d.id = e.department_id;
-- +------------+------+----------+-----------+------------+--------+------------+------------+---------+--------+---------------+
-- | DEPARTMENT | id   | lastname | firstname | middlename | job_id | manager_id | hiredate   | salary  | comm   | department_id |
-- +------------+------+----------+-----------+------------+--------+------------+------------+---------+--------+---------------+
-- | research   | 7369 | smith    | john      | q          |    667 |       7902 | 1984-12-17 |  800.00 |   NULL |            20 |
-- | sales      | 7499 | allen    | kevin     | j          |    670 |       7698 | 1985-02-20 | 1600.00 | 300.00 |            30 |
-- | sales      | 7505 | doyle    | jean      | k          |    671 |       7839 | 1985-04-04 | 2850.00 |   NULL |            30 |
-- | sales      | 7506 | dennis   | lynn      | s          |    671 |       7839 | 1985-05-15 | 2750.00 |   NULL |            30 |
-- | sales      | 7521 | wark     | cynthia   | d          |    670 |       7698 | 1985-06-22 | 1250.00 | 500.00 |            30 |
-- | operations | 7507 | baker    | leslie    | d          |    671 |       7839 | 1985-06-15 | 2200.00 |   NULL |            40 |
-- +------------+------+----------+-----------+------------+--------+------------+------------+---------+--------+---------------+
-- 6 rows in set (0.00 sec)

-- QUERY-6
select e.id from employee e inner join 
  (select department_id, avg(salary) as "avg_salary" 
from employee 
group by department_id) as a 
ON e.department_id = a.department_id 
WHERE e.salary > a.avg_salary;
-- +------+
-- | id   |
-- +------+
-- | 7505 |
-- | 7506 |
-- +------+
-- 2 rows in set (0.00 sec)

-- QUERY-7
SELECT d.name AS DEPARTMENT, j.function AS JOB FROM department d INNER JOIN employee e INNER JOIN job j 
ON d.id = e.department_id AND j.id = e.job_id 
GROUP BY e.job_id 
HAVING d.name IN ("sales", "accounting");
-- +------------+-------------+
-- | DEPARTMENT | JOB         |
-- +------------+-------------+
-- | sales      | salesperson |
-- | sales      | manager     |
-- +------------+-------------+
-- 2 rows in set (0.00 sec)
