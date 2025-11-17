-- Task 3: Basic SELECT Queries
-- Author: Prasad
-- MySQL Version

-- 1. Create and use database
DROP DATABASE IF EXISTS internshipDB3;
CREATE DATABASE internshipDB3;
USE internshipDB3;

-- 2. Create a sample table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100),
    City VARCHAR(100),
    Age INT,
    Email VARCHAR(150)
);

-- 3. Insert sample data
INSERT INTO Customers (FullName, City, Age, Email) VALUES
('Prasad Tak', 'Pune', 21, 'prasad@example.com'),
('Riya Sharma', 'Mumbai', 25, 'riya@gmail.com'),
('Amit Singh', 'Pune', 30, 'amit123@yahoo.com'),
('Sneha Patil', 'Delhi', 27, 'sneha@example.com'),
('Karan Malhotra', 'Bangalore', 22, 'karan@gmail.com'),
('Ananya Gupta', 'Pune', 19, 'ananya@yahoo.com');

-- -------------------------------
-- BASIC SELECT QUERIES
-- -------------------------------

-- 1. Select all rows/columns
SELECT * FROM Customers;

-- 2. Select specific columns
SELECT FullName, City, Age FROM Customers;

-- 3. WHERE with conditions
SELECT * FROM Customers WHERE City = 'Pune';

-- 4. WHERE with AND
SELECT * FROM Customers WHERE City = 'Pune' AND Age > 20;

-- 5. WHERE with OR
SELECT * FROM Customers WHERE City = 'Mumbai' OR City = 'Delhi';

-- 6. LIKE (pattern matching)
SELECT * FROM Customers WHERE FullName LIKE '%a%';   -- names containing "a"

-- 7. LIKE with starts-with
SELECT * FROM Customers WHERE FullName LIKE 'A%';

-- 8. BETWEEN (range)
SELECT * FROM Customers WHERE Age BETWEEN 20 AND 27;

-- 9. ORDER BY ascending
SELECT * FROM Customers ORDER BY Age ASC;

-- 10. ORDER BY descending
SELECT * FROM Customers ORDER BY Age DESC;

-- 11. LIMIT (show only first 3 rows)
SELECT * FROM Customers LIMIT 3;

-- 12. DISTINCT (remove duplicates)
SELECT DISTINCT City FROM Customers;

-- 13. Alias (rename columns in output)
SELECT FullName AS Name, Age AS Years FROM Customers;

-- 14. Combine filters + sorting
SELECT * FROM Customers
WHERE City = 'Pune'
ORDER BY Age DESC;

-- 15. Select rows where email ends with gmail.com
SELECT * FROM Customers WHERE Email LIKE '%gmail.com';

-- END OF TASK 3 SCRIPT
