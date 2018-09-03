-- FUNCIONES

-- 1) Write a query to fetch even numbered records from employees table. 
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME FROM Employees
	where EMPLOYEE_ID % 2 = 0;


-- 2) Write a query to find the 5th maximum salary in the employees table. 
SELECT DISTINCT SALARY 
	FROM Employees e1 
	WHERE 4 = (SELECT COUNT(DISTINCT SALARY) 
	FROM Employees e2 
	WHERE e2.salary >= e1.salary);

-- 3) Write a query to find the 4th minimum salary in the employees table. 
SELECT DISTINCT SALARY 
	FROM Employees e1 
	WHERE 2 = (SELECT COUNT(DISTINCT SALARY) 
	FROM Employees e2 
	WHERE e2.salary <= e1.salary);

-- 4) Write a query to select last 10 records from the employees table. 
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME FROM Employees
	ORDER BY EMPLOYEE_ID DESC
	LIMIT 10;

-- 5) Write a query to get the 3 maximum salaries. 
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY FROM Employees
	ORDER BY SALARY
	DESC LIMIT 3;

-- 6) Write a query to get the 3 minimum salaries. 
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY FROM Employees
	ORDER BY SALARY
	LIMIT 3;


-- SUB-QUERIES
-- 1) Write a query to find the name (FIRST_NAME, LAST_NAME) and salary of the employees who earn a salary that is higher than the salary of all the Shipping Clerks (JOB_ID = 'SH_CLERK'). Sort the results of the salary of the lowest to highest.

SELECT FIRST_NAME, LAST_NAME, SALARY FROM Employees
	WHERE SALARY > ( 
        SELECT MAX(SALARY) FROM Employees 
        WHERE JOB_ID = 'SH_CLERK')
        ORDER BY SALARY;

-- 2) Write a query to find the name (FIRST_NAME, LAST_NAME) of the employees who are not managers.

SELECT FIRST_NAME, LAST_NAME, JOB_ID FROM Employees
	WHERE JOB_ID IN (
	SELECT DISTINCT JOB_ID from Employees
		WHERE JOB_ID NOT LIKE '%MAN'
	);


-- 3) Write a query to display the employee ID, first name, last name, and department names of all employees.

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, Departments.DEPARTMENT_NAME FROM Employees
	INNER JOIN Departments ON Employees.DEPARTMENT_ID =  Departments.DEPARTMENT_ID;


-- 4) Write a query to display the employee ID, first name, last name, salary of all employees whose salary is above average for their departments.

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY from Employees AS A
	WHERE SALARY > 
	(SELECT AVG(SALARY) FROM Employees WHERE DEPARTMENT_ID = A.DEPARTMENT_ID);

-- JOIN QUERIES
-- 1) Write a query to get the department name and number of employees in the department.
SELECT DEPARTMENT_NAME AS 'Department Name', 
	COUNT(*) AS '# of Employees' FROM Departments 
	INNER JOIN Employees 
		ON Employees.DEPARTMENT_ID = Departments.DEPARTMENT_ID
		GROUP BY Departments.DEPARTMENT_ID, DEPARTMENT_NAME;

-- 2) Write a query to find the employee ID, job title, number of days between ending date and starting date for all jobs in department 90 from job history.
SELECT EMPLOYEE_ID, Jobs.JOB_TITLE, DATEDIFF(END_DATE, START_DATE) AS Days FROM JobHistory
	INNER JOIN Jobs
	ON JobHistory.JOB_ID = Jobs.JOB_ID
	WHERE DEPARTMENT_ID = 90;

-- REV 3) Write a query to display the department ID and name and first name of manager.
SELECT Departments.DEPARTMENT_ID, Departments.DEPARTMENT_NAME, Managers.FIRST_NAME FROM Employees
	INNER JOIN Departments
	ON Employees.DEPARTMENT_ID = Departments.DEPARTMENT_ID
    LEFT OUTER JOIN Employees AS Managers
    ON Employees.MANAGER_ID = Managers.EMPLOYEE_ID;

-- REV 4) Write a query to display the department name, manager name, and city.
SELECT DEPARTMENT_NAME, Managers.FIRST_NAME, Locations.CITY FROM Employees

	INNER JOIN Departments
	ON Employees.DEPARTMENT_ID = Departments.DEPARTMENT_ID

	LEFT OUTER JOIN Employees AS Managers
    ON Employees.MANAGER_ID = Managers.EMPLOYEE_ID
    
	INNER JOIN Locations
	ON Departments.LOCATION_ID = Locations.LOCATION_ID

	GROUP BY Managers.FIRST_NAME;

-- 5) Write a query to display the job title and average salary of employees.
SELECT JOB_TITLE, AVG(SALARY) FROM Employees
	NATURAL JOIN Jobs
	GROUP BY JOB_TITLE;

-- 6) Write a query to display job title, employee name, and the difference between salary of the employee and minimum salary for the job.
SELECT JOB_TITLE, FIRST_NAME, (SALARY - MIN_SALARY) 'Salary - Min_Salary' FROM Employees
	NATURAL JOIN Jobs;

-- 7) Write a query to display the job history that was done by any employee who is currently drawing more than 10000 of salary.
SELECT e.FIRST_NAME, e.LAST_NAME, jh.* FROM JobHistory jh 
	JOIN Employees e 
	ON (jh.EMPLOYEE_ID = e.EMPLOYEE_ID) 
	WHERE SALARY > 10000;

-- 8) Write a query to display department name, full name (first_name, last_name), hire date, salary of the manager for all managers whose experience is more than 15 years.
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE, SALARY, 
(DATEDIFF(now(), HIRE_DATE))/365 Experience 
FROM Departments d JOIN Employees e 
	ON (d.MANAGER_ID = e.EMPLOYEE_ID) 
	WHERE (DATEDIFF(now(), HIRE_DATE))/365>15;













