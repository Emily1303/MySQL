/*Part 1 - soft_uni database*/
/*Find names of all employees by first name*/
SELECT first_name, last_name FROM employees 
WHERE first_name LIKE 'Sa%' 
ORDER BY employee_id;

/*Find names of all employees by last name*/
SELECT first_name, last_name FROM employees 
WHERE last_name LIKE '%ei%' 
ORDER BY employee_id;

/*Find first names of all employees*/
SELECT first_name FROM employees 
WHERE department_id IN (3, 10) AND 
hire_date BETWEEN '1995-01-01' AND '2005-12-31' 
ORDER BY employee_id;

/*Find all employees except engineers*/
SELECT first_name, last_name FROM employees 
WHERE job_title NOT LIKE '%engineer%' 
ORDER BY employee_id;

/*Find towns with name length*/
SELECT name FROM towns 
WHERE CHAR_LENGTH(name) IN (5, 6) 
ORDER BY name ASC;

/*Find towns starting with*/
SELECT * FROM towns 
WHERE name REGEXP '^[MKBEmkbe]' 
ORDER BY name ASC;

/*Find towns not starting with*/
SELECT * FROM towns 
WHERE name REGEXP '^[^RBDrbd]' 
ORDER BY name ASC;

/*Create view employees hired after 2000 year*/
CREATE VIEW `v_employees_hired_after_2000` AS 
SELECT first_name, last_name FROM employees 
WHERE hire_date > '2000-12-31';

SELECT * FROM v_employees_hired_after_2000;

/*Length of last name*/
SELECT first_name, last_name FROM employees 
WHERE CHAR_LENGTH(last_name) = 5;

/*Part 2 - geography database*/
/*Countries holding 'A' 3 or more times*/
SELECT country_name, iso_code FROM countries 
WHERE country_name LIKE '%a%a%a%' 
ORDER BY iso_code;

/*Mix of peak and river names*/
SELECT peak_name, river_name, LOWER(CONCAT(peak_name, SUBSTRING(river_name, 2))) AS 'mix' 
FROM peaks, rivers 
WHERE RIGHT(peak_name, 1) = LOWER(LEFT(river_name, 1)) 
ORDER BY mix ASC;

/*Part 3 - diablo database*/
/*Games from 2011 and 2012 year*/
SELECT name, DATE_FORMAT(start, '%Y-%m-%d') AS 'start'FROM games 
WHERE start BETWEEN '2011-01-01' AND '2012-12-31' 
ORDER BY start ASC, name ASC  
LIMIT 50;

/*User email providers*/
SELECT user_name, SUBSTRING(email, LOCATE('@', email) + 1) AS 'email_provider' 
FROM users 
ORDER BY email_provider ASC, user_name ASC;

/*Get users with IP address like pattern*/
SELECT user_name, ip_address FROM users 
WHERE ip_address LIKE '___.1%.%.___' 
ORDER BY user_name ASC;

/*Show all games with duration and part of the day*/
SELECT name, 
CASE WHEN EXTRACT(HOUR FROM start) BETWEEN 0 AND 11 THEN 'Morning'
WHEN EXTRACT(HOUR FROM start) BETWEEN 12 AND 17 THEN 'Afternoon' 
WHEN EXTRACT(HOUR FROM start) BETWEEN 18 AND 23 THEN 'Evening' END AS 'Part of the Day', 
CASE WHEN duration <= 3 THEN 'Extra Short'
WHEN duration > 3 AND duration <= 6 THEN 'Short' 
WHEN duration > 6 AND duration <= 10 THEN 'Long' ELSE 'Extra Long' END AS 'duration' FROM games;

/*Part 4 - orders database*/
/*Orders table*/
SELECT product_name, order_date, DATE_ADD(order_date, INTERVAL 3 DAY) AS 'pay_due', 
DATE_ADD(order_date, INTERVAL 1 MONTH) AS 'deliver_due' FROM orders;