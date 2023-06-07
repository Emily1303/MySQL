/*Mountains and peaks*/
CREATE TABLE mountains (
	id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(30) NOT NULL
);

CREATE TABLE peaks (
	id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(30) NOT NULL, 
    mountain_id INT NOT NULL, 
    CONSTRAINT fk_peaks_mountain_id_mountains_id 
    FOREIGN KEY (mountain_id) 
    REFERENCES mountains(id)
);

INSERT INTO mountains (`name`) 
VALUES ('Vitosha'), ('Rila');

INSERT INTO peaks (`name`, mountain_id) 
VALUES ('Cherni Vrah', 1), ('Musala', 2);

SELECT 
    peaks.id, peaks.`name`, mountains.`name`
FROM peaks
	JOIN mountains 
    ON mountains.id = peaks.mountain_id;
    
/*Trip organization*/
SELECT driver_id, vehicle_type, 
CONCAT_WS(' ', first_name, last_name) AS 'driver_name' FROM vehicles 
JOIN campers 
ON driver_id = campers.id;

/*SoftUni hiking*/
SELECT starting_point, end_point, leader_id, 
CONCAT_WS(' ', first_name, last_name) AS 'leader_name' FROM routes 
JOIN campers ON leader_id = campers.id;

/*Delete mountains*/
DROP TABLE peaks;
DROP TABLE mountains;

CREATE TABLE mountains (
	id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(30) NOT NULL
);

CREATE TABLE peaks (
	id INT PRIMARY KEY AUTO_INCREMENT, 
    `name` VARCHAR(30) NOT NULL, 
    mountain_id INT NOT NULL, 
    CONSTRAINT fk_peaks_mountain_id_mountains_id 
    FOREIGN KEY (mountain_id) 
    REFERENCES mountains(id) 
    ON DELETE CASCADE
);

INSERT INTO mountains (`name`) 
VALUES ('Vitosha'), ('Rila');

INSERT INTO peaks (`name`, mountain_id) 
VALUES ('Cherni Vrah', 1), ('Musala', 2);

DELETE FROM mountains 
WHERE id = 2;

SELECT 
    peaks.id, peaks.`name`, mountains.`name`
FROM peaks
	JOIN mountains 
    ON mountains.id = peaks.mountain_id;
    
/*Project management DB*/
CREATE TABLE clients (
	id INT PRIMARY KEY AUTO_INCREMENT, 
    client_name VARCHAR(100)
);

CREATE TABLE projects (
	id INT PRIMARY KEY AUTO_INCREMENT, 
    client_id INT, 
    project_lead_id INT, 
    CONSTRAINT fk_projects_client_id_clients_id 
    FOREIGN KEY (client_id) 
    REFERENCES clients(id)
);

CREATE TABLE employees (
	id INT PRIMARY KEY AUTO_INCREMENT, 
    first_name VARCHAR(30), 
    last_name VARCHAR(30), 
    project_id INT, 
    CONSTRAINT fk_employees_project_id_projects_id 
    FOREIGN KEY (project_id) 
    REFERENCES projects(id)
);

ALTER TABLE projects 
ADD CONSTRAINT fk_projects_project_lead_id_employees_id 
FOREIGN KEY (project_lead_id) 
REFERENCES employees(id);
