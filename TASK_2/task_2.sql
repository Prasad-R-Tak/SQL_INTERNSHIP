DROP DATABASE IF EXISTS internshipDB;
CREATE DATABASE internshipDB;
USE internshipDB;


CREATE TABLE Employee (
    EmpID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Department VARCHAR(100),
    Salary DECIMAL(10,2) DEFAULT 0,
    Email VARCHAR(150) UNIQUE
);


CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY AUTO_INCREMENT,
    EmpID INT,
    ProjectName VARCHAR(150),
    StartDate DATE,
    CONSTRAINT fk_emp
      FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
      ON DELETE CASCADE
);


INSERT INTO Employee (Name, Department, Salary, Email) VALUES
('Prasad', 'IT', 45000.00, 'prasad@example.com'),
('Riya', NULL, 50000.00, 'riya@example.com'),     -- Department is NULL
('Arjun', 'Finance', 42000.00, NULL),             -- Email is NULL
('Sneha', NULL, DEFAULT, NULL);                   -- Salary uses DEFAULT (0), Dept and Email NULL


INSERT INTO Employee (Name) VALUES ('Kumar');     -- Department NULL, Salary default 0


SELECT * FROM Employee;

UPDATE Employee
SET Salary = Salary + 5000
WHERE Department IS NULL;

UPDATE Employee
SET Department = 'HR'
WHERE Name = 'Sneha';

INSERT INTO Projects (EmpID, ProjectName, StartDate) VALUES
(1, 'Website Revamp', '2025-09-01'),
(2, 'Mobile App', '2025-10-15'),
(1, 'API Integration', '2025-11-01');

SELECT * FROM Projects;

START TRANSACTION;
DELETE FROM Employee WHERE Name = 'Kumar'; 
ROLLBACK;

SELECT * FROM Employee WHERE Name = 'Kumar';

SELECT * FROM Employee;
SELECT * FROM Projects;
DELETE FROM Employee WHERE EmpID = 2;

SELECT * FROM Employee;
SELECT * FROM Projects;

DELETE FROM Employee WHERE Salary = 0;

SELECT * FROM Employee;
SELECT * FROM Projects;

SELECT * FROM Employee WHERE Department IS NULL;
SELECT * FROM Employee WHERE Email IS NOT NULL;

