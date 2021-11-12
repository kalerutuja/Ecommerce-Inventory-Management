/*Q1) Rewrite the following query to present the same data in the format
   listed below using the SQL PIVOT command. 

SELECT TerritoryID, month(OrderDate) [Month], COUNT(SalesOrderID) AS [Order Count]
FROM Sales.SalesOrderHeader
GROUP BY TerritoryID, month(OrderDate)
ORDER BY TerritoryID, month(OrderDate);*/

/*
TerritoryID		       1		 2		 3		 4		 5		 6		 7		 8		 9		 10		 11		 12
	1			      366		368		391		401		465		451		329		350		313		325		395		440
	2			      19		 40		 28		 20		 44		 27		 18		 41		 24		 21		 42		 28
	3			      20		 38		 35		 20		 44		 36		 19		 39		 34		 21		 41		 38
*/


SELECT TerritoryID,[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12]
FROM (SELECT TerritoryID, OrderDate, SalesOrderID
      FROM Sales.SalesOrderHeader) AS S
PIVOT
 (COUNT(SalesOrderID) FOR month(OrderDate)[Month] IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12] ))AS P 

SELECT * 
FROM (SELECT TerritoryID, month(OrderDate) [Month], SalesOrderID
      FROM Sales.SalesOrderHeader) AS S
PIVOT
     (COUNT(SalesOrderID) FOR [Month] IN
    ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])) AS P;
    
   
   
 /*Q2) Rewrite the following query to present the same data in the format
   listed below using the SQL PIVOT command. 

SELECT TerritoryID, datepart(qq, OrderDate) [Quarter], COUNT(SalesOrderID) AS [Order Count]
FROM Sales.SalesOrderHeader s
GROUP BY TerritoryID, datepart(qq, OrderDate)
ORDER BY TerritoryID, datepart(qq, OrderDate);*/

/*
TerritoryID	        1		  2		 3		  4
	1		       1125	    1317	992		1160
	2		        87	      91	 83		  91
	3		        93	      100	 92		 100
*/

select TerritoryID, [1], [2], [3], [4]
from
(
  SELECT TerritoryID, datepart(qq, OrderDate) [Quarter], SalesOrderID
  FROM Sales.SalesOrderHeader s
) AS SourceTable
Pivot
(
  Count(SalesOrderID) for [Quarter] In ([1], [2], [3], [4])
) As PivotTable;


/*Q3) Rewrite the following query to present the same data in the format
   listed below using the SQL PIVOT command. */

/*SELECT TerritoryID, month(OrderDate) [Month], COUNT(SalesOrderID) AS [Order Count]
FROM Sales.SalesOrderHeader
GROUP BY TerritoryID, month(OrderDate)
HAVING month(OrderDate) <= 6
ORDER BY TerritoryID, month(OrderDate);*/

/*
TerritoryID		 1		 2		 3		 4		 5		 6
	1			      366		368		391		401		465		451
	2			      19		 40		 28		 20		 44		 27
	3			      20		 38		 35		 20		 44		 36
*/

SELECT TerritoryID, [1],[2],[3],[4],[5],[6]
FROM
(
   SELECT TerritoryID, month(OrderDate) [Month], SalesOrderID
   FROM Sales.SalesOrderHeader
   Where month(OrderDate) <= 6
) AS SourceTable
PIVOT 
(
  COUNT(SalesOrderID) for [Month] IN ([1],[2],[3],[4],[5],[6])
) AS PivotTable;

/*Q4) Rewrite the following query to present the same data in a horizontal format,
   as listed below, using the SQL PIVOT command. */

/*select (p.LastName + ', ' + p.FirstName) FullName, year(sh.OrderDate) OrderYear, count(SalesOrderID) TotalOrder
from Sales.SalesOrderHeader sh
join Sales.Customer c
on sh.CustomerID = c.CustomerID
join Person.Person p
on c.PersonID = p.BusinessEntityID
where sh.CustomerID between 30000 and 30005
group by p.LastName + ', ' + p.FirstName, year(sh.OrderDate)
order by FullName;*/

/*
FullName				2005	2006	2007	2008
McCoy, James			0		2		4		2
McDonald, Christinia	0		0		1		1
McGuel, Alejandro		0		0		2		2
McKay, Yvonne			1		1		2		0
McLin, Nkenge			2		2		2		1
McPhearson, Nancy		0		0		2		2
*/

select FullName, [2005],[2006],[2007],[2008]
from
(
select (p.LastName + ', ' + p.FirstName) FullName, year(sh.OrderDate) OrderYear, SalesOrderID
from Sales.SalesOrderHeader sh
join Sales.Customer c
on sh.CustomerID = c.CustomerID
join Person.Person p
on c.PersonID = p.BusinessEntityID
where sh.CustomerID between 30000 and 30005
) As SourceTable
PIVOT 
(
  Count(SalesOrderID) for OrderYear In  ([2005],[2006],[2007],[2008])
) As PivotTable;


