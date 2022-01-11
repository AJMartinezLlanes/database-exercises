-- Use the join_example_db. Select all the records from both the users and roles tables.
-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.

USE join_example_db;
DESCRIBE users;
-- JOIN

SELECT users.name as user_name, roles.name as role_name
FROM users
JOIN roles ON users.role_id = roles.id;

-- LEFT JOIN

SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

-- RIGHT JOIN

SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

SELECT roles.name AS role_name, COUNT(*) number_of_users
FROM users
RIGHT JOIN roles ON users.role_id = roles.id
GROUP BY role_name;


-- Use the employees database.
USE employees;

-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.


SELECT d.dept_name as dept_name, 
	CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM departments AS d
JOIN dept_manager AS dm
	ON d.dept_no = dm.dept_no
JOIN employees AS e
	ON dm.emp_no = e.emp_no
WHERE dm.to_date = '9999-01-01'; 

-- Find the name of all departments currently managed by women.

SELECT d.dept_name as dept_name, 
	CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM departments AS d
JOIN dept_manager AS dm
	ON d.dept_no = dm.dept_no
JOIN employees AS e
	ON dm.emp_no = e.emp_no
WHERE dm.to_date = '9999-01-01' AND e.gender = 'F';

-- Find the current titles of employees currently working in the Customer Service department.

SELECT t.title as Title, COUNT(*) AS Count
FROM departments AS d
JOIN dept_emp AS de
	ON d.dept_no = de.dept_no
JOIN titles AS t
	ON de.emp_no = t.emp_no
WHERE de.dept_no = 'd009' AND de.to_date = '9999-01-01'
GROUP BY Title; 

-- Find the current salary of all current managers.

SELECT d.dept_name as dept_name, 
	CONCAT(e.first_name, ' ', e.last_name) AS full_name,
	s.salary AS Salary
FROM departments AS d
JOIN dept_manager AS dm
	ON d.dept_no = dm.dept_no
JOIN employees AS e
	ON dm.emp_no = e.emp_no
JOIN salaries AS s
	ON dm.emp_no = s.emp_no
WHERE dm.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
ORDER BY dept_name; 

-- Find the number of current employees in each department.

SELECT d.dept_no AS dept_no,
	d.dept_name AS dept_name,
	COUNT(*) 
FROM departments AS d
JOIN dept_emp AS de
	ON de.dept_no = d.dept_no
JOIN employees AS e
	ON de.emp_no = e.emp_no
WHERE de.to_date = '9999-01-01' 
GROUP BY dept_name
ORDER BY dept_no;
 
-- Which department has the highest average salary? Hint: Use current not historic information.

SELECT d.dept_name AS dept_name,
	AVG(s.salary) AS average_salary
FROM departments AS d
JOIN dept_emp AS de
	ON de.dept_no = d.dept_no
JOIN salaries AS s
	ON s.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
GROUP BY dept_name
ORDER BY average_salary DESC LIMIT 1;

-- Who is the highest paid employee in the Marketing department?

SELECT e.first_name AS first_name,
	e.last_name AS last_name,
	MAX(s.salary) AS salary
FROM employees AS e
RIGHT JOIN salaries AS s
	ON s.emp_no = e.emp_no
LEFT JOIN dept_emp AS de
	ON de.emp_no = e.emp_no
WHERE de.dept_no = 'd001' AND s.to_date = '9999-01-01'
GROUP BY first_name, last_name
ORDER BY salary DESC LIMIT 1;

-- Which current department manager has the highest salary?

SELECT e.first_name AS first_name, 
	e.last_name AS last_name,
	s.salary AS salary,
	d.dept_name as dept_name
FROM departments AS d
JOIN dept_manager AS dm
	ON d.dept_no = dm.dept_no
JOIN employees AS e
	ON dm.emp_no = e.emp_no
JOIN salaries AS s
	ON dm.emp_no = s.emp_no
WHERE dm.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
ORDER BY Salary DESC LIMIT 1; 

-- Determine the average salary for each department. Use all salary information and round your results.

SELECT d.dept_name AS dept_name,
	ROUND (AVG(s.salary)) AS average_salary
FROM departments AS d
JOIN dept_emp AS de
	ON de.dept_no = d.dept_no
JOIN salaries AS s
	ON s.emp_no = de.emp_no
GROUP BY dept_name
ORDER BY average_salary DESC;

