/* Design the Data Warehouse */

CREATE DATABASE MiniStoreDW ;
 
 GO 

USE MiniStoreDW 

CREATE TABLE DimCustomer 
(   
    	CustomerKey INT IDENTITY(1,1) PRIMARY KEY ,
        CustomerID  INT, 
	    CustomerName NVARCHAR(100),
 	    City NVARCHAR(50)
) ;

CREATE TABLE DimProduct 
(
          ProductKey  INT IDENTITY(1,1) PRIMARY KEY ,
          ProductID   INT , 
	      ProductName  NVARCHAR(100),
	      Category  NVARCHAR(50) 
) ;

CREATE TABLE DimDate
(
          	DateKey  INT PRIMARY KEY , 
	        FullDate DATE,
	        Year  INT,
	        Month  INT,
	        MonthName  NVARCHAR(20)
) ;

CREATE TABLE  FactSales 
(
            SalesKey  INT IDENTITY(1,1) PRIMARY KEY,
            OrderItemID  INT NOT NULL, 
	        OrderID  INT NOT NULL,
	        DateKey  INT NOT NULL, 
	        CustomerKey  INT NOT NULL, 
	        ProductKey  INT NOT NULL, 
	        Quantity  INT NOT NULL,
	        UnitPrice  DECIMAL(10,2) NOT NULL,
	        SalesAmount  DECIMAL(12,2) NOT NULL,

             FOREIGN KEY (DateKey) REFERENCES dbo.DimDate(DateKey),
             FOREIGN KEY (CustomerKey) REFERENCES dbo.DimCustomer(CustomerKey),
             FOREIGN KEY (ProductKey) REFERENCES dbo.DimProduct(ProductKey)
) ; 
GO 

SELECT *
FROM MiniStoreDW.dbo.DimCustomer;


SELECT *
FROM MiniStoreDW.dbo.DimProduct;



SELECT *
FROM MiniStoreDW.dbo.DimDate
ORDER BY DateKey;


SELECT *
FROM dbo.FactSales;

SELECT DISTINCT o.OrderStatus
FROM MiniStoreSource.dbo.Orders AS o
INNER JOIN dbo.FactSales AS f
    ON o.OrderID = f.OrderID
WHERE o.OrderStatus <> 'Completed';