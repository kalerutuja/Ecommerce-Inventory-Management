Create Procedure GetOrderSummary
@Status Varchar(10)
As 
Begin
	Select c.CustomerID,c.FirstName,c.LastName,pm.PaymentID,o.OrderDate,os.status
	from customer c 
	inner join [order] o 
	on c.CustomerID = o.CustomerID
	inner join OrderStatus os 
	on os.OrderID = o.OrderID
	inner join Payment pm 
	on pm.OrderID = o.ORDERID 
	Where os.status = @Status
	
END;
exec GetOrderSummary 'Shipped'

------------------------------------------------------------------------------------------------------------
Drop PROCEDURE TotalSalesPerDay;

CREATE PROCEDURE TotalSalesPerDay
@OrderDate DATE
AS BEGIN

	SELECT o.OrderDate, sum(op.Quantity*pm.BillingAmount) as TotalSale
	FROM [Order] o
	INNER JOIN Payment pm
	ON pm.OrderId = o.OrderId
	Inner join OrderProduct op 
	on o.ORDERID = op.ORDERID 
	WHERE o.OrderDate = @OrderDate
	GROUP BY o.OrderDate

END
EXEC TotalSalesPerDay @OrderDate = '2021-07-01'