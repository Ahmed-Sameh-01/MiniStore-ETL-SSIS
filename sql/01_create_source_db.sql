/* Create DataBase MiniStore Sourse*/

CREATE DATABASE MiniStoreSource;

USE MiniStoreSource

CREATE TABLE Customers 
(
     CustomerID	INT Primary Key,
     CustomerName	NVARCHAR(100),
     City  	NVARCHAR(50)
     );

CREATE TABLE Products 
(
       ProductID	INT Primary Key,
       ProductName	NVARCHAR(100),
       Category	NVARCHAR(50),
       Price	DECIMAL(10,2)
       );

CREATE TABLE Orders 
(    
       OrderID	INT Primary Key,
       CustomerID	INT ,
       OrderDate	DATE,
       OrderStatus	NVARCHAR(20)
       FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
       ) ;

CREATE TABLE OrderItems
(
      OrderItemID	INT Primary Key,
      OrderID	INT ,
      ProductID	INT , 
      Quantity	INT ,
      UnitPrice	DECIMAL(10,2),
      FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
      FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
      );



INSERT INTO Customers (CustomerID, CustomerName, City)
VALUES
(1, 'Ahmed Samy', 'Cairo'),
(2, 'Mohamed Ali', 'Giza'),
(3, 'Omar Hassan', 'Alexandria'),
(4, 'Mahmoud Adel', 'Benha'),
(5, 'Youssef Mostafa', 'Cairo'),
(6, 'Amr Khaled', 'Tanta'),
(7, 'Mina George', 'Giza'),
(8, 'Karim Ashraf', 'Mansoura'),
(9, 'Hassan Ibrahim', 'Cairo'),
(10, 'Ali Mohamed', 'Fayoum'),
(11, 'Mostafa Hany', 'Giza'),
(12, 'Khaled Samir', 'Alexandria'),
(13, 'Peter Nabil', 'Benha'),
(14, 'Ebrahim Tarek', 'Cairo'),
(15, 'Ziad Mahmoud', 'Shibin El Kom');



INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES
(1, 'Laptop', 'Electronics', 25000.00),
(2, 'Mouse', 'Electronics', 350.00),
(3, 'Keyboard', 'Electronics', 750.00),
(4, 'Monitor', 'Electronics', 6500.00),
(5, 'Headphones', 'Electronics', 1200.00),
(6, 'Smartphone', 'Electronics', 18000.00),
(7, 'USB Cable', 'Accessories', 150.00),
(8, 'Charger', 'Accessories', 400.00),
(9, 'Desk', 'Furniture', 3500.00),
(10, 'Office Chair', 'Furniture', 4200.00),
(11, 'Notebook', 'Stationery', 80.00),
(12, 'Pen Set', 'Stationery', 120.00),
(13, 'Printer', 'Electronics', 5500.00),
(14, 'Tablet', 'Electronics', 9000.00),
(15, 'Webcam', 'Electronics', 950.00);



INSERT INTO Orders (OrderID, CustomerID, OrderDate, OrderStatus)
VALUES
(101, 1, '2026-01-05', 'Completed'),
(102, 2, '2026-01-07', 'Completed'),
(103, 3, '2026-01-10', 'Cancelled'),
(104, 4, '2026-01-12', 'Pending'),
(105, 5, '2026-01-15', 'Completed'),
(106, 6, '2026-01-18', 'Processing'),
(107, 7, '2026-01-20', 'Completed'),
(108, 8, '2026-01-22', 'Cancelled'),
(109, 9, '2026-01-25', 'Pending'),
(110, 10, '2026-02-01', 'Completed'),
(111, 11, '2026-02-05', 'Processing'),
(112, 1, '2026-02-10', 'Completed');



INSERT INTO OrderItems
    (OrderItemID, OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 101, 1, 1, 25000.00),
(2, 101, 2, 2, 350.00),
(3, 102, 3, 1, 750.00),
(4, 102, 5, 2, 1200.00),
(5, 103, 6, 1, 18000.00),
(6, 104, 4, 1, 6500.00),
(7, 104, 7, 3, 150.00),
(8, 105, 8, 2, 400.00),
(9, 105, 9, 1, 3500.00),
(10, 106, 10, 1, 4200.00),
(11, 106, 11, 5, 80.00),
(12, 107, 12, 2, 120.00),
(13, 107, 13, 1, 5500.00),
(14, 108, 14, 1, 9000.00),
(15, 109, 15, 2, 950.00),
(16, 110, 1, 1, 25000.00),
(17, 110, 4, 2, 6500.00),
(18, 111, 2, 3, 350.00),
(19, 112, 6, 1, 18000.00),
(20, 112, 8, 1, 400.00);

/*1.Display all customers and their cities.*/

SELECT *
FROM Customers;

/*2.Display each order with the customer name and order date.*/

SELECT 
      O.OrderID,
      C.CustomerName,
      O.OrderDate
FROM Orders AS O 
INNER JOIN Customers AS C 
     ON O.CustomerID = C.CustomerID ; 

/*3.Calculate the total sales amount for each order.*/

SELECT
    OrderID,
    SUM(Quantity * UnitPrice) AS TotalSales
FROM OrderItems
GROUP BY OrderID;

/*4.Display the total sales for each product.*/

SELECT
    ProductID,
    SUM(Quantity * UnitPrice) AS TotalSales
FROM OrderItems
GROUP BY ProductID;

/*5.Display the total sales for each customer.*/


SELECT
    C.CustomerID,
    C.CustomerName,
    SUM(OI.Quantity * OI.UnitPrice) AS TotalSales
FROM OrderItems AS OI INNER JOIN  Orders AS O
ON OI.OrderID =  O.OrderID
INNER JOIN Customers AS C
ON O.CustomerID = C.CustomerID
GROUP BY C.CustomerID,C.CustomerName
;

/*6.Find the product with the highest sales.*/

SELECT TOP 1
      P.ProductID,
      P.ProductName,
      SUM(OI.Quantity * OI.UnitPrice) AS TotalSales
FROM Products AS P INNER JOIN OrderItems AS OI
ON P.ProductID = OI.ProductID
GROUP BY  P.ProductID,P.ProductName
ORDER BY TotalSales DESC ;

/*7.Display the number of orders in each status.*/

SELECT 
      COUNT(OrderID) AS NumberOfOrders,
      OrderStatus
FROM Orders 
GROUP BY OrderStatus ;

