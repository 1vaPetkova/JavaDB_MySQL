-- Lab
-- 1.	Count Employees by Town
DELIMITER %%
CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(20))
RETURNS INT DETERMINISTIC
BEGIN
RETURN  (SELECT COUNT(*) AS count
FROM employees AS e
JOIN addresses AS a
ON e.address_id = a.address_id
JOIN towns AS t
ON a.town_id = t.town_id
WHERE t.name = town_name);
END; %%
DELIMITER ;

-- 2.	Employees Promotion
DELIMITER $$
CREATE PROCEDURE usp_raise_salaries (department_name VARCHAR(30))
DETERMINISTIC
BEGIN
UPDATE employees AS e
JOIN departments AS d
USING (department_id)
SET salary = salary * 1.05
WHERE d.name = department_name;
END $$

DELIMITER $$

-- 3. Employees Promotion by ID
DELIMITER $$
CREATE PROCEDURE usp_raise_salary_by_id(id INT) 
BEGIN
START TRANSACTION;
IF( (SELECT COUNT(*) FROM `employees` WHERE `employee_id` = id ) <> 1) THEN ROLLBACK;
ELSE
UPDATE employees
SET salary = salary * 1.05
WHERE employee_id = id;
COMMIT;
END IF;
END $$

DELIMITER ;

-- 4. Triggered
CREATE TABLE deleted_employees (
employee_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(20),
last_name VARCHAR(20),
middle_name VARCHAR(20),
job_title VARCHAR(50),
department_id INT,
salary DECIMAL
);

DELIMITER $$
CREATE TRIGGER tr_deleted_employees
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
INSERT INTO deleted_employees (first_name, last_name, middle_name, job_title, department_id, salary)
VALUES (OLD.first_name, OLD.last_name, OLD.middle_name, OLD.job_title, OLD.department_id, OLD.salary);
END; $$

DELIMITER ;
DROP TRIGGER tr_deleted_employees;