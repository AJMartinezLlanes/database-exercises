-- Create a file named case_exercises.sql and craft queries to return the results for the following criteria:
USE employees;
-- Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
SHOW tables;
DESCRIBE employees;

SELECT
	dept_no, from_date, to_date,
	CASE 
	WHEN to_date > CURDATE() THEN 1 ELSE 0
	END AS is_current_employee
FROM dept_emp;

-- using IF Function

SELECT
    dept_no, from_date, to_date,
    IF(to_date > CURDATE() , 1, 0) AS is_current_employee
FROM dept_emp;

-- Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT
	first_name, last_name,
	CASE 
	WHEN SUBSTR(last_name,1,1) IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H') THEN 'A-H'
	WHEN SUBSTR(last_name,1,1) IN ('I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q') THEN 'I-Q'  
	ELSE 'R-Z'
	END AS alpha_group
FROM employees;

-- using IF function

SELECT
    first_name, last_name,
    IF(SUBSTR(last_name,1,1) BETWEEN 'A' AND 'H', 'A-H',
	IF(SUBSTR(last_name,1,1) BETWEEN 'I' AND 'Q', 'I-Q',
	'R-Z')) AS alpha_group
FROM employees;

-- How many employees (current or previous) were born in each decade?

DESCRIBE employees;
SELECT * FROM employees LIMIT 1;

SELECT 
	COUNT(emp_no) AS employees,
	CASE 
	WHEN birth_date LIKE '195%' THEN '50s'
	WHEN birth_date LIKE '196%' THEN '60s'
	END AS decade
FROM employees
GROUP BY decade;

-- using IF Function

SELECT
    COUNT(emp_no) AS employees,
    IF(birth_Date LIKE '195%', '50s', '60s') AS decade
FROM employees
GROUP BY decade
;

-- What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
DESCRIBE departments;
SELECT DISTINCT dept_name FROM departments;

SELECT
	CASE 
	WHEN dept_name IN('Research', 'Development') THEN 'R&D'
	WHEN dept_name IN('Sales', 'Marketing') THEN 'Sales & Marketing'
	WHEN dept_name IN('Production', 'Quality Management') THEN 'Prod & QM'
	WHEN dept_name IN('Finance', 'Human Resources') THEN 'Finance & HR'
	ELSE 'Customer Service'
	END AS department_group, ROUND(AVG(salary),2) AS salary_in_USD
FROM departments
JOIN dept_emp de USING(dept_no)
JOIN salaries s USING(emp_no)
WHERE de.to_date > CURDATE() AND s.to_date > CURDATE()
GROUP BY department_group
ORDER BY salary_in_USD
;
