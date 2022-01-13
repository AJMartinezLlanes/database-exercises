-- Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:
-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.

USE employees;
DESCRIBE employees;
SELECT * FROM employees LIMIT 2;

SELECT first_name, last_name, birth_date
FROM employees
JOIN dept_emp USING (emp_no)
WHERE hire_date = (
    SELECT hire_date
    FROM employees
    WHERE emp_no = 101010
    ) 
    AND to_date > CURDATE()
;

-- 2. Find all the titles ever held by all current employees with the first name Aamod.

SELECT DISTINCT e.first_name, e.last_name, t.title
FROM (
    SELECT *
    FROM titles
    ) AS t
JOIN dept_emp de USING (emp_no)
JOIN employees e USING (emp_no)
WHERE e.first_name = 'Aamod'
    AND de.to_date > CURDATE()
;

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

SELECT COUNT(emp_no)
FROM employees
WHERE emp_no NOT IN (
				SELECT emp_no 
				FROM dept_emp 
				WHERE to_date > CURDATE()
				)
;


-- 4. Find all the current department managers that are female. List their names in a comment in your code.
	
SELECT CONCAT(first_name,' ', last_name) 
FROM employees 
WHERE gender = 'f' 
	AND emp_no IN (
				SELECT emp_no 
				FROM dept_manager
				WHERE to_date > CURDATE()
				)
;

SELECT 'Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil' AS message;

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.

SELECT CONCAT(first_name, ' ', last_name) AS full_name, s.salary
FROM employees
JOIN salaries s USING (emp_no)
WHERE s.salary > (
						SELECT AVG (salary) 
						FROM salaries
					)
	AND s.to_date > CURDATE()
ORDER BY s.salary;

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? 83 salaries (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this? 0.03%
-- 7. Hint Number 1 You will likely use a combination of different kinds of subqueries.
-- 8. Hint Number 2 Consider that the following code will produce the z score for current salaries.
/*
Returns the historic z-scores for each salary
Notice that there are 2 separate scalar subqueries involved
SELECT salary, 
    (salary - (SELECT AVG(salary) FROM salaries)) 
    / 
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries; 
*/

SELECT COUNT(*)
FROM salaries
WHERE to_date > CURDATE() 
	AND salary > (
		SELECT MAX(salary) - STDDEV(salary) 
		FROM salaries
		WHERE to_date > CURDATE()
		)
;
select(
	(
	select count(*) 
	from salaries 
	where salary > (
					select max(salary) - std(salary) 
					from salaries 
					where to_date > now()
					) 
	and to_date > now()
	) / (
		select count(*) 
		from salaries 
		where to_date > now()
		) 
	) *100 
AS percent_of_salaries;



-- BONUS

-- 1. Find all the department names that currently have female managers.

SELECT dept_name
FROM departments
WHERE dept_no 
		IN (
			SELECT dept_no  
			FROM dept_manager
			WHERE emp_no 
			IN (
				SELECT emp_no 
				FROM employees
				WHERE to_date > CURDATE()
				AND gender = 'f'	
				)
			)
;

-- 2. Find the first and last name of the employee with the highest salary.

SELECT CONCAT(first_name, ' ', last_name)
FROM employees
WHERE emp_no 
IN (
	SELECT emp_no
	FROM salaries
	WHERE salary = 
		(
		 SELECT MAX(salary)
		FROM salaries
		WHERE to_date > CURDATE()
		 )
	)
;

-- 3. Find the department name that the employee with the highest salary works in.

SELECT dept_name
FROM departments
WHERE dept_no = 
	(
	SELECT dept_no
	FROM dept_emp
	WHERE emp_no = 
			(
			SELECT emp_no
			FROM salaries
			WHERE salary = 
				(
				SELECT MAX(salary)
				FROM salaries
				WHERE to_date > CURDATE()
				)
			)
	)
;