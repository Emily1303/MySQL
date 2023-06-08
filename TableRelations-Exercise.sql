/*One-To-One relationship*/
CREATE TABLE passports (
	passport_id INT PRIMARY KEY AUTO_INCREMENT, 
    passport_number VARCHAR(30) NOT NULL
);

CREATE TABLE people (
	person_id INT PRIMARY KEY AUTO_INCREMENT, 
    first_name VARCHAR(30) NOT NULL, 
    salary DECIMAL (10, 2), 
    passport_id INT NOT NULL UNIQUE, 
    CONSTRAINT fk_people_passport_id_passports_passport_id 
    FOREIGN KEY (passport_id) 
    REFERENCES passports(passport_id)
);

INSERT INTO passports 
VALUES (101, 'N34FG21B');
INSERT INTO passports(passport_number) 
VALUES ('K65LO4R7'), ('ZE657QP2');

INSERT INTO people (first_name, salary, passport_id) 
VALUES ('Roberto', 43300.000, 102), ('Tom', 56100.000, 103), ('Yana', 60200.000, 101);

/*SELECT first_name, salary, p.passport_id, p.passport_number FROM people 
JOIN passports AS p 
ON people.passport_id = p.passport_id;*/

/*One-To-Many relationship*/
CREATE TABLE manufacturers (
	manufacturer_id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(30) NOT NULL, 
    established_on DATE
);

CREATE TABLE models (
	model_id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(30) NOT NULL, 
    manufacturer_id INT NOT NULL, 
    CONSTRAINT fk_models_manufacturer_id_manufacturers_manufacturer_id 
    FOREIGN KEY (manufacturer_id) 
    REFERENCES manufacturers(manufacturer_id)
);

INSERT INTO manufacturers (`name`, established_on) 
VALUES ('BMW', '1916-03-01'), ('Tesla', '2003-01-01'), ('Lada', '1966-05-01');

INSERT INTO models 
VALUES (101, 'X1', 1);
INSERT INTO models (`name`, manufacturer_id) 
VALUES ('i6', 1), ('Model S', 2), ('Model X', 2), ('Model 3', 2), ('Nova', 3);

/*SELECT model_id, models.`name`, m.`name`, m.established_on  FROM models 
JOIN manufacturers AS m 
ON models.manufacturer_id = m.manufacturer_id;*/

/*Many-To-Many relationship*/
CREATE TABLE students (
	student_id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(30) NOT NULL
);

CREATE TABLE exams (
	exam_id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(30) NOT NULL
);

CREATE TABLE students_exams (
	student_id INT NOT NULL, 
    exam_id INT NOT NULL, 
    CONSTRAINT pk_student_id_exam_id 
    PRIMARY KEY (student_id, exam_id), 
    CONSTRAINT fk_students_exams_student_id_students_student_id 
    FOREIGN KEY (student_id) 
    REFERENCES students(student_id), 
    CONSTRAINT fk_students_exams_exam_id_exams_exam_id 
    FOREIGN KEY (exam_id) 
    REFERENCES exams(exam_id)
);

INSERT INTO students (`name`) 
VALUES ('Mila'), ('Toni'), ('Ron');

INSERT INTO exams 
VALUES (101, 'Spring MVC');
INSERT INTO exams (`name`) 
VALUES ('Neo4j'), ('Oracle 11g');

INSERT INTO students_exams 
VALUES (1, 101), (1, 102), (2, 101), (3, 103), (2, 102), (2, 103);

/*Self-referencing*/
CREATE TABLE teachers (
	teacher_id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(50) NOT NULL, 
    manager_id INT DEFAULT NULL
);

ALTER TABLE teachers 
ADD CONSTRAINT fk_teachers_manager_id_teachers_teachers_id 
FOREIGN KEY (manager_id) 
REFERENCES teachers(teacher_id);

ALTER TABLE teachers AUTO_INCREMENT = 101;

INSERT INTO teachers (`name`) 
VALUES ('John'), ('Maya'), ('Silvia'), ('Ted'), ('Mark'), ('Greta');

UPDATE teachers 
SET manager_id = 106 
WHERE `name` = 'Maya' OR `name` = 'Silvia';

UPDATE teachers 
SET manager_id = 105 
WHERE `name` = 'Ted';

UPDATE teachers 
SET manager_id = 101 
WHERE `name` = 'Mark' OR `name` = 'Greta';

/*Online store database*/
CREATE DATABASE online_store_one;

CREATE TABLE cities (
	city_id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(50)
);

CREATE TABLE customers (
	customer_id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(50), 
    birthday DATE, 
    city_id INT, 
    CONSTRAINT fk_customers_city_id_cities_city_id 
    FOREIGN KEY (city_id) 
    REFERENCES cities(city_id)
);

CREATE TABLE orders (
	order_id INT PRIMARY KEY AUTO_INCREMENT, 
    customer_id INT, 
    CONSTRAINT fk_orders_customer_id_customers_customer_id 
    FOREIGN KEY (customer_id) 
    REFERENCES customers(customer_id)
);

CREATE TABLE item_types (
	item_type_id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(50)
);

CREATE TABLE items (
	item_id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(50), 
    item_type_id INT, 
    CONSTRAINT fk_items_item_type_id_item_types_item_type_id 
    FOREIGN KEY (item_type_id) 
    REFERENCES item_types(item_type_id)
);

CREATE TABLE order_items (
	order_id INT, 
    item_id INT, 
    CONSTRAINT pk_order_id_item_id 
    PRIMARY KEY (order_id, item_id), 
    CONSTRAINT fk_order_items_order_id_orders_order_id 
    FOREIGN KEY (order_id) 
    REFERENCES orders(order_id), 
    CONSTRAINT fk_order_items_item_id_items_item_id 
    FOREIGN KEY (item_id) 
    REFERENCES items(item_id)
);

/*University database*/
CREATE DATABASE university;

CREATE TABLE majors (
	major_id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(50)
);

CREATE TABLE students (
	student_id INT PRIMARY KEY AUTO_INCREMENT, 
    student_number VARCHAR(12), 
    student_name VARCHAR(50), 
    major_id INT, 
    CONSTRAINT fk_students_major_id_majors_major_id 
    FOREIGN KEY (major_id) 
    REFERENCES majors(major_id)
);

CREATE TABLE payments (
	payment_id INT PRIMARY KEY AUTO_INCREMENT, 
    payment_date DATE, 
    payment_amount DECIMAL(8, 2), 
    student_id INT, 
    CONSTRAINT fk_payments_student_id_students_student_id 
    FOREIGN KEY (student_id) 
    REFERENCES students(student_id)
);

CREATE TABLE subjects (
	subject_id INT PRIMARY KEY AUTO_INCREMENT, 
    subject_name VARCHAR(50)
);

CREATE TABLE agenda (
	student_id INT, 
    subject_id INT, 
    CONSTRAINT pk_student_id_subject_id 
    PRIMARY KEY (student_id, subject_id), 
    CONSTRAINT fk_agenda_student_id_students_student_id 
    FOREIGN KEY (student_id) 
    REFERENCES students(student_id), 
    CONSTRAINT fk_agenda_subject_id_subjects_subject_id 
    FOREIGN KEY (subject_id) 
    REFERENCES subjects(subject_id)
);

/*Peaks in Rila*/
SELECT mountain_range, peak_name, elevation FROM peaks 
JOIN mountains 
ON mountain_id = mountains.id 
WHERE mountain_range = 'Rila' 
ORDER BY elevation DESC;
