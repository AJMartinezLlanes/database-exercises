-- 1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.

USE employees;

CREATE TEMPORARY TABLE innis_1670.employees_with_salaries AS 
SELECT * FROM employees JOIN salaries USING(emp_no);

SHOW databases;
USE innis_1670;
SELECT * FROM employees_with_salaries LIMIT 10;

CREATE TEMPORARY TABLE innis_1670.employees_with_departments AS 
SELECT e.first_name, e.last_name, d.dept_name FROM employees e JOIN dept_emp USING(emp_no) JOIN departments d USING(dept_no);
SELECT * FROM employees_with_departments;

-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

DESCRIBE employees_with_departments;

ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

-- Update the table so that full name column contains the correct data

UPDATE employees_with_departments SET full_name = CONCAT(first_name,' ', last_name);
SELECT * FROM employees_with_departments LIMIT 5;

-- Remove the first_name and last_name columns from the table.

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;
SELECT * FROM employees_with_departments LIMIT 5;

-- What is another way you could have ended up with this same table?

CREATE TEMPORARY TABLE innis_1670.employees_with_departments1 AS 
SELECT CONCAT(e.first_name,' ', e.last_name) AS full_name, d.dept_name FROM employees e JOIN dept_emp USING(emp_no) JOIN departments d USING(dept_no);

SELECT * FROM employees_with_departments1 LIMIT 5;

-- 2. Create a temporary table based on the payment table from the sakila database.
USE sakila;

CREATE TEMPORARY TABLE innis_1670.payment_copy AS 
SELECT * FROM payment;

USE innis_1670;
SELECT * FROM payment_copy LIMIT 10;

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

ALTER TABLE payment_copy MODIFY COLUMN amount INT(5);
SELECT * FROM payment_copy LIMIT 10;

-- 3. Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

SELECT avg(salary) FROM employees.salaries;
SELECT stddev(salary) FROM employees.salaries;

--  Find out how the current average pay in each department compares to the overall

SELECT dept_name, ROUND(AVG(salary),2) AS avg_salary
FROM employees.salaries
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
WHERE employees.dept_emp.to_date > now()
AND employees.salaries.to_date > now()
GROUP BY dept_name; 

-- historical average pay
-- 63810.7448
SELECT avg(salary) FROM employees.salaries;
-- historical STDDEV
-- 16904.82828800014
SELECT STDDEV(salary) FROM employees.salaries;


-- In terms of salary, what is the best department right now to work for? The worst?

CREATE TEMPORARY TABLE dept_current_avg AS (
SELECT dept_name, ROUND(AVG(salary),2) AS avg_salary
FROM employees.salaries
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
WHERE employees.dept_emp.to_date > now()
AND employees.salaries.to_date > now()
GROUP BY dept_name); 

SELECT * FROM dept_current_avg; 

-- In order to make the comparison easier, you should use the Z-score for salaries 
-- z = (avg_salary - histavg)/stddev
-- historical average pay
-- 63810.7448
-- historical STDDEV
-- 16904.82828800014

ALTER TABLE dept_current_avg ADD hist_avg FLOAT(7,2);
UPDATE dept_current_avg SET hist_avg = 63810.7448;
ALTER TABLE dept_current_avg ADD z_score FLOAT(7,2);
UPDATE dept_current_avg SET z_score = ((avg_salary - hist_avg)/(16904.82828800014));