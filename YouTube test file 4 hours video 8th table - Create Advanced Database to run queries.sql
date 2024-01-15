/*Delete a table*/
/*DROP TABLE student;*/

/* Youtube video: https://youtu.be/HXV3zeQKqGY?si=_zWEctdZttSVIewM */
/*Direct website link to the code: https://www.giraffeacademy.com/databases/sql/creating-company-database/ */

/*Create Table called: Employee*/
CREATE TABLE employee (
  emp_id INT PRIMARY KEY, -- Employee ID is pimary key.
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE, -- Will store with 4 digit year, 2 digit month and 2 digit day.
  sex VARCHAR(1), -- Sex M for Male or F for Female.
  salary INT,
  super_id INT, -- Supervisor ID. A foreign id points to another employee.
  branch_id INT -- Branch ID. points to branch table.
);

/*Create Table called: Branch*/
CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT, -- Foreign Key.
  mgr_start_date DATE,
  /* Manager ID is a Foreign Key in this branch table. 
  This key links / reference to the primary key in Employee table specifically the column called id.*/
  FOREIGN KEY(mgr_id) 
  REFERENCES employee(emp_id) ON DELETE SET NULL 
);

/*Add branch id as foreign key to employee table.*/
ALTER TABLE employee /*Update Employee table.*/
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id) /*Primary key table and name.*/
ON DELETE SET NULL;

/*Add supervisor id as foreign key to employee table.*/
ALTER TABLE employee /*Update Employee table.*/
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id) /*Primary key table and name.*/
ON DELETE SET NULL;

/*Create Table called: Client*/
CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
   /* Branch ID is a Foreign Key in this client table. 
  This key links / reference to the primary key in Branch table specifically the column called branch id.*/
  FOREIGN KEY(branch_id) 
  REFERENCES branch(branch_id) ON DELETE SET NULL
);


/*Create Table called: Works. This table contains 1 primary key (which is a composition of 2 foreign keys).
In addition it also has 2 foreign keys in this table, which are the primary keys too.*/
CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
     /* employee id and client id are both Foreign Key in this works table. 
  Employee ID: This key links / reference to the primary key in employee table specifically the employee id column.
  Client  ID: This key links / reference to the primary key in client table specifically the client id column.*/
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);


/*Create Table called: Branch Supplier. This table contains 1 primary key (which is a composition of 2 foreign keys).
In addition it has 1 foreign key in this table, which is a primary key too.*/
CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
    /* branch id and supplier name are both Foreign Key in this works table. 
  Branch ID: This key links / reference to the primary key in branch table specifically the branch id column.*/
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);


-- -----------------------------------------------------------------------------

-- Corporate Branch
/*Add branch manager 1st = David.

/*1. Insert into Employee table manager of Corporate branch.
/*Create in PRIMARY TABLE employee called David Wallace. But last 2 are left blank for now as they are foreign keys.*/
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

/*2. Create Corporate branch. Insert in FOREIGN TABLE branch values into branch table for David Wallace.*/
INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

/*3. Update Employee table with PRIMARY TABLE Employee information as we now crated both tables.
UPDATE IS DONE TO MAKE AWARE DAVID WORKS AT CORPORATE BRANCH.
So can now put foreign key information in primary table for employee called David Wallace.
So update employee table specifically the branch_id to 1, where the employee id in the employee table id 100.*/
UPDATE employee -- update employee table
SET branch_id = 1
WHERE emp_id = 100;

/*4. Add branch employees who are not managers.*/
INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);




-- Scranton Branch
/*Add branch manager 1st = Micheal Scott.*/

/*1. Insert into Employee table manager of Corporate branch.
/*Create in PRIMARY TABLE employee called Micheal Scott. But last 2 are left blank for now as they are foreign keys.*/
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

/*2. Create Corporate branch. Insert in FOREIGN TABLE branch values into branch table for Micheal Scott.*/
INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

/*3. Update Employee table with PRIMARY TABLE Employee information as we now created both tables.
UPDATE IS DONE TO MAKE AWARE MICHEAL WORKS AT SCRANTON BRANCH.
So update employee table specifically the branch_id to 2, where the employee id in the employee table id 102.*/
UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

