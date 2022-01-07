-- 1. Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.
USE employees;

-- 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

DESCRIBE employees;
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

SELECT 'First: Irena Reutenauer, Last: Vidya Simmen' AS message;

-- 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

SELECT 'First: Irena Acton, Last: Vidya Zweizig' AS message;

-- 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

SELECT 'First: Irena Acton, Last: Maya Zyda' AS message;

-- 5. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name

SELECT *
FROM employees
WHERE last_name LIKE 'E%E'
ORDER BY emp_no;

SELECT 'First: Ramzi Erde, Last: Tadahiro Erde	' AS message;

-- 6.Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.

SELECT *
FROM employees
WHERE last_name LIKE 'E%E'
ORDER BY hire_date;

SELECT 'First: Sergi Erde, Last: Teiji Eldridge' AS message;

-- 7. Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.

SELECT *
FROM employees
WHERE hire_date LIKE '199%' 
AND birth_date LIKE '%12-25'
ORDER BY birth_date, hire_date DESC;

SELECT '362 Records returned, oldest employee who was hired last: Khun, Bernini, and the name of the youngest employee who was hired first: Douadi Pettis' AS message;