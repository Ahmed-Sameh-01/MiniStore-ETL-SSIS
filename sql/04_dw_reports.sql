/*Create Data Warehouse Reports*/


 /*What is the total completed sales revenue?*/

SELECT
    SUM(SalesAmount) AS TotalCompletedRevenue
FROM dbo.FactSales;

/*What is the total sales amount by product*/

SELECT
    p.ProductName,
    SUM(f.SalesAmount) AS TotalSales
FROM dbo.FactSales AS f
JOIN dbo.DimProduct AS p
    ON f.ProductKey = p.ProductKey
GROUP BY p.ProductName
ORDER BY TotalSales DESC;

/*What is the total sales amount by customer*/

SELECT
    c.CustomerName,
    SUM(f.SalesAmount) AS TotalSales
FROM dbo.FactSales AS f
JOIN dbo.DimCustomer AS c
    ON f.CustomerKey = c.CustomerKey
GROUP BY c.CustomerKey, c.CustomerName
ORDER BY TotalSales DESC;


/*: What is the total sales amount by city*/

SELECT
    c.City,
    SUM(f.SalesAmount) AS TotalSales
FROM dbo.FactSales AS f
JOIN dbo.DimCustomer AS c
    ON f.CustomerKey = c.CustomerKey
GROUP BY c.City
ORDER BY TotalSales DESC;

/*What is the total sales amount by month*/

SELECT
    d.[Year],
    d.[Month],
    d.MonthName,
    SUM(f.SalesAmount) AS TotalSales
FROM dbo.FactSales AS f
JOIN dbo.DimDate AS d
    ON f.DateKey = d.DateKey
GROUP BY
    d.[Year],
    d.[Month],
    d.MonthName
ORDER BY
    d.[Year],
    d.[Month];

/*Which product generated the highest revenue?*/

SELECT TOP 1
    p.ProductName,
    SUM(f.SalesAmount) AS TotalRevenue
FROM dbo.FactSales AS f
JOIN dbo.DimProduct AS p
    ON f.ProductKey = p.ProductKey
GROUP BY
    p.ProductKey,
    p.ProductName
ORDER BY TotalRevenue DESC;

