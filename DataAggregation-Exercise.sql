/*Records' count*/
SELECT COUNT(*) AS 'count' FROM wizzard_deposits;

/*Longest magic wand*/
SELECT MAX(magic_wand_size) AS 'longest_magic_wand' FROM wizzard_deposits;

/*Longest magic wand by deposit groups*/
SELECT deposit_group, MAX(magic_wand_size) AS 'longest_magic_wand' FROM wizzard_deposits 
GROUP BY deposit_group 
ORDER BY `longest_magic_wand` ASC, deposit_group ASC;

/*Smallest deposit group per magic wand size*/
SELECT deposit_group FROM wizzard_deposits 
GROUP BY deposit_group 
ORDER BY AVG(magic_wand_size) ASC 
LIMIT 1;

/*Deposits sum*/
SELECT deposit_group, SUM(deposit_amount) AS 'total_sum' FROM wizzard_deposits 
GROUP BY deposit_group 
ORDER BY total_sum ASC;

/*Deposit sum for Ollivander family*/
SELECT deposit_group, SUM(deposit_amount) AS 'total_sum' FROM wizzard_deposits 
WHERE magic_wand_creator = 'Ollivander family' 
GROUP BY deposit_group 
ORDER BY deposit_group ASC;

/*Deposits filter*/
SELECT deposit_group, SUM(deposit_amount) AS 'total_sum' FROM wizzard_deposits 
WHERE magic_wand_creator = 'Ollivander family' 
GROUP BY deposit_group 
HAVING total_sum < 150000 
ORDER BY total_sum DESC;

/*Deposit charge*/
SELECT deposit_group, magic_wand_creator, MIN(deposit_charge) AS 'min_deposit_charge' FROM wizzard_deposits 
GROUP BY deposit_group, magic_wand_creator 
ORDER BY magic_wand_creator ASC, deposit_group ASC;

/*Age groups*/
SELECT 
    CASE
        WHEN age >= 0 AND age <= 10 THEN '[0-10]'
        WHEN age >= 11 AND age <= 20 THEN '[11-20]'
        WHEN age >= 21 AND age <= 30 THEN '[21-30]'
        WHEN age >= 31 AND age <= 40 THEN '[31-40]'
        WHEN age >= 41 AND age <= 50 THEN '[41-50]'
        WHEN age >= 51 AND age <= 60 THEN '[51-60]'
        WHEN age >= 61 THEN '[61+]'
    END AS 'age_group',
    COUNT(*) AS 'wizard_count'
FROM wizzard_deposits
GROUP BY age_group
ORDER BY age_group ASC;

/*First letter*/
SELECT DISTINCT LEFT(first_name, 1) AS 'first_letter' FROM wizzard_deposits 
WHERE deposit_group = 'Troll Chest' 
ORDER BY first_letter ASC;

/*Average interest*/
SELECT deposit_group, is_deposit_expired, AVG(deposit_interest) AS 'average_interest' FROM wizzard_deposits 
WHERE deposit_start_date > '1985-01-01' 
GROUP BY deposit_group, is_deposit_expired 
ORDER BY deposit_group DESC, is_deposit_expired ASC;

/*Part 2 - soft_uni database*/
/*Employees minimum salaries*/
SELECT department_id, MIN(salary) AS 'minimum_salary' FROM employees 
WHERE department_id IN (2, 5, 7) AND hire_date > '2000-01-01'
GROUP BY department_id 
ORDER BY department_id ASC;

/*Employees average salaries*/
CREATE TABLE more_than_30000 AS 
SELECT * FROM employees 
WHERE salary > 30000;

DELETE FROM more_than_30000 
WHERE manager_id = 42;

UPDATE more_than_30000 
SET salary = salary + 5000 
WHERE department_id = 1;

SELECT department_id, AVG(salary) AS 'avg_salary' FROM more_than_30000 
GROUP BY department_id 
ORDER BY department_id ASC;

/*Employees maximum salaries*/
SELECT department_id, MAX(salary) AS 'max_salary' FROM employees 
GROUP BY department_id 
HAVING max_salary NOT BETWEEN 30000 AND 70000 
ORDER BY department_id ASC;

/*Employees count salaries*/
SELECT COUNT(*) FROM employees 
WHERE manager_id IS NULL;

/*3rd highest salary*/
SELECT department_id, 
(SELECT DISTINCT salary FROM employees AS e1
WHERE e1.department_id = employees.department_id
ORDER BY salary DESC 
LIMIT 2, 1) AS 'third_highest_salary'
FROM employees 
GROUP BY department_id 
HAVING third_highest_salary IS NOT NULL 
ORDER BY department_id ASC;

/*Salary challenge*/
SELECT first_name, last_name, department_id FROM employees AS e1
WHERE salary > (
SELECT AVG(salary) FROM employees AS e2 
WHERE e1.department_id = e2.department_id
GROUP BY department_id) 
ORDER BY department_id, employee_id 
LIMIT 10;

/*Departments total salaries*/
SELECT department_id, SUM(salary) AS 'total_salary' FROM employees 
GROUP BY department_id 
ORDER BY department_id ASC;
