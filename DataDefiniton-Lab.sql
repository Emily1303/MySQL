CREATE DATABASE gamebar;

CREATE TABLE employees (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE categories (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL, 
    category_id INT NOT NULL
);

INSERT INTO employees VALUES (1, 'Stefan', 'Ivanov');
INSERT INTO employees VALUES (2, 'Ivan', 'Ivanov');
INSERT INTO employees VALUES (3, 'Petar', 'Petrov');

ALTER TABLE employees
ADD COLUMN middle_name VARCHAR(50) NOT NULL;

ALTER TABLE products
ADD CONSTRAINT fk_products_categories
FOREIGN KEY(category_id) REFERENCES categories(id);

ALTER TABLE employees
MODIFY COLUMN middle_name VARCHAR(100);