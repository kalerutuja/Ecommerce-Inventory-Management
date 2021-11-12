/*QUESTION 5-1 Create a function in your own database that takes two
parameters:
1)A year parameter 
2)A month parameter
The function then calculates and returns the total sale of the requested period for each territory. The function
returns data sorted by the territory name.*/

CREATE FUNCTION dbo.getSalesByTerritory
	(@Year SMALLINT, @Month SMALLINT)
RETURNS TABLE
AS
RETURN (SELECT t.Name,SUM(TotalDue) AS TotalSales
		FROM AdventureWorks2008R2.Sales.SalesOrderHeader soh
		INNER JOIN AdventureWorks2008R2.Sales.SalesTerritory t
		ON soh.TerritoryID = t.TerritoryID
		WHERE YEAR(soh.OrderDate) = @Year AND MONTH(soh.OrderDate) = @Month
		GROUP BY t.Name);
--------------------------------------------------------------------------------------------------------------------------------------
/*QUESTION 5-2 Write a stored procedure that accepts two parameters:
1)A starting date 
2)The number of the consecutive dates beginning with the starting date.The stored procedure then inserts data into all columns of the
DateRange table according to the two provided parameters.*/

-- DROP TABLE Rutuja_Kale.dbo.DateRange;

CREATE TABLE Rutuja_Kale.dbo.DateRange (
	DateID INT IDENTITY(0,1) NOT NULL,
	DateValue DATE NULL,
	DAYOFWEEK SMALLINT NULL,
	WEEK SMALLINT NULL,
	[MONTH] SMALLINT NULL,
	QUARTER SMALLINT NULL,
	[YEAR] SMALLINT NULL
);

CREATE PROCEDURE dbo.DateProcedure
@StartDate DATE, @ConsecutiveDays INT
AS
BEGIN
	DECLARE @Counter INT=1;
	WHILE (@Counter <= @ConsecutiveDays)
		BEGIN
			INSERT INTO dbo.DateRange VALUES( 
										  DATEADD(day,@Counter,@StartDate), 
										  DATEPART(dw,DATEADD(day,@Counter,@StartDate)),
										  DATEPART(week,DATEADD(day,@Counter,@StartDate)),
										  MONTH(DATEADD(day,@Counter,@StartDate)),
										  DATEPART(quarter,DATEADD(day,@Counter,@StartDate)),
										  YEAR(DATEADD(day,@Counter,@StartDate)));
			SET @Counter+=1;
		END RETURN;
END

-------------------------------------------------------------------------------------------------------------------------------------
/*QUESTION 5-3 CREATE 3 tables as listed below in your own database.Write a trigger to put the total sale order amount 
before tax (unit price * quantity for all items included in an order) in the OrderAmountBeforeTax column of SaleOrder 
whenever there is a change in SaleOrderDetail. */

CREATE TRIGGER TotalTrigger 
ON dbo.SaleOrderDetail
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @Amount INT=0;
	SELECT @Amount = SUM(UnitPrice *Quantity)
	FROM SaleOrderDetail 
	WHERE OrderID = (SELECT OrderID FROM Inserted);
	
	UPDATE SaleOrder 
	SET OrderAmountBeforeTax = @Amount 
	WHERE OrderID = (SELECT OrderID FROM Inserted)
END;

-----------------------------------------------------------------------------------------------------------------------------------------
/* QUESTION 5-4 Using AdventureWorks write a query to return the  sales territories which have never had an order worth more than $120000.
 Include the territory id, territory name and highest order value in the returned data. Use TotalDue of SalesOrderHeader as the order value.
  Sort the returned data by the territory id.
*/

SELECT s.TerritoryID, Name, max(TotalDue) as maxsale 
from Sales.SalesOrderHeader s 
join Sales.SalesTerritory t 
on s.TerritoryID = t.TerritoryID
WHERE s.TerritoryID not in (SELECT s.TerritoryID 
FROM Sales.SalesOrderHeader s
JOIN Sales.SalesTerritory t 
ON s.TerritoryID = t. TerritoryID
WHERE TotalDue > 120000)
GROUP BY s.TerritoryID, t.Name
ORDER BY s.TerritoryID;