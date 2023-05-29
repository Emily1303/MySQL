/*Departments info*/
SELECT department_id, COUNT(*) AS 'Number of employees' FROM employees 
GROUP BY department_id 
ORDER BY department_id, `Number of employees`;

/*Average salary*/
SELECT department_id, ROUND(AVG(salary), 2) AS 'Average Salary' FROM employees 
GROUP BY department_id 
ORDER BY department_id;

/*Min salary*/
SELECT department_id, MIN(salary) AS 'Min Salary' FROM employees 
GROUP BY department_id 
HAVING `Min Salary` > 800;

/*Appetizers count*/
SELECT COUNT(*) FROM products 
WHERE category_id = 2 AND price > 8;

/*Menu prices*/
SELECT category_id, ROUND(AVG(price), 2) AS 'Average Price', 
ROUND(MIN(price), 2) AS 'Cheapest Product', 
ROUND(MAX(price), 2) AS 'Most Expensive Product' FROM products 
GROUP BY category_id;