/*Q5) Rewrite the following query to present the same data in a horizontal format,
   as listed below, using the SQL PIVOT command. 
FullName					1st Quarter		2nd Quarter		3rd Quarter		4th Quarter
Abbas, Syed					3					4				6				3
Alberts, Amy				11					5				12				11
Ansman-Wolfe, Pamela		20					19				34				22
Blythe, Michael				110					109				112				119
Campbell, David				48					46				45				50
Carson, Jillian				119					121				115				118
Ito, Shu					61					58				63				60
Jiang, Stephen				9					13				15				11
Mensa-Annan, Tete			40					41				23				36
Mitchell, Linda				107					104				101				106
Pak, Jae					85					87				86				90
Reiter, Tsvi				104					109				108				108
Saraiva, José				64					69				71				67
Tsoflias, Lynn				28					28				27				26
Valdez, Rachel				34					30				33				33
Vargas, Garrett				53					61				57				63
Varkey Chudukatil, Ranjit	39					48				44				44

SELECT per.LastName + ', ' + per.FirstName AS FullName,DATEPART(Q, sod.OrderDate) [Quart], COUNT(od.SalesOrderID)
FROM Sales.SalesOrderHeader sod
INNER JOIN Person.Person per
ON sod.SalesPersonID = per.BusinessEntityID

 */

Select FullName, [1] As [1st Quarter],[2] As [2nd Quarter],[3] As [3rd Quarter],[4] As [4th Quarter]
from
(
 SELECT per.LastName + ', ' + per.FirstName AS FullName,DATEPART(Q, sod.OrderDate) [Quart], sod.SalesOrderID
FROM Sales.SalesOrderHeader sod
INNER JOIN Person.Person per
ON sod.SalesPersonID = per.BusinessEntityID
) As SourceTable
PIVOT 
(
  count(SalesOrderID) for [Quart] IN ([1],[2],[3],[4])
) As PivotTable;

/*Q6) The following SQL query generates a report in a vertical format.
   Please convert the query to a PIVOT query that creates a report
   containing the same data but in a horizontal format.
   The returned report should have the format like the one listed below,
   with NULL converted to 0. Use an alias to create a column heading.
   The example format below may not contain all the returned data. 
    
   SELECT TerritoryID, CAST(OrderDate AS DATE) [Order Date], 
       SUM(TotalDue) AS [Sale Amount]
   FROM Sales.SalesOrderHeader
   WHERE OrderDate BETWEEN '5-1-2008' AND '5-5-2008'
   GROUP BY TerritoryID, OrderDate
   ORDER BY TerritoryID, OrderDate;

    TerritoryID	       2008-5-1		   2008-5-2	      2008-5-3	    2008-5-4	   2008-5-5
	     1		      640355.3651		3513.7676	 10004.2614	    2220.8956	  7148.2785
	     2		      187500.0667		0.00		     0.00		  0.00		     0.00
	     3		      281836.1068		0.00		     0.00		  0.00		     0.00
*/

select TerritoryID,isnull([2008-5-1],0) As [2008-5-1],isnull([2008-5-2],0)As [2008-5-2],isnull([2008-5-3],0)As [2008-5-3],isnull([2008-5-4],0)As [2008-5-4],isnull([2008-5-5],0)As [2008-5-5]
from
(
 SELECT TerritoryID, CAST(OrderDate AS DATE) [Order Date], TotalDue
   FROM Sales.SalesOrderHeader
   WHERE OrderDate BETWEEN '5-1-2008' AND '5-5-2008' 
) As SourceTable
PIVOT 
(
  Sum(TotalDue) for [Order Date] In ([2008-5-1],[2008-5-2],[2008-5-3],[2008-5-4],[2008-5-5])
)As PivotTable;

/* Q7) Rewrite the following query to present the same data in a horizontal format, as listed below, using the SQL PIVOT command.USE AdventureWorks2008R2;

SELECT TerritoryID, month(OrderDate) [Year],SUM(TotalDue) AS [Sale Amount]
FROM Sales.SalesOrderHeader
WHERE year(OrderDate) = 2007 and month(OrderDate) between 1 and 5
GROUP BY TerritoryID, month(OrderDate)
ORDER BY TerritoryID, month(OrderDate); 

TerritoryID	January	February	March	April	May
1			270040	494871		135313	320453	599402
2			269839	312669		171608	377472	386357
3			166678	263551		202261	218488	322145
4			368640	783326		538495	493877	992669
5			140842	240255		157418	196643	242404
6			311454	417632		475132	507594	560034
7			83828	206536		140724	129677	272150
8			41897	70938		58418	81116	61234
9			205793	229599		219661	226915	225594
10			109636	206680		198662	108490	204377*/

SELECT TerritoryID AS TerritoryID,
[1] AS [January], [2] AS [February], [3] AS [March], [4] AS [April], [5] AS [May]
FROM
(
	SELECT TerritoryID, month(OrderDate) [Year], SUM(TotalDue) AS TotalDue
	FROM Sales.SalesOrderHeader
	WHERE year(OrderDate) = 2007 and month(OrderDate) between 1 and 5
	GROUP BY TerritoryID, month(OrderDate)
) AS SourceTable
PIVOT
(
	SUM(TotalDue)
	FOR [Year] IN ([1], [2], [3], [4], [5])
) AS PivotTable;













