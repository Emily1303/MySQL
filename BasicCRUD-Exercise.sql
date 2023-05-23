/*Part 1 - soft_uni database*/
/*Find all information about departments*/
SELECT * FROM departments
ORDER BY department_id;

/*Find all departments name*/
SELECT `name` FROM departments
ORDER BY department_id;

/*Find salary of each employee*/
SELECT first_name, last_name, salary FROM employees
ORDER BY employee_id;

/*Find full name of each employee*/
SELECT first_name, middle_name, last_name FROM employees
ORDER BY employee_id;

/*Find email address of each employee*/
SELECT CONCAT(first_name, '.', last_name, '@softuni.bg') AS 'full_email_address'
FROM employees;

/*Find all different employee's salaries*/
SELECT DISTINCT salary FROM employees;

/*Find all information about employees*/
SELECT *  FROM employees
WHERE job_title = 'Sales Representative'
ORDER BY employee_id;

/*Find names of all employees by salary in range*/
SELECT first_name, last_name, job_title FROM employees
WHERE salary BETWEEN 20000 AND 30000
ORDER BY employee_id;

/*Find names of all employees*/
SELECT CONCAT_WS(' ', first_name, middle_name, last_name) AS 'Full Name' FROM employees 
WHERE salary = 25000 OR salary = 14000 OR salary = 12500 OR salary = 23600;

/*Find all employees without a manager*/
SELECT first_name, last_name FROM employees 
WHERE manager_id IS NULL;

/*Find all employees with salary more than 50000*/
SELECT first_name, last_name, salary FROM employees 
WHERE salary > 50000 
ORDER BY salary DESC;

/*Find 5 best paid employees*/
SELECT first_name, last_name FROM employees 
ORDER BY salary DESC 
LIMIT 5;

/*Find all employees except Marketing*/
SELECT first_name, last_name FROM employees
WHERE NOT department_id = 4;

/*Sort employees table*/
SELECT * FROM employees 
ORDER BY salary DESC, 
first_name ASC, 
last_name DESC, 
middle_name ASC;

/*Create view employees with salaries*/
CREATE VIEW `v_employees_salaries` AS
SELECT first_name, last_name, salary FROM employees;

/*Create view employees with job titles*/
CREATE VIEW `v_employees_job_titles` AS
SELECT CONCAT_WS(' ', first_name, middle_name, last_name) AS 'full_name', job_title
FROM employees;

/*Distinct job titles*/
SELECT DISTINCT job_title FROM employees 
ORDER BY job_title ASC;

/*Find first 10 started projects*/
SELECT * FROM projects 
ORDER BY start_date ASC, 
name ASC 
LIMIT 10;

/*Last 7 hired employees*/
SELECT first_name, last_name, hire_date FROM employees 
ORDER BY hire_date DESC 
LIMIT 7;

/*Increase salaries*/
UPDATE employees 
SET salary = salary + (salary * 0.12) 
WHERE department_id = 1 OR department_id = 2 OR department_id = 4 OR department_id = 11;

SELECT salary FROM employees;

/*Part 2 - geography database*/
/*All mountain peaks*/
SELECT peak_name FROM peaks 
ORDER BY peak_name ASC;

/*Biggest countries by population*/
SELECT country_name, population FROM countries 
WHERE continent_code = 'EU' 
ORDER BY population DESC, 
country_name ASC 
LIMIT 30;

/*Countries and currency (Euro/Not Euro)*/
ALTER TABLE countries 
ADD COLUMN currency VARCHAR(20);

UPDATE countries 
SET currency = 'Euro'
WHERE currency_code = 'EUR';

UPDATE countries 
SET currency = 'Not Euro' 
WHERE NOT currency_code = 'EUR';

SELECT country_name, country_code, currency FROM countries 
WHERE currency = 'Euro' OR currency = 'Not Euro' 
ORDER BY country_name ASC;

/*Part 3 - diablo database*/
/*All diablo characters*/
SELECT `name` FROM characters 
ORDER BY `name` ASC;
