/*Section 1: Data Definition Language (DDL) – 40 pts*/
/*01.Table Design - 40 points*/
CREATE TABLE countries (
	id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE cities (
	id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(40) NOT NULL UNIQUE, 
    population INT, 
    country_id INT NOT NULL, 
    CONSTRAINT fk_cities_country_id_countries_id 
    FOREIGN KEY (country_id) 
    REFERENCES countries(id)
);

CREATE TABLE universities (
	id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(60) NOT NULL UNIQUE, 
    address VARCHAR(80) NOT NULL UNIQUE, 
    tuition_fee DECIMAL(19, 2) NOT NULL, 
    number_of_staff INT, 
    city_id INT, 
    CONSTRAINT fk_universities_city_id_cities_id 
    FOREIGN KEY (city_id) 
    REFERENCES cities(id)
);

CREATE TABLE students (
	id INT PRIMARY KEY AUTO_INCREMENT, 
    first_name VARCHAR(40) NOT NULL, 
    last_name VARCHAR(40) NOT NULL, 
    age INT, 
    phone VARCHAR(20) NOT NULL UNIQUE, 
    email VARCHAR(255) NOT NULL UNIQUE, 
    is_graduated TINYINT(1) NOT NULL, 
    city_id INT, 
    CONSTRAINT fk_students_city_id_cities_id 
    FOREIGN KEY (city_id) 
    REFERENCES cities(id)
);

CREATE TABLE courses (
	id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(40) NOT NULL UNIQUE, 
    duration_hours DECIMAL(19, 2), 
    start_date DATE, 
    teacher_name VARCHAR(60) NOT NULL UNIQUE, 
    `description` TEXT, 
    university_id INT, 
    CONSTRAINT fk_courses_university_id_universities_id 
    FOREIGN KEY (university_id) 
    REFERENCES universities(id)
);

CREATE TABLE students_courses (
	grade DECIMAL(19, 2) NOT NULL, 
    student_id INT NOT NULL, 
    course_id INT NOT NULL, 
    CONSTRAINT fk_students_courses_student_id_students_id 
    FOREIGN KEY (student_id) 
    REFERENCES students(id), 
    CONSTRAINT fk_students_courses_course_id_courses_id 
    FOREIGN KEY (course_id) 
    REFERENCES courses(id)
);

/*Section 2: Data Manipulation Language (DML) – 30 pts*/
/*02.Insert - 10 points*/
INSERT INTO courses(`name`, duration_hours, start_date, teacher_name, `description`, university_id)
SELECT CONCAT_WS(' ', c.teacher_name, 'course'), CHAR_LENGTH(c.`name`) / 10, DATE_ADD(c.start_date, INTERVAL 5 DAY), 
REVERSE(c.teacher_name), CONCAT('Course ', c.teacher_name, REVERSE(c.`description`)), EXTRACT(DAY FROM c.start_date)
FROM courses AS c
WHERE c.id <= 5;

/*03.Update - 10 points*/
UPDATE universities 
SET tuition_fee = tuition_fee + 300 
WHERE universities.id BETWEEN 5 AND 12;

/*04.Delete - 10 points*/
DELETE FROM universities 
WHERE number_of_staff IS NULL;

/*Section 3: Querying – 50 pts*/
/*05.Cities - 10 points*/
SELECT * FROM cities 
ORDER BY population DESC;

/*06.Students age - 10 points*/
SELECT first_name, last_name, age, phone, email FROM students 
WHERE age >= 21 
ORDER BY first_name DESC, email ASC, id ASC 
LIMIT 10;

/*07.New students - 10 points*/
SELECT CONCAT_WS(' ', s.first_name, s.last_name) AS 'full_name', 
SUBSTRING(s.email, 2, 10) AS 'username', 
REVERSE(s.phone) AS 'password'
FROM students AS s 
LEFT JOIN students_courses AS sc 
ON s.id = sc.student_id 
WHERE sc.course_id IS NULL 
ORDER BY `password` DESC;

/*08.Students count - 10 points*/
SELECT COUNT(*) AS 'students_count', 
u.`name` AS 'university_name'
FROM universities AS u 
JOIN courses AS c 
ON u.id = c.university_id 
JOIN students_courses AS sc 
ON c.id = sc.course_id 
GROUP BY u.id 
HAVING students_count >= 8 
ORDER BY students_count DESC, university_name DESC;

/*09.Price rankings - 10 points*/
SELECT u.`name` AS 'university_name', 
c.`name` AS 'city_name', 
u.address, 
(CASE 
	WHEN u.tuition_fee < 800 THEN 'cheap' 
    WHEN u.tuition_fee >= 800 AND u.tuition_fee < 1200 THEN 'normal' 
    WHEN u.tuition_fee >= 1200 AND u.tuition_fee < 2500 THEN 'high' 
    WHEN u.tuition_fee >= 2500 THEN 'expensive'
END) AS 'price_rank', 
u.tuition_fee 
FROM universities AS u 
JOIN cities AS c 
ON u.city_id = c.id 
ORDER BY u.tuition_fee ASC;

/*Section 4: Programmability – 30 pts*/
/*10.Average grades - 15 points*/
DELIMITER $$ 
CREATE FUNCTION udf_average_alumni_grade_by_course_name(course_name VARCHAR(60)) 
RETURNS DECIMAL(5, 2) 
DETERMINISTIC 
BEGIN 
	RETURN (SELECT AVG(sc.grade) FROM courses AS c 
	JOIN students_courses AS sc 
	ON c.id = sc.course_id 
    JOIN students AS s 
    ON sc.student_id = s.id 
    WHERE s.is_graduated = TRUE AND c.`name` = course_name 
	GROUP BY c.`name`);
END $$
DELIMITER ;
;

SELECT courses.`name`, udf_average_alumni_grade_by_course_name('Quantum Physics') AS 'average_alumni_grade'
FROM courses 
WHERE `name` = 'Quantum Physics';

/*11.Graduate students - 15 points*/
DELIMITER $$ 
CREATE PROCEDURE udp_graduate_all_students_by_year(year_started INT) 
BEGIN 
	UPDATE students AS s 
	JOIN students_courses AS sc 
	ON sc.student_id = s.id
	JOIN courses AS c 
	ON c.id = sc.course_id 
	SET s.is_graduated = TRUE 
	WHERE YEAR(c.start_date) = year_started;
END $$ 
DELIMITER ;
;

CALL udp_graduate_all_students_by_year(2017);

SELECT * FROM students AS s 
JOIN students_courses AS sc 
ON sc.student_id = s.id
JOIN courses AS c 
ON c.id = sc.course_id 
WHERE YEAR(c.start_date) = 2017;

