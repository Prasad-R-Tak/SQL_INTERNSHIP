-- DDL: Create and use a new database
CREATE DATABASE ElevateLabs_Task4;
USE ElevateLabs_Task4;

-- DDL: Create the Sales table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    SaleDate DATE,
    Region VARCHAR(50) NOT NULL,
    Product VARCHAR(50) NOT NULL,
    SaleAmount DECIMAL(10, 2) NOT NULL,
    Quantity INT
);

-- DML: Insert sample data (Make sure to adapt this data to your specific scenario)
INSERT INTO Sales (SaleID, SaleDate, Region, Product, SaleAmount, Quantity) VALUES
(1, '2025-10-01', 'North', 'Laptop', 1200.00, 1),
(2, '2025-10-01', 'South', 'Keyboard', 75.50, 5),
(3, '2025-10-02', 'North', 'Monitor', 350.00, 2),
(4, '2025-10-02', 'East', 'Laptop', 1200.00, 3),
(5, '2025-10-03', 'South', 'Mouse', 25.00, 10),
(6, '2025-10-03', 'North', 'Laptop', 1200.00, 1),
(7, '2025-10-04', 'East', 'Monitor', 350.00, 4);

SELECT
    SUM(SaleAmount) AS Total_Revenue_Company,
    COUNT(SaleID) AS Total_Transactions,
    AVG(SaleAmount) AS Average_Sale_Value
FROM
    Sales;
    
SELECT
    Region,
    SUM(SaleAmount) AS Total_Regional_Sales,
    AVG(SaleAmount) AS Average_Regional_Sale,
    COUNT(*) AS Transactions_Count
FROM
    Sales
GROUP BY
    Region
ORDER BY
    Total_Regional_Sales DESC;
SELECT
    Product,
    SUM(Quantity) AS Total_Units_Sold,
    SUM(SaleAmount) AS Total_Product_Revenue
FROM
    Sales
GROUP BY
    Product
ORDER BY
    Total_Product_Revenue DESC;

SELECT
    Region,
    SUM(SaleAmount) AS Total_Regional_Sales
FROM
    Sales
GROUP BY
    Region
HAVING
    SUM(SaleAmount) > 2000.00;