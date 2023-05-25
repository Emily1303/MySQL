/*Find book titles*/
/*First way*/
SELECT title FROM books 
WHERE title LIKE 'The%';

/*Second way*/
SELECT title FROM books 
WHERE SUBSTRING(title, 1, 3) = 'The';

/*Replace titles*/
SELECT REPLACE(title, 'The', '***') FROM books 
WHERE title LIKE 'The%';

/*Sum cost of all books*/
SELECT ROUND(SUM(cost), 2) AS 'Total cost' FROM books;

/*Days lived*/
SELECT CONCAT_WS(' ', first_name, last_name) AS 'Full Name', 
TIMESTAMPDIFF(DAY, born, died) AS 'Days Lived' 
FROM authors;

/*Harry Potter books*/
/*First way*/
SELECT title FROM books 
WHERE title LIKE 'Harry Potter%';

/*Second way*/
SELECT title FROM books 
WHERE title REGEXP '^Harry Potter';