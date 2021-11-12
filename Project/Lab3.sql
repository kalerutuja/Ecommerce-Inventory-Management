/* Q.3-1 Modify the following query to add a column that shows the
 sales performance of a territory and contains the following
 criteria based on the number of orders:
 'Underperforming' for the total order count between 1 and 2000
 'Average' for between 2001 and 4000
 'Successful' for greater than 4000
 Give the new column an alias to make the report more readable.
*/

SELECT o.TerritoryID, s.Name, COUNT(o.SalesOrderid) AS [Total Orders],
CASE 
   WHEN count(o.SalesOrderID) >=1 AND count(o.SalesOrderID) <=5 THEN 'Underperforming'
   WHEN count(o.SalesOrderID) >=2001 AND count (o.SalesOrderID) <= 4000 THEN 'Average'
   WHEN count(o.SalesOrderID) >4000 THEN'Successful'
   END 
   AS [SalesPerformance]
FROM Sales.SalesOrderHeader o
JOIN Sales.SalesTerritory s 
ON o.TerritoryID = s.TerritoryID
GROUP BY o.TerritoryID, s.Name
ORDER BY o.TerritoryID DESC;
--------------------------------------------------------------------------------------------------------------------------------------------------
/* Q.3-2 Modify the following query to add a new column named rank.
 The new column is based on ranking with gaps according to
 the total orders in descending. Also partition by the territory.*/

SELECT o.TerritoryID, s.Name, o.SalesPersonID, COUNT(o.SalesOrderID) AS [Total Orders],
RANK() OVER (PARTITION BY o.TerritoryID ORDER BY COUNT(o.SalesOrderID) DESC) AS [RANK]
FROM  Sales.SalesOrderHeader o
JOIN Sales.SalesTerritory s 
ON o.TerritoryID = s.TerritoryID 
WHERE SalesPersonID IS NOT NULL
GROUP BY o.TerritoryID, s.Name, o.SalesPersonID
ORDER BY o.TerritoryID;
--------------------------------------------------------------------------------------------------------------------------------------------------
/*Q.3-3 Retrieve the product id, product name, and the total
 sold quantity of the worst selling (by total quantity sold)
 product of each date. If there is a tie for a date, it needs
 to be retrieved.Sort the returned data by date in descending. */

SELECT T.ProductID, T.Name, T.OrderDate, T.totalQty FROM (
	SELECT 
	    sd.ProductID, p.Name, sh.OrderDate, SUM(OrderQty) totalQty,
		RANK() OVER (PARTITION BY sh.OrderDate ORDER BY SUM(OrderQty) ASC) AS WorstRanking
	FROM Sales.SalesOrderHeader AS sh
	INNER JOIN Sales.SalesOrderDetail AS sd 
	ON sh.SalesOrderID = sd.SalesOrderID
	INNER JOIN Production.Product AS p 
	ON sd.ProductID = p.ProductID
	GROUP BY sd.ProductID, sh.OrderDate, p.Name
) AS T
WHERE T.WorstRanking = 1
ORDER BY T.OrderDate DESC;

--------------------------------------------------------------------------------------------------------------------------------------------------
/* Q.3-4 Write a query to retrieve the most valuable salesperson of each year. 
The most valuable salesperson for each year is the salesperson who has 
made most sales for AdventureWorks in the year. 
Calculate the yearly total of the TotalDue column of SalesOrderHeader 
as the yearly total sales for each salesperson. If there is a tie 
for the most valuable salesperson, your solution should retrieve it. 
Exclude the orders which didn't have a salesperson specified. 
Include the salesperson id, the bonus the salesperson earned, 
and the most valuable salesperson's total sales for the year 
columns in the report. Display 2 decimal places for the total sales. 
Sort the returned data by the year. */ 

SELECT * FROM (SELECT a.SalesPersonID,SUM(TotalDue) AS [Total Sale], Year(OrderDate) AS [Year Of Sale], SUM(Bonus) AS [Total Bonus],
RANK() OVER(PARTITION BY Year(OrderDate) ORDER BY SUM(TotalDue) DESC) AS [Top Salesman]
FROM Sales.SalesOrderHeader a
JOIN Sales.SalesPerson s
ON s.BusinessEntityID = a.SalesPersonID
WHERE a.SalesPersonID IS NOT NULL 
GROUP BY a.SalesPersonID, year(OrderDate))Sale
WHERE [Top Salesman] = 1

--------------------------------------------------------------------------------------------------------------------------------------------------
/*Q.3-5 Write a query to return a unique list of customer id’s which 
have ordered both products 711 and 715 after August 3, 2007. 
Sort the list by customer id. */ 

SELECT DISTINCT (s.CustomerID) FROM Sales.SalesOrderHeader s 
JOIN Sales.SalesOrderDetail so 
ON so.SalesOrderID = s.SalesOrderID 
WHERE ProductID = 711 and s.OrderDate > '2007-08-03' AND s.CustomerID 
IN(SELECT s.CustomerID FROM Sales.SalesOrderHeader s
JOIN Sales.SalesOrderDetail so 
ON so.SalesOrderID = s.SalesOrderID 
WHERE ProductID = 715 and s.OrderDate >'2007-08-03')
ORDER BY s.CustomerID;









































