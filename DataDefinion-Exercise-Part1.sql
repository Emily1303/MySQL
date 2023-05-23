/*Create Database*/
CREATE DATABASE minions;

/*Create tables*/
CREATE TABLE minions (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL, 
    age INT NOT NULL
);

CREATE TABLE towns (
	town_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL
);

/*Alter minions table*/
ALTER TABLE minions
ADD COLUMN town_id INT NOT NULL;

ALTER TABLE minions 
ADD CONSTRAINT fk_minions_towns 
FOREIGN KEY(town_id) REFERENCES towns(id);

/*Insert records in both tables*/
INSERT INTO towns VALUES (1, 'Sofia');
INSERT INTO towns VALUES (2, 'Plovdiv');
INSERT INTO towns VALUES (3, 'Varna');

ALTER TABLE minions 
MODIFY COLUMN age INT;
INSERT INTO minions VALUES (1, 'Kevin', 22, 1);
INSERT INTO minions VALUES (2, 'Bob', 15, 3);
INSERT INTO minions VALUES (3, 'Steward', NULL , 2);

/*Truncate table minions*/
TRUNCATE TABLE minions;

/*Drop all tables*/
DROP TABLE minions;
DROP TABLE towns;

/*Create table people*/
CREATE TABLE people (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    picture BLOB,
    height DOUBLE(3 , 2 ),
    weight DOUBLE(5 , 2 ),
    gender CHAR(1) NOT NULL,
    birthdate DATE NOT NULL,
    biography TEXT
);

INSERT INTO people (name, height, weight, gender, birthdate) 
VALUES ('Ivan Ivanov', 1.80, 80.0, 'm', '1980-09-09'),
('Petar Petrov', 1.60, 60.0, 'm', '2000-07-23'),
('Stefan Stefanov', 1.80, 80.0, 'm', '2000-03-09'),
('Maria Petrova', 1.60, 60.0, 'f', '2002-05-30'),
('Stanislava Ivanova', 1.56, 50.0, 'f', '2002-05-13');

/*Create table users*/
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL,
    password VARCHAR(26) NOT NULL,
    profile_picture BLOB,
    last_login_time TIMESTAMP,
    is_deleted BOOLEAN
);

INSERT INTO users (username, password) 
VALUES ('Ivo20', '123456'), 
('Ivi12345', 'ivi123456789'), 
('Stefo50', 'stefo40'), 
('Monika15', '123456789'), 
('Pepi2345', 'pepi15');

/*Change primary key*/
ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users 
PRIMARY KEY (id, username);

/*Set default value of a field*/
ALTER TABLE users
CHANGE COLUMN last_login_time last_login_time DATETIME DEFAULT NOW();

/*Set unique field*/
ALTER TABLE users 
DROP PRIMARY KEY, 
ADD CONSTRAINT pk_users
PRIMARY KEY(id);

ALTER TABLE users 
ADD CONSTRAINT uq_username
UNIQUE(username);

/*Movies database*/
CREATE DATABASE movies;

CREATE TABLE directors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    director_name VARCHAR(50) NOT NULL,
    notes TEXT
);

CREATE TABLE genres (
    id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(20) NOT NULL,
    notes TEXT
); 

CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(30) NOT NULL,
    notes TEXT
);

CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    director_id INT,
    copyright_year YEAR,
    length TIME,
    genre_id INT,
    category_id INT,
    rating DOUBLE(3 , 2 ),
    notes TEXT
);

INSERT INTO directors (director_name) 
VALUES ('Petar Petrov'), ('John Bricks'), ('Ivan Ivanov'), ('Georgi Ivanov'), ('Teodor Petrov');

INSERT INTO genres (genre_name) 
VALUES ('horror'), ('triller'), ('adventure'), ('comedy'), ('romance');

INSERT INTO categories (category_name) 
VALUES ('intersting'), ('interesting'), ('boring'), ('famous'), ('famous');

INSERT INTO movies (title, director_id, genre_id, category_id) 
VALUES ('Lord of The Rings', 1, 3, 1), ('Back to the Future', 5, 3, 2), ('Blended', 4, 4, 5), 
('Pirates', 3, 5, 3), ('To all the boys I have loved before', 2, 5, 4);