/*4. Add branch employees who are not managers.*/
INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);




-- Stamford Branch
/*Add branch manager 1st = Josh Stamford.*/

/*1. Insert into Employee table manager of Corporate branch.
/*Create in PRIMARY TABLE employee called Josh Porter. But last 2 are left blank for now as they are foreign keys.*/
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

/*2. Create Corporate branch. Insert in FOREIGN TABLE branch values into branch table for Josh Stamford.*/
INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

/*3. Update Employee table with PRIMARY TABLE Employee information as we now created both tables.
UPDATE IS DONE TO MAKE AWARE JOSH WORKS AT STAMFORD BRANCH.
So update employee table specifically the branch_id to 3, where the employee id in the employee table id 106.*/
UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

/*4. Add branch employees who are not managers.
/*Now added 1 emplyee David can add all remaining employees for the branch table.*/
INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);





-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH_id
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

/*To view table called: Employee*/
SELECT *
FROM employee;

/*To view table called: Branch*/
SELECT *
FROM branch;

/*To view table called: Client*/
SELECT *
FROM client;

/*To view table called: Works_with*/
SELECT *
FROM works_with;

/*To view table called: Supplier*/
SELECT *
FROM branch_supplier;


/*Find all employees ordered by salary by descending order (ordered by largest salary) */
SELECT *
from employee
ORDER BY salary DESC;


/*Find all employees ordered by salary by ascending order (ordered by smallest salary) */
SELECT *
from employee
ORDER BY salary ASC;


/*Find all employees ordered by sex then first name*/
SELECT *
from employee
ORDER BY sex, first_name;


/*Find all employees ordered by sex then first name then by last name*/
SELECT *
from employee
ORDER BY sex, first_name, last_name;


/*Find the first 5 employees in the table*/
SELECT *
from employee
LIMIT 5;


/*Find the first and last names of all employees*/
SELECT first_name, employee.last_name
FROM employee;


/*Find the forename and surnames names of all employees using alias*/
SELECT first_name AS forename, employee.last_name AS surname
FROM employee;


/*Find out all the distinct / different genders employees have*/
SELECT DISTINCT sex
FROM employee;


/*Find out all the distinct / different branch_ids employees have*/
SELECT DISTINCT branch_id
FROM employee;


/*Find all male employees */
SELECT *
FROM employee
WHERE sex = 'M';

/*Find all female employees */
SELECT *
FROM employee
WHERE sex = 'F';

/*Find all employees at branch 2*/
SELECT *
FROM employee
WHERE branch_id = 2;

/*Find all employee's id's, first names and last names who were born after 1969*/
SELECT emp_id, first_name, last_name
FROM employee
WHERE birth_day >= 1970-01-01;

/*Find all female employees at branch 2*/
SELECT *
FROM employee
WHERE branch_id = 2 AND sex = 'F';

/*Find all employees who are female & born after 1969 or who make over 80000*/
SELECT *
FROM employee
WHERE (birth_day >= '1970-01-01' AND sex = 'F') OR salary > 80000;

/*Find all employees born between 1970 and 1975*/
SELECT *
FROM employee
WHERE birth_day BETWEEN '1970-01-01' AND '1975-01-01';

/*Find all employees named Jim, Michael, Johnny or David*/
SELECT *
FROM employee
WHERE first_name IN ('Jim', 'Michael', 'Johnny', 'David');




/*SQL: Functions*/
/*https://www.giraffeacademy.com/databases/sql/functions/*/

-- Find the number of employees
SELECT COUNT(emp_id)
FROM employee;

-- Find the number of employees who have supervisors*/
SELECT COUNT(super_id)
FROM employee;

/*Find the number of female employees born after 1970*/
SELECT COUNT(emp_id)
FROM employee
WHERE sex = 'F' AND birth_day > '1971-01-01';


/*Find the number of male employees born after 1970*/
SELECT COUNT(emp_id)
FROM employee
WHERE sex = 'M' AND birth_day > '1971-01-01';


