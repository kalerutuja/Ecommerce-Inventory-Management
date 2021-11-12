/*PART-A - Create 3 tables and the corresponding relationships to implement the ERD below in your owndatabase.*/
-- step 1
Create Database Rutuja_Kale;

USE Rutuja_kale;

-- step 2

CREATE TABLE 
TargetCustomers(TargetID INT NOT NULL PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Address VARCHAR(50) NOT NULL,
City VARCHAR(50) NOT NULL,
State VARCHAR(50) NOT NULL,
ZipCode INT NOT NULL);

CREATE TABLE 
MailingLists(MailingListID INTEGER PRIMARY KEY NOT NULL,
MailingList VARCHAR(50)NOT NULL);

CREATE TABLE 
 TargetMailingLists(TargetID INT FOREIGN KEY REFERENCES TargetCustomers(TargetID),
 MailingListID INT FOREIGN KEY REFERENCES MailingLists(MailingListsID)
 Constraint PKTargetMailingLists Primary Key Clustered
 (TargetID,MailingListID));
 
-------------------------------------------------------------------------------------------------------------------------------
/* PART-B - Use the content of AdventureWorks and write a query to list the top 3products included in an orderfor all orders. 
 * The top 3 products have the 3 highest order quantities. 
 * If there is a tie, it needs to be retrieved. The report needs to have the following format. 
 * Sort the returneddata by the sales order column.*/

WITH temp AS

(SELECT SalesOrderID, ProductID, sum(OrderQty) ttl,
RANK() OVER (PARTITION BY SalesOrderID ORDER BY sum(OrderQty) DESC) AS TopProduct
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID, ProductID
)
SELECT t1.salesOrderID,

Stuff((SELECT ', ' +RTRIM(CAST(ProductID AS char))
    FROM temp 
    WHERE SalesOrderID = t1.SalesOrderID and TopProduct <=3
    FOR xml PATH('')), 1, 2, '') AS Products
    
    FROM temp t1
    WHERE t1.TopProduct <= 3
    GROUP BY t1.SalesOrderID
    ORDER BY SalesOrderID;

-------------------------------------------------------------------------------------------------------------------------------
/*PART- C Bill of Materials -Recursive */
/* The following code retrieves the components required for manufacturing "Mountain-500 Black, 48" (Product 992). 
Modify the code to retrieve the most expensive component(s) at each component level.
Use the list price of a component to determine the most expensive component for each level.
Exclude the components which have a list price of 0.Sort the returned data by the component level. */

WITH Parts(AssemblyID, ComponentID, PerAssemblyQty, EndDate, ComponentLevel) AS
(
SELECT b.ProductAssemblyID,
b.ComponentID, b.PerAssemblyQty,b.EndDate, 0 AS ComponentLevel 
FROM Production.BillOfMaterials AS b 
WHERE b.ProductAssemblyID = 992 AND b.EndDate IS NULL 
UNION ALL
SELECT bom.ProductAssemblyID, bom.ComponentID, p.PerAssemblyQty,bom.EndDate, ComponentLevel + 1 
FROM Production.BillOfMaterials AS bom
INNER JOIN Parts AS p
ON bom.ProductAssemblyID = p.ComponentID AND bom.EndDate IS NULL
)
SELECT * FROM(SELECT AssemblyID, ComponentID, Name, PerAssemblyQty, ComponentLevel, 
DENSE_RANK() OVER(PARTITION BY Componentlevel ORDER BY pr.ListPrice DESC)AS PriceLevel 
FROM Parts AS p
INNER JOIN Production.Product AS pr
ON p.ComponentID = pr.ProductID
where pr.ListPrice <>0
)temp
where PriceLevel=1 
ORDER BY ComponentLevel, AssemblyID, ComponentID;
