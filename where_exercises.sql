-- Create a file named where_exercises.sql. Make sure to use the employees database.
USE employees;

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned. 

DESCRIBE employees;
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

SELECT '709 Records returned' AS message;

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2? YES

SELECT *
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';

SELECT '709 Records returned' AS message;

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned. 

SELECT *
FROM employees
WHERE gender='M' AND (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya');

SELECT '7441 Records returned' AS message;

-- Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E. 

SELECT *
FROM employees
WHERE last_name LIKE 'E%';

SELECT '7330 Records returned' AS message;

-- Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E? 

SELECT *
FROM employees
WHERE last_name LIKE 'E%' OR last_name LIKE '%E';

SELECT '7330 Starts with E and 24292 ends with E' AS message;

-- Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?

SELECT *
FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E';

SELECT '899 Records returned' AS message;

-- Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.

SELECT *
FROM employees
WHERE hire_date LIKE '199%' ;

SELECT '135214 Records returned' AS message;

-- Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.

SELECT *
FROM employees
WHERE birth_date LIKE '%12-25' ;

SELECT '842 Records returned' AS message;

-- Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.

SELECT *
FROM employees
WHERE hire_date LIKE '199%' AND birth_date LIKE '%12-25';

SELECT '362 Records returned' AS message;

-- Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.

SELECT *
FROM employees
WHERE last_name LIKE '%Q%';

SELECT '1873 Records returned' AS message;

-- Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?

SELECT *
FROM employees
WHERE last_name LIKE '%Q%' AND last_name NOT LIKE '%QU%';

SELECT '547 Records returned' AS message;