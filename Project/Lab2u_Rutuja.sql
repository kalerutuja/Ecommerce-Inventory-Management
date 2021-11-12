/* Q.2-1 Write a query to retrieve all orders made after July 3, 2008
 and had an total due value less than $5. Include
 the customer id, sales order id, order date and total due columns
 in the returned data.
 Use the CAST function in the SELECT clause to display the date
 only for the order date. Use ROUND to display only two decimal
 places for the total due amount. Use an alias to give a descriptive
 column heading if a column heading is missing. Sort the returned
 data first by the customer id, then order date.*/

SELECT CustomerID, SalesOrderID, CAST(OrderDate AS date) AS [OrderDate], CAST(ROUND(TotalDue, 2) AS DECIMAL(10,2)) AS [TotalDue] 
FROM  Sales.SalesOrderHeader 
WHERE OrderDate > '2008-07-03 00:00:00' AND TotalDue <5
ORDER BY CustomerID , OrderDate;

--------------------------------------------------------------------------------------------------------------------------------------------------

/* Q.2-2 Retrieve the salesperson ID, the most recent order date
and total number of orders processed by each salesperson.
Use a column alias to make the report more presentable
if a column heading is missing. Display only the date of
the order date. Exclude the orders which don't have a
salesperson specified.Sort the returned data by the total number of orders in
descending. */

SELECT SalesPersonID, CAST(MAX(OrderDate) AS Date) AS [Recent Order Date], COUNT(SalesOrderID) AS [Total Orders]
FROM Sales.SalesOrderHeader 
GROUP BY SalesPersonID 
HAVING SalesPersonID IS NOT NULL 
ORDER BY [Total Orders] DESC;

--------------------------------------------------------------------------------------------------------------------------------------------------

/* Q.2-3 Write a query to select the product id, name, and list price
 for the product(s) that have a list price greater than the
 average list price plus $25. Use a column alias to make the report more presentable
 if a column heading is missing. Sort the returned data by the
 list price in descending.
 Hint: You’ll need to use a simple subquery to get the average
 list price and use it in a WHERE clause. */

SELECT ProductID, Name, ListPrice
FROM Production.Product 
WHERE ListPrice > (SELECT AVG(ListPrice) +25 FROM Production.Product)
ORDER BY ListPrice DESC;

--------------------------------------------------------------------------------------------------------------------------------------------------

/*Q.2-4 Write a query to retrieve the "orders to customer ratio"
 (number of orders / unique customers) for all territories.
Return the Territory ID, Territory Name, and Ratio columns.
Use a column alias to make the report more presentable
 if a column heading is missing. Sort the returned data by
TerritoryID.*/

SELECT st.TerritoryID, st.Name, ROUND(CAST(COUNT(DISTINCT sh.SalesOrderID) AS FLOAT)/COUNT(DISTINCT sh.CustomerID),2) AS [Orders to Customer Ratio]
FROM Sales.SalesTerritory st
INNER JOIN Sales.SalesOrderHeader sh
ON st.TerritoryID = sh.TerritoryID 
GROUP BY st.TerritoryID, st.Name 
ORDER BY st.TerritoryID;
--------------------------------------------------------------------------------------------------------------------------------------------------------

/*Q.2-5 Write a query to retrieve the salespersons who have processed
 more than 200 orders and have sold products of more than
 7 different colors. Exclude the orders that don't have a salesperson
 specified.Return the salesperson ID, Total Order Count, Total Unique Colors
 columns for each salesperson. Use a column alias to make the report
 more presentable if a column heading is missing. Sort the returned data
 by SalespersonID. */

SELECT sh.SalesPersonID, COUNT(sh.SalesOrderID) [Total Order], COUNT(DISTINCT p.color) [Unique Colors]
FROM Sales.SalesOrderHeader sh 
INNER JOIN Sales.SalesOrderDetail sd
ON sh.SalesOrderID = sd.SalesOrderID
INNER JOIN Production.Product p 
ON sd.ProductID = p.ProductID
GROUP BY sh.SalesPersonID
HAVING COUNT(sh.SalesOrderID) >200 AND COUNT(DISTINCT p.color)>7;
--------------------------------------------------------------------------------------------------------------------------------------------------

/*Q.2-6 Write a query to retrieve the dates in which
 there was at least one order placed but no order
 worth more than $1000 was placed. Use TotalDue
 in Sales.SalesOrderHeader as the order value.
 Return the "order date" and "total product quantity sold
 for the date" columns. The order quantity column is
 in SalesOrderDetail. Display only the date part of the
 order date. Sort the returned data by the
 "total product quantity sold for the date" column in desc. */

SELECT CAST (sh.OrderDate AS Date) AS [Order Date], SUM(sd.OrderQty) AS [Total Product Quantity Sold]
FROM Sales.SalesOrderHeader sh
INNER JOIN Sales.SalesOrderDetail sd
ON sh.SalesOrderID = sd.SalesOrderID 
WHERE sh.TotalDue <= 1000
GROUP BY sh.OrderDate 
HAVING COUNT(sh.SalesOrderID) >=1
ORDER BY [Total Product Quantity Sold] DESC;





