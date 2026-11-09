
/* Validate the Results*/

SELECT
    (SELECT COUNT(*) FROM MiniStoreSource.dbo.Customers)
        AS SourceCustomers,
    (SELECT COUNT(*) FROM dbo.DimCustomer)
        AS WarehouseCustomers;

SELECT s.CustomerID
FROM MiniStoreSource.dbo.Customers AS s
LEFT JOIN dbo.DimCustomer AS d
    ON s.CustomerID = d.CustomerID
WHERE d.CustomerID IS NULL;


SELECT
    (
        SELECT SUM(CAST(oi.Quantity * oi.UnitPrice AS DECIMAL(12,2)))
        FROM MiniStoreSource.dbo.Orders AS o
        JOIN MiniStoreSource.dbo.OrderItems AS oi
            ON o.OrderID = oi.OrderID
        WHERE o.OrderStatus = 'Completed'
    ) AS SourceCompletedSales,

    (
        SELECT SUM(SalesAmount)
        FROM dbo.FactSales
    ) AS WarehouseSales;