/*Select employee infromation*/
SELECT id, first_name, last_name, job_title 
FROM employees 
ORDER BY id;

/*Select employees with filter*/
SELECT id, CONCAT(first_name, ' ', last_name) as full_name, job_title, salary
FROM employees 
WHERE salary > 1000.00
ORDER BY id;

/*Update employees salary*/
UPDATE employees
SET salary = salary + 100
WHERE job_title = 'Manager';
SELECT salary FROM employees;

/*Top paid employee*/
CREATE VIEW `v_top_paid_employee` AS
SELECT * FROM employees
ORDER BY salary DESC
LIMIT 1;

/*Select employees by multiple filters*/
SELECT * FROM employees
WHERE department_id = 4 AND salary >= 1000
ORDER BY id;

/*Delete from table*/
DELETE FROM employees
WHERE department_id = 1 OR department_id = 2;
SELECT * FROM employees 
ORDER BY id;
