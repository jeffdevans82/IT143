/*****************************************************************************************************************
NAME:    W3.4 Adventure Works - Create Answers
PURPOSE: Solve increasingly more complex question using SQL

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/11/2026   JEvans       1. Built this script for EC IT143


RUNTIME: 
1s

NOTES: 
Built for W3.4 - Adventure Works: Create Answers 

I am building this script in order to show my solution to 8 increasingly complex questions using these tools.
 - Adventure Works Meta data - https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver15&tabs=ssms
 - SQL
 - SSMS
 
******************************************************************************************************************/

-- Q1: Which three sales territories generated the highest total sales? - Question by Irene Etim
-- A1: Here is my response for Irene's question

--SELECT GETDATE() AS my_date;

SELECT TOP 3 Name, SalesLastYear FROM Sales.SalesTerritory 
GROUP BY sales.SalesTerritory.Name, sales.SalesTerritory.SalesLastYear
ORDER BY MAX(SalesLastYear) DESC  


-- Q2: Who are the three top sales people for the year to date? - Reaford Beldon
-- A2: Here is my response for Reaford's question

SELECT TOP 3 SalesYTD FROM sales.SalesPerson
GROUP BY sales.salesperson.BusinessEntityID, sales.SalesPerson.TerritoryID, sales.salesperson.SalesYTD
ORDER BY MAX(sales.salesperson.salesYTD) DESC


-- Q3: Our store wants to thank repeat shoppers. Who are our top buyers by number of purchases? 
-- Please include their full name, city, and total number of orders. -Irene Etim
-- A3: Here is my response for Irene's question

SELECT TOP 20
    p.FirstName + ISNULL(' ' + p.MiddleName, '') + ' ' + p.LastName AS [Full Name],
    a.City AS [City],
    COUNT(header.SalesOrderID) AS [Total Number of Orders]
FROM Sales.SalesOrderHeader AS header
INNER JOIN Sales.Customer AS c 
    ON header.CustomerID = c.CustomerID
INNER JOIN Person.Person AS p 
    ON c.PersonID = p.BusinessEntityID
INNER JOIN Person.BusinessEntityAddress AS bea 
    ON p.BusinessEntityID = bea.BusinessEntityID
INNER JOIN Person.Address AS a 
    ON bea.AddressID = a.AddressID
GROUP BY 
    c.CustomerID, 
    p.FirstName, 
    p.MiddleName, 
    p.LastName, 
    a.City
ORDER BY 
    [Total Number of Orders] DESC;

	
-- Q4: How many employees leave within one year of their hire date? How many employees have left the company? - ME
-- A4: Here is my response for My question
-- I had to research this to find out how they tracked who was still employed. In the CurrentFlag column 1 is active and 0 is inactive. 
-- Therefore there aren't actually any employees coded as no longer with the company. The first part is the solution, the second is how 
-- I would do the query if I had the information.

SELECT COUNT(*) AS EmployeesWhoLeft
FROM HumanResources.Employee
WHERE CurrentFlag = 0;
	
-- Here is the concept for finding out how to actually do this problem
WITH EmployeeExitDates AS (
    SELECT 
        e.BusinessEntityID,
        e.HireDate,
        MAX(history.EndDate) AS ExitDate
    FROM HumanResources.Employee e
    INNER JOIN HumanResources.EmployeeDepartmentHistory history 
        ON e.BusinessEntityID = history.BusinessEntityID
    WHERE e.CurrentFlag = 0
    GROUP BY e.BusinessEntityID, e.HireDate
)
SELECT COUNT(*) AS LeftWithinOneYear
FROM EmployeeExitDates
WHERE DATEDIFF(year, HireDate, ExitDate) < 1;


-- Q5: Our executive team wants to understand our best-selling road bikes from the year 2012. Specifically, could you provide a 
-- report showing the product name, total quantity sold, and the total revenue generated for each road bike model? - Nnamdi Stanley Ijezie
-- A5: Here is my response for Nnamdi's question
-- Lots of joins in this one!