/*Find the average of all employee's salaries*/
SELECT AVG(salary)
FROM employee;

/*Find the average of all employee's salaries, where sex = M*/
SELECT AVG(salary)
FROM employee
WHERE sex ='M';

/*Find the average of all employee's salaries, where sex = F*/
SELECT AVG(salary)
FROM employee
WHERE sex ='F';


/*Find the sum of all employee's salaries*/
SELECT SUM(salary)
FROM employee;


/*Aggregation*/
/*Find out how many males and females there are, sorted by sex*/
SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;


/* Find the total sales of each salesman (employee id) */
SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;

 
/*Find the total amount of money spent by each client*/
SELECT SUM(total_sales), client_id
FROM works_with
GROUP BY client_id;



/*SQL Wildcards: % = any # characters, _ = one character */
/*https://www.giraffeacademy.com/databases/sql/wildcards/*/

/* Find any client's who are an LLC */
/* % = any number of characters before word LLC */
SELECT *
FROM client
WHERE client_name LIKE '%LLC';


/*Find any branch suppliers who are in the label business*/
-- % included at beginning and end of word will mean entire cell / name contents is searched
SELECT *
FROM branch_supplier
WHERE supplier_name LIKE '% Label%';


/*Find any employee born in October / the 10th month of the year*/
-- Add x4 _ _ _ _ then a 10 to get the 10th month 
SELECT *
FROM employee
WHERE birth_day LIKE '____-10%';


/*Find any employee born in February / the 2nd month of the year*/
-- Add x4 _ _ _ _ then a 2 to get the 2nd month 
SELECT *
FROM employee
WHERE birth_day LIKE '____-02%';


/*Find any clients who are high schools*/
SELECT *
FROM client
WHERE client_name LIKE '%Highschool%';


/*Find any clients who are schools*/
SELECT *
FROM client
WHERE client_name LIKE '%school%';


/*UNION Special SQL Operator*/
/*https://www.giraffeacademy.com/databases/sql/union/*/

/*Creates a list of employee and branch names */
-- Union combines 2 seperate statements into 1 single column
SELECT employee.first_name AS Employee_Branch_Names
FROM employee
UNION
SELECT branch.branch_name
FROM branch;


/*Creates a list of employee and branch names */
-- Union combines 3 seperate statements into 1 single column
SELECT first_name
FROM employee
UNION
SELECT branch.branch_name
FROM branch
UNION
SELECT client_name
FROM client;


/* Create a list of all clients & branch suppliers' names*/
SELECT client_name
FROM client
UNION
SELECT supplier_name
FROM branch_supplier;


/* Create a list of all clients & branch suppliers' names with there corresponding brand_id*/
SELECT client_name, branch_id
FROM client
UNION
SELECT supplier_name, branch_id
FROM branch_supplier;


/* Tidy above formuale to make clear which tables the branch ids are from.*/
SELECT client_name, client.branch_id
FROM client
UNION
SELECT supplier_name, branch_supplier.branch_id
FROM branch_supplier;


/*Find a list of all money spent (employee salaries) or earned (sales) by the company*/
SELECT salary
FROM employee
UNION
SELECT total_sales
FROM works_with;

/*SQL: Joins*/
/*https://www.giraffeacademy.com/databases/sql/joins/*/

/*Add the extra branch*/
INSERT INTO branch VALUES(4, "Buffalo", NULL, NULL);

/*View extra row added to table*/
SELECT *
FROM branch;

/*Standard JOIN aka INNER JOIN*/
/*Find all branches and the names of their managers, & bring back manager name when branch id is in both tables*/
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch    -- LEFT JOIN, RIGHT JOIN
ON employee.emp_id = branch.mgr_id;

/*LEFT JOIN*/
/*Find all branches and the names of their managers, & bring back all left table contents (e.g. employee id) in left table*/
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee /*Left table goes here */
LEFT JOIN branch 
ON employee.emp_id = branch.mgr_id;

