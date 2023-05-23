/*Car rental database*/
CREATE DATABASE car_rental;

CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category VARCHAR(50) NOT NULL,
    daily_rate INT,
    weekly_rate INT,
    monthly_rate INT,
    weekend_rate INT
);

CREATE TABLE cars (
    id INT PRIMARY KEY AUTO_INCREMENT,
    plate_number VARCHAR(20) NOT NULL,
    make VARCHAR(30),
    model VARCHAR(50) NOT NULL,
    car_year YEAR NOT NULL,
    category_id INT NOT NULL,
    doors INT NOT NULL,
    picture BLOB,
    car_condition VARCHAR(30),
    available BOOLEAN NOT NULL,
    FOREIGN KEY (category_id)
        REFERENCES categories (id)
);

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    title VARCHAR(40),
    notes TEXT
);

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    driver_licence_number VARCHAR(30) NOT NULL,
    full_name VARCHAR(60) NOT NULL,
    address VARCHAR(100),
    city VARCHAR(30) NOT NULL,
    zip_code VARCHAR(30),
    notes TEXT
);

CREATE TABLE rental_orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    customer_id INT NOT NULL,
    car_id INT NOT NULL,
    car_condition VARCHAR(50),
    tank_level VARCHAR(50),
    kilometrage_start VARCHAR(50) NOT NULL,
    kilometrage_end VARCHAR(50) NOT NULL,
    total_kilometrage VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_days INT NOT NULL,
    rate_applied INT,
    tax_rate INT,
    order_status VARCHAR(50),
    notes TEXT,
    FOREIGN KEY (employee_id)
        REFERENCES employees (id),
    FOREIGN KEY (customer_id)
        REFERENCES customers (id),
    FOREIGN KEY (car_id)
        REFERENCES cars (id)
);

INSERT INTO categories (category) 
VALUES ('Jeep'), ('Van'), ('Minivan');

INSERT INTO cars (plate_number, model, car_year, category_id, doors, available) 
VALUES ('CA2489OP', 'Opel', '2013', 2, 5, true), 
('PB6429KP', 'VW', '2020', 3, 5, false), 
('CA6689MN', 'BMW', '2018', 1, 5, true);

INSERT INTO employees (first_name, last_name) 
VALUES ('Ivan', 'Ivanov'), ('Petar', 'Petrov'), ('Georgi', 'Todorov');

INSERT INTO customers (driver_licence_number, full_name, city) 
VALUES ('056637383836', 'Ivan Petrov', 'Sofia'), 
('363288292929', 'Georgi Ivanov', 'Plovdiv'), 
('355362627272', 'Todor Todorov', 'Sofia');

INSERT INTO rental_orders (employee_id, customer_id, car_id, kilometrage_start, kilometrage_end, total_kilometrage, start_date, end_date, total_days) 
VALUES (2, 1, 3, '500000', '600000', '100000', '2021-09-01', '2021-09-09', 9), 
(1, 3, 1, '550000', '750000', '200000', '2016-05-05', '2016-05-20', 16), 
(3, 2, 2, '330000', '660000', '330000', '2022-07-01', '2022-08-01', 32);

/*Basic insert*/
CREATE DATABASE soft_uni;

CREATE TABLE towns (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL
);

CREATE TABLE addresses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    address_text VARCHAR(100) NOT NULL,
    town_id INT,
    FOREIGN KEY (town_id)
        REFERENCES towns (id)
);

CREATE TABLE departments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    middle_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    job_title VARCHAR(40) NOT NULL,
    department_id INT,
    hire_date DATE NOT NULL,
    salary DOUBLE(10 , 2 ) NOT NULL,
    address_id INT,
    FOREIGN KEY (department_id)
        REFERENCES departments (id),
    FOREIGN KEY (address_id)
        REFERENCES addresses (id)
);

INSERT INTO towns (name)
VALUES ('Sofia'), ('Plovdiv'), ('Varna'), ('Burgas');

INSERT INTO departments (name) 
VALUES ('Engineering'), ('Sales'), ('Marketing'), ('Software Development'), ('Quality Assurance');

INSERT INTO employees (first_name, middle_name, last_name, job_title, department_id, hire_date, salary) 
VALUES ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00), 
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25), 
('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00), 
('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);

/*Basic Select all fields*/
SELECT * FROM towns;
SELECT * FROM departments;
SELECT * FROM employees;

/*Basic Select all fields and Order them*/
SELECT * FROM towns 
ORDER BY name ASC;

SELECT * FROM departments 
ORDER BY name ASC;

SELECT * FROM employees 
ORDER BY salary DESC;

/*Basic Select some fields*/
SELECT name FROM towns 
ORDER BY name ASC;

SELECT name FROM departments 
ORDER BY name ASC;

SELECT first_name, last_name, job_title, salary FROM employees 
ORDER BY salary DESC;

/*Increase employees salary*/
UPDATE employees 
SET salary = salary + (salary * 0.1)
WHERE salary > 0;

SELECT salary FROM employees;