SELECT 
    p.Name AS [Product Name],
    SUM(detail.OrderQty) AS [Total Quantity Sold],
    SUM(detail.LineTotal) AS [Total Revenue Generated]
FROM 
    Sales.SalesOrderHeader AS header
INNER JOIN 
    Sales.SalesOrderDetail AS detail ON header.SalesOrderID = detail.SalesOrderID
INNER JOIN 
    Production.Product AS p ON detail.ProductID = p.ProductID
INNER JOIN 
    Production.ProductSubcategory AS sub ON p.ProductSubcategoryID = sub.ProductSubcategoryID
INNER JOIN 
    Production.ProductCategory AS category ON sub.ProductCategoryID = category.ProductCategoryID
WHERE 
    category.Name = 'Bikes'
    AND sub.Name = 'Road Bikes'
    AND YEAR(header.OrderDate) = 2012
GROUP BY 
    p.Name
ORDER BY 
    [Total Revenue Generated] DESC;

-- Q6: I need to understand more about the parts that were ordered during the period June to July 2024, 
-- specifically those going to France during the Tour de France that year? - Reaford Beldon
-- A6: Here is my response for Reaford's question
-- There was no purchases made during 2024, so I used the year 2014.

SELECT DISTINCT
    p.ProductID,
    p.Name AS ProductName,
    p.ProductNumber,
    SUM(id.OrderQty) AS TotalQuantityOrdered
FROM Sales.SalesOrderHeader AS header
INNER JOIN Sales.SalesOrderDetail AS id
    ON header.SalesOrderID = id.SalesOrderID
INNER JOIN Production.Product AS p
    ON id.ProductID = p.ProductID
INNER JOIN Sales.SalesTerritory AS territory
    ON header.TerritoryID = territory.TerritoryID
WHERE territory.Name = 'France'
  AND header.OrderDate >= '2014-06-01'
  AND header.OrderDate <= '2014-07-31'
GROUP BY 
    p.ProductID,
    p.Name,
    p.ProductNumber
ORDER BY 
    p.Name;


-- Q7:Metadata question: Can we have a view on our Production.ScrapReason to see the reason for why we scrapped products? -- ME
-- A7: Here is my response for MY question.

CREATE VIEW Production.ProductionScrapHistory AS
SELECT 
    wo.WorkOrderID,
    p.ProductID,
    p.Name AS ProductName,
    p.ProductNumber,
    wo.OrderQty,
    wo.ScrappedQty,
    sr.ScrapReasonID,
    sr.Name AS ScrapReason,
    wo.DueDate,
    wo.ModifiedDate
FROM 
    Production.WorkOrder wo
INNER JOIN 
    Production.ScrapReason sr ON wo.ScrapReasonID = sr.ScrapReasonID
INNER JOIN 
    Production.Product p ON wo.ProductID = p.ProductID
WHERE 
    wo.ScrappedQty > 0;


-- Q8:Metadata question: What is the average number of days required to manufacture products across different product categories? -Moreblessing Ndirichiweny Tauvinga
-- A8: Here is my response for Moreblessing's question.
-- This one was more difficult than I anticipated, but it seems to work.

CREATE VIEW Production.vAverageDaysToManufactureByCategory AS
SELECT 
    ISNULL(category.Name, 'No Category') AS CategoryName,
    COUNT(prod.ProductID) AS TotalProductsManufactured,
    AVG(CAST(prod.DaysToManufacture AS DECIMAL(5,2))) AS AvgDaysToManufacture -- changes it to a decimal to help with the AVG() function
FROM 
    Production.Product AS prod
LEFT JOIN 
    Production.ProductSubcategory AS sub ON prod.ProductSubcategoryID = sub.ProductSubcategoryID
LEFT JOIN 
    Production.ProductCategory AS category ON sub.ProductCategoryID = category.ProductCategoryID
WHERE 
    prod.MakeFlag = 1 -- This flag means products made by the company itself, not outsourced.
GROUP BY 
    category.Name;