/*RIGHT JOIN*/
/*Find all branches and the names of their managers, & bring back all left right contents (e.g. branch name) in right table*/
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee /*Left table goes here */
RIGHT JOIN branch 
ON employee.emp_id = branch.mgr_id;


/*SQL: Nested Queries --- Use of multiple select statments*/
/*https://www.giraffeacademy.com/databases/sql/nested-queries/ */

/*Find names of all employee id who have sold over 30,000 to a single client*/
SELECT works_with.emp_id
FROM works_with
WHERE works_with.total_sales > 30000;


/*Find names of all employees first name and last name where the employees have then sold over 30,000 to a single client*/
SELECT employee.first_name, employee.last_name
FROM employee 
WHERE employee.emp_id IN (
   SELECT works_with.emp_id
   FROM works_with
   WHERE works_with.total_sales > 30000
);


/*Find names of all employees who have sold over 50,000*/
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (SELECT works_with.emp_id
                          FROM works_with
                          WHERE works_with.total_sales > 50000);


/*Find all clients that Micheal managaes*/
SELECT branch.branch_id
FROM branch
WHERE branch.mgr_id = 102;

/*Find all clients who are handles by the branch that Michael Scott manages*/
-- Assume you know Michael's ID
SELECT client.client_id, client.client_name
FROM client
WHERE client.branch_id = (SELECT branch.branch_id
                          FROM branch
                          WHERE branch.mgr_id = 102);
                          
                          
/* X2 NESTED Queries - Find all clients who are handles by the branch that Michael Scott manages*/
 -- Assume you DONT'T know Michael's ID
 SELECT client.client_id, client.client_name
 FROM client
 WHERE client.branch_id = (SELECT branch.branch_id
                           FROM branch
                           WHERE branch.mgr_id = (SELECT employee.emp_id
                                                  FROM employee
                                                  WHERE employee.first_name = 'Michael' AND employee.last_name ='Scott'
                                                  LIMIT 1));


/* X1 NESTED statement & AND statement. Find the names of employees who work with clients handled by the scranton branch*/
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
                         SELECT works_with.emp_id
                         FROM works_with
                         )
AND employee.branch_id = 2;


/* X2 NESTED STATEMENTS & Using Alias. Find the names of all clients who have spent more than 100,000 dollars*/
SELECT client.client_name
FROM client
WHERE client.client_id IN (
                          SELECT client_id
                          FROM (
                                SELECT SUM(works_with.total_sales) AS totals, client_id
                                FROM works_with
                                GROUP BY client_id) AS total_client_sales
                                WHERE totals > 100000
);


/*On Delete. On delete set-null makes deleted rows show null, but on delete cascade deletes entire row/s of data*/
/*https://www.giraffeacademy.com/databases/sql/on-delete/*/

/*Create Table called: Branch*/
CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT, -- Foreign Key.
  mgr_start_date DATE,
  /* Manager ID is a Foreign Key in this branch table. 
  This key links / reference to the primary key in Employee table specifically the column called id.*/
  FOREIGN KEY(mgr_id) 
  REFERENCES employee(emp_id) ON DELETE SET NULL 
);

DELETE FROM employee
WHERE emp_id = 102;

/*Review deleted data*/
SELECT *
from branch;

SELECT *
from employee;


/*Create Table called: Branch*/
CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT, -- Foreign Key.
  mgr_start_date DATE,
  /* Manager ID is a Foreign Key in this branch table. 
  This key links / reference to the primary key in Employee table specifically the column called id.*/
  FOREIGN KEY(mgr_id) 
  REFERENCES employee(emp_id) ON DELETE SET NULL 
);


/*SQL: Triggers*/
/*https://www.giraffeacademy.com/databases/sql/triggers/*/

-- CREATE a TRIGGER `event_name` BEFORE/AFTER INSERT/UPDATE/DELETE ON `database`.`table`
--     FOR EACH ROW BEGIN
-- 		-- trigger body, this code is applied to every
-- 		-- inserted/updated/deleted row
--     END;

CREATE TABLE trigger_test (
     message VARCHAR(100)
);



/* ER diagram */
/* https://www.giraffeacademy.com/databases/sql/er-diagrams-intro/*/

