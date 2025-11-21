-- Task 6: Subqueries and Nested Queries
-- Author: Prasad

DROP DATABASE IF EXISTS internshipDB6;
CREATE DATABASE internshipDB6;
USE internshipDB6;

-- -----------------------------------------------------------
-- 1. Create Tables
-- -----------------------------------------------------------

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Department VARCHAR(100),
    Salary INT
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY AUTO_INCREMENT,
    EmpID INT,
    ProjectName VARCHAR(150),
    Status VARCHAR(20),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);

-- -----------------------------------------------------------
-- 2. Insert Sample Data
-- -----------------------------------------------------------

INSERT INTO Employees (Name, Department, Salary) VALUES
('Prasad', 'IT', 60000),
('Riya', 'IT', 55000),
('Amit', 'HR', 50000),
('Sneha', 'Finance', 70000),
('Karan', 'Finance', 45000);

INSERT INTO Projects (EmpID, ProjectName, Status) VALUES
(1, 'Website Upgrade', 'Completed'),
(2, 'Mobile App', 'Ongoing'),
(3, 'Recruitment System', 'Completed'),
(1, 'API Migration', 'Ongoing'),
(5, 'Billing Automation', 'Ongoing');

-- -----------------------------------------------------------
-- 3. SUBQUERIES (SELECT, WHERE, FROM)
-- -----------------------------------------------------------

-- 3.1 Scalar Subquery: Employee with highest salary
SELECT Name, Salary
FROM Employees
WHERE Salary = (SELECT MAX(Salary) FROM Employees);

-- 3.2 Subquery in WHERE using IN
SELECT Name, Department
FROM Employees
WHERE Department IN (SELECT DISTINCT Department FROM Employees WHERE Salary > 55000);

-- 3.3 Subquery using EXISTS (employees with at least 1 project)
SELECT Name
FROM Employees e
WHERE EXISTS (SELECT 1 FROM Projects p WHERE p.EmpID = e.EmpID);

-- 3.4 Correlated Subquery: Employees earning above dept average
SELECT Name, Department, Salary
FROM Employees e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
    WHERE Department = e.Department
);

-- 3.5 Subquery in FROM (Derived Table)
SELECT Department, AvgSalary
FROM (
    SELECT Department, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY Department
) AS dept_avg
WHERE AvgSalary > 50000;

-- 3.6 Subquery with =
SELECT Name
FROM Employees
WHERE EmpID = (SELECT EmpID FROM Projects WHERE ProjectName = 'Mobile App');

-- 3.7 Nested Subquery (two levels)
SELECT Name
FROM Employees
WHERE EmpID IN (
    SELECT EmpID FROM Projects
    WHERE Status = 'Ongoing'
);

-- 3.8 Multiple-row Subquery
SELECT Name, Salary
FROM Employees
WHERE Salary IN (SELECT Salary FROM Employees WHERE Salary > 55000);

-- 3.9 Subquery using NOT EXISTS (employees with no projects)
SELECT Name
FROM Employees e
WHERE NOT EXISTS (
    SELECT 1 FROM Projects p WHERE p.EmpID = e.EmpID
);

-- 3.10 Using ANY / SOME
SELECT Name, Salary
FROM Employees
WHERE Salary > ANY (SELECT Salary FROM Employees WHERE Department = 'HR');

-- END OF TASK 6
