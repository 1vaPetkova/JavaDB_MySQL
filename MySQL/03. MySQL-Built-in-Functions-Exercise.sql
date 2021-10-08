-- Exercise
-- 1.	Find Names of All Employees by First Name
SELECT `first_name`,`last_name`
FROM `employees`
WHERE LEFT(LOWER(`first_name`), 2) = 'sa';

-- 2.	Find Names of All Employees by Last Name
SELECT `first_name`,`last_name`
FROM `employees`
WHERE `last_name` LIKE '%ei%';

-- 3.	Find First Names of All Employees
SELECT `first_name`
FROM `employees`
WHERE `department_id` IN (3,10) 
AND YEAR(`hire_date`) BETWEEN 1995 AND 2005
ORDER BY `employee_id`;

-- 4.	Find All Employees Except Engineers
SELECT `first_name`,`last_name`
FROM `employees`
WHERE `job_title` NOT LIKE '%engineer%'
ORDER BY `employee_id`;

-- 5.	Find Towns with Name Length
SELECT `name`
FROM `towns`
WHERE CHAR_LENGTH(`name`) IN (5,6)
ORDER BY `name`;

-- 6.	 Find Towns Starting With
SELECT `town_id`, `name`
FROM `towns`
WHERE LEFT(`name`,1) IN ('m',  'k', 'b', 'e')
ORDER BY `name`; 

-- 7.	 Find Towns Not Starting With
SELECT `town_id`, `name`
FROM `towns`
WHERE NOT LEFT(`name`,1) IN ('r', 'b', 'd')
ORDER BY `name`; 

-- 8.	Create View Employees Hired After 2000 Year
CREATE VIEW `v_employees_hired_after_2000` AS
SELECT `first_name`,`last_name`
FROM `employees`
WHERE EXTRACT(YEAR FROM `hire_date`) > 2000;

SELECT * FROM `v_employees_hired_after_2000`;

-- 9.	Length of Last Name
SELECT `first_name`,`last_name`
FROM `employees`
WHERE CHAR_LENGTH(`last_name`) = 5;

-- 10.	Countries Holding 'A' 3 or More Times
SELECT `country_name`,`iso_code`
FROM `countries`
WHERE (`country_name`) LIKE '%A%A%A%'
ORDER BY `iso_code`;

-- 11.	 Mix of Peak and River Names
SELECT `peak_name`, `river_name`, 
LOWER(concat('',SUBSTR(`peak_name`,1,CHAR_LENGTH(`peak_name`)-1),`river_name`)) AS 'mix'
FROM `peaks`, `rivers`
WHERE RIGHT(`peak_name`, 1) = LEFT(`river_name`, 1)
ORDER BY `mix`;	

-- 12.	Games from 2011 and 2012 Year
SELECT `name`, DATE_FORMAT(`start`, '%Y-%m-%d') AS 'start'
FROM `games`
WHERE YEAR(`start`) BETWEEN 2011 AND 2012
ORDER BY `start`,`name`
LIMIT 50;

-- 13.	 User Email Providers
SELECT `user_name`, SUBSTR(`email`,LOCATE('@',`email`)+1) AS 'Email Provider'
FROM `users`
ORDER BY `Email provider`,`user_name`;


-- 14.	 Get Users with IP Address Like Pattern	
SELECT `user_name`, `ip_address`
FROM `users`
WHERE `ip_address` LIKE '___.1%.%.___'
ORDER BY `user_name`;

-- 15.	 Show All Games with Duration and Part of the Day
SELECT `name` AS `game`, 
CASE 
	WHEN HOUR(`start`) BETWEEN 0 AND 11 THEN 'Morning'
    WHEN HOUR(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
    WHEN HOUR(`start`) BETWEEN 18 AND 23 THEN 'Evening'
    END
 AS 'Part of the Day', 
 CASE 
	WHEN `duration`<= 3 THEN 'Extra Short'
	WHEN `duration`> 3 AND `duration`<=6 THEN 'Short'
	WHEN `duration`> 6 AND `duration`<=10 THEN 'Long'
    ELSE 'Extra Long'
    END
 AS 'Duration'
 FROM `games`;
 

-- 16.	 Orders Table
 SELECT `product_name`, `order_date`,
 DATE_ADD(`order_date`, INTERVAL 3 DAY)
 AS 'pay_due',
  DATE_ADD(`order_date`, INTERVAL 1 MONTH)
 AS 'deliver_due'
 FROM `orders`;