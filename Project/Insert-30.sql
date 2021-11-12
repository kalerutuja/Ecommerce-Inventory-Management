USE Rutuja_Project;

--Data Insertion
INSERT INTO ProductCategory VALUES
	('Furniture'),
	('Stationary'),
	('Toys'),
	('Electronics'),
	('Beauty & Personal Care'),
	('Food & Grocery'),
	('Clothing'),
	('Utensils'),
	('Sports'),
	('Health Care'),
	('Automobile & Industrial Equipments'),
	('Accessories')

	select * from ProductCategory pc 

	DROP FUNCTION IF EXISTS dbo.getProductCategoryID;


CREATE FUNCTION dbo.getProductCategoryID(@CategoryName VARCHAR(MAX)) RETURNS INT
BEGIN
	RETURN (SELECT ProductCategoryID FROM ProductCategory WHERE ProductCategory = @CategoryName)
END;



INSERT INTO Product VALUES
	('Shoes',49.98,2,dbo.getProductCategoryID('Sports')),
	('Mobile Phone',999,1,dbo.getProductCategoryID('Electronics')),
	('Laptop',1070,1,dbo.getProductCategoryID('Electronics')),
	('Bottle',17.99,4,dbo.getProductCategoryID('Utensils')),
	('T-shirt',10.99,7,dbo.getProductCategoryID('Clothing')),
	('Hand-Bag',159.00,2,dbo.getProductCategoryID('Accessories')),
	('HeadPhone',30.99,3,dbo.getProductCategoryID('Electronics')),
	('Acrylic Colours',24.99,2,dbo.getProductCategoryID('Stationary')),
	('Desk',69.99,1,dbo.getProductCategoryID('Furniture')),
	('File Cabinet',84.12,3,dbo.getProductCategoryID('Furniture')),
	('Book',12.00,6,dbo.getProductCategoryID('Stationary')),
	('Scissors',9.49,3,dbo.getProductCategoryID('Stationary')),
	('Dinner Set',44.66,1,dbo.getProductCategoryID('Utensils')),
	('Lipstick',12.78,3,dbo.getProductCategoryID('Beauty & Personal Care')),
	('RC Car',12.78,3,dbo.getProductCategoryID('Toys'))

Select * From Product

INSERT INTO [Address] Values 
	(1,'8273 Brown Rd','Middle Village','NY', 11379,'East','US'),
	(2,'435 James Street','Levittown', 'NY',11756,'East','US'),
	(3,'974 High Point Ave','Upper Darby','PA',19082,'Middle','US'),
	(4,'5 Leeton Ridge Ave','Greenwood','SC',29646,'South','US'),
	(5,'543 Cherry Hill Ave','Defiance','OH',43512, 'East','US'),
	(6,'44 Cambridge Avenue','Jonesboro','GA', 30236,'South','US'),
	(7,'823 Addison Ave','Oak Park','MI',48237,'Middle','US'),
	(8,'25 New Ave','Rolla','MO',65401,'West','US'),
	(9,'9001 Bradford Ave','Dracut','MA',01826,'East','US'),
	(10,'270 Rockaway St','Yuba City','CA',95993,'West','US'),
	(11,'9224 Beechwood Road','Manitowoc','WI',54220,'North','US'),
	(12,'447 Alton Ave','Beloit','CA',53511,'West','US'),
	(13,'20 Cobblestone Court','Eau Claire','WI',54701,'North','US'),
	(14,'647 Mammoth Avenue','Hudsonville','MI',49426,'Middle','US'),
	(15,'8966 Cedar Ave Apt 545','Lady Lake','FL',32159,'South','US')

select * from Address a 

INSERT INTO Customer VALUES
	(1001,'Prajakta','Sawant','1995-12-30','prajakta225@gmail.com',7806280121),
	(1002,'Adarsh','Havalad','1996-11-04','Adarsh.H500@gmail.com',8667156109),
	(1003,'Rushabh','Patel','1996-12-23','R.Patel@gmial.com',9176008190),
	(1004,'Rutuja','Kale','1993-12-05','Rutuja.Kale15@gmail.com',1809003232),
	(1005,'Katy','Tupes','1986-01-29','Tupes55.Katy@yahoo.com',4132056127),
	(1006,'Riya','Sharma','2000-05-09','Sharma.Riya@gmail.com',8676678678),
	(1007,'Josh','Henry','1980-06-05','Henry.J@gmail.com',2025550111),
	(1008,'Robert','Williams','1961-03-24','R.williams50@gmail.com',4105550148),
	(1009,'Ann','Hurley','1995-11-29','Ann.Hurley25@yahoo.com',2025550199),
	(1010,'John','Webber','2005-09-01','J.webber14@gmail.com',4105550133),
	(1011,'Susanne','West','1983-04-30','West.Susan10@gmail.com',6175550111),
	(1012,'Pearson','Charles','1929-06-08','PCharles@gmail.com',6172090111),
	(1013,'Mike','Crosse','2000-12-27','Crosse.Mike20@gmial.com',8035550123),
	(1014,'Holly','Yodice','1995-10-20','Holly.Y@gmail.com',4015550101),
	(1015,'Susan','Lucy','1950-07-15','Lucy.S@gmail.com',2025550191) 

select * from Customer c 

INSERT INTO SellerAddress Values
	(1,'31643 55th Ln', 'Arkansas City','KS',67005,'Middle','US'),
	(2,'8865 Foxrun Lane','Oxnard','CA',93033,'West','US'),
	(3,'87 N. Shore St','Jones','OK',73049,'South','US'),
	(4,'280 Sumner St','Stoughton','MA',09876,'East','US'),
	(5,'11255 River Rd','Havre','MT',59501,'North','US') 

select * from SellerAddress sa 

Insert INTO Seller VALUES
	(1,'MM Electronics','Electronics@mm.com',7858245592,1),
	(2,'Palo Accessories','Accessories@palo.com',5628019854,2),
	(3,'Copley Products','Products@copley.com',9182512886,3),
	(4,'Arlington Care','Care@arlington.com',51527281231,4),
	(5,'Burlington Sports','sports@burlington.com',5808841421,5)

select * from Seller 


INSERT INTO [Order] VALUES 
	(1001,99.96,'2021-07-01'),
	(1002,1999,'2021-07-01'),
	(1003,1070,'2021-07-01'),
	(1004,17.99,'2021-07-02'),
	(1005,32.97,'2021-07-02'),
	(1006,159.00,'2021-07-03'),
	(1007,30.99,'2021-07-03'),
	(1008,24.99,'2021-07-05'),
	(1009,69.99,'2021-08-18'),
	(1010,252.36,'2021-08-18'),
	(1011,24.00,'2021-08-18'),
	(1012,69.95,'2021-08-18'),
	(1013,18.98,'2021-08-18'),
	(1014,44.66,'2021-08-18'),
	(1015,12.78,'2021-08-18')

	select * from [Order];


INSERT INTO OrderStatus VALUES
	(1,1001,'Delivered'),
	(2,1002,'Delivered'),
	(3,1003,'Shipped'),
	(4,1004,'Processing'),
	(5,1005,'Shipped'),
	(6,1006,'Cancelled'),
	(7,1007,'Shipped'),
	(8,1008,'Delivered'),
	(9,1009,'Processing'),
	(10,1010,'Delivered'),
	(11,1011,'Delivered'),
	(12,1012,'Shipped'),
	(13,1013,'Shipped'),
	(14,1014,'Delivered'),
	(15,1015,'Processing');


select * from OrderStatus os;

INSERT INTO Membership VALUES 
		(1001,'Classic',DATEADD(DAY,90,2021-06-01)),
		(1002,'Premier',DATEADD(DAY,365,2022-01-05)),
		(1003,'Classic',DATEADD(DAY,90,2021-05-07)),
		(1004,'Classic',DATEADD(DAY,90,2021-09-10)),
		(1005,'Premier',DATEADD(DAY,365,2022-12-30)),
		(1006,'Classic',DATEADD(DAY,90,2021-02-10)),
		(1007,'Premier',DATEADD(DAY,365,2022-01-25)),
		(1008,'Premier',DATEADD(DAY,365,2022-03-20)),
		(1009,'Classic',DATEADD(DAY,90,2021-05-03)),
		(1010,'Classic',DATEADD(DAY,90,2021-12-05)),
		(1011,'Classic',DATEADD(DAY,90,2021-08-19)),
		(1012,'Premier',DATEADD(DAY,365,2022-12-04)),
		(1013,'Classic',DATEADD(DAY,90,2021-06-15)),
		(1014,'Classic',DATEADD(DAY,90,2021-02-10)),
		(1015,'Classic',DATEADD(DAY,90,2021-09-19));



INSERT INTO OrderProduct(OrderID, ProductID, Quantity) VALUES
(1,1,26),(2,2,46),(3,3,45),(4,4,24),(5,5,64),(6,6,14),(7,7,34),(8,8,26),(9,9,36),(10,10,43),(11,11,47),(12,12,102),(13,13,63),(14,14,542),(15,15,233) 

select * from OrderProduct
Insert Into Promotion VALUES 
(1,10),(2,20),(3,10),(4,10),(5,5),(6,10),(7,5),(8,5),(9,10),(10,10),(11,2),(12,2),(13,2),(14,10),(15,2)

SELECT * FROM OrderProduct;


select * from Payment p;

INSERT INTO Payment(OrderID,BillingAmount, Status,PaymentMode) VALUES
	(1,1,'Pending','Debit'),
	(2,1,'Complete','Credit'),
	(3,1,'Complete','Credit'),
	(4,1,'Complete','Debit'),
	(5,1,'Complete','Debit'),
	(6,1,'Complete','Credit'),
	(7,1,'Complete','Paypal'),
	(8,1,'Complete','Credit'),
	(9,1,'Complete','Debit'),
	(10,1,'Pending','Credit'),
	(11,1,'Complete','Paypal'),
	(12,1,'Complete','Credit'),
	(13,1,'Complete','Debit'),
	(14,1,'Failed','Paypal'),
	(15,1,'Complete','Credit');


select * from [RETURN];
select * from product;


-- orderID, productID, Type , Reason

insert into [RETURN] (ProductID,Type,Reason) values ((select ProductID from Product where ProductID = 1),'Exchange','Not Satisfied');
insert into [RETURN] (ProductID,Type,Reason) values ((select ProductID from Product where ProductID = 2),'Exchange','Not Satisfied');
insert into [RETURN] (ProductID,Type,Reason) values ((select ProductID from Product where ProductID = 3),'Cancellation','Not Satisfied');
insert into [RETURN] (ProductID,Type,Reason) values ((select ProductID from Product where ProductID = 4),'Exchange','Not Satisfied');
insert into [RETURN] (ProductID,Type,Reason) values ((select ProductID from Product where ProductID = 5),'Cancellation','Better Price Available');
insert into [RETURN] (ProductID,Type,Reason) values ((select ProductID from Product where ProductID = 6),'Exchange','Not Satisfied');
insert into [RETURN] (ProductID,Type,Reason) values ((select ProductID from Product where ProductID = 7),'Cancellation','Better Price Available');
insert into [RETURN] (ProductID,Type,Reason) values ((select ProductID from Product where ProductID = 8),'Cancellation','Not Satisfied');
insert into [RETURN] (ProductID,Type,Reason) values ((select ProductID from Product where ProductID = 9),'Exchange','Not Satisfied');
insert into [RETURN] (ProductID,Type,Reason) values ((select ProductID from Product where ProductID = 10),'Cancellation','Not Satisfied');
insert into [RETURN] (ProductID,Type,Reason) values ((select ProductID from Product where ProductID = 11),'Exchange','Not Satisfied');
insert into [RETURN] (ProductID,Type,Reason) values ((select ProductID from Product where ProductID = 12),'Cancellation','Better Price Available');
insert into [RETURN] (ProductID,Type,Reason) values ((select ProductID from Product where ProductID = 13),'Exchange','Not Satisfied');
insert into [RETURN] (ProductID,Type,Reason) values ((select ProductID from Product where ProductID = 14),'Exchange','Not Satisfied');
insert into [RETURN] (ProductID,Type,Reason) values ((select ProductID from Product where ProductID = 15),'Cancellation','Better Price Available');

INSERT INTO SellerProduct (SellerID,ProductID) VALUES
             (1,1),
			 (2,2),
			 (3,3),
			 (4,4),
			 (5,5)
			
select * from SellerProduct ;

--sellerid,productid,rating,comment

INSERT INTO Feedback(SellerID,ProductID,Rating,Comment) values((select SellerID from SellerProduct where SellerID =1),(select ProductID from SellerProduct where ProductID =1),4,NULL)
INSERT INTO Feedback(SellerID,ProductID,Rating,Comment) values((select SellerID from SellerProduct where SellerID =2101)3,5,'Super Quality,Quick delivery'),
INSERT INTO Feedback(SellerID,ProductID,Rating,Comment) values((select SellerID from SellerProduct where SellerID =2101),7,4,'Remarkably pleased'),
INSERT INTO Feedback(SellerID,ProductID,Rating,Comment) values((select SellerID from SellerProduct where SellerID =2101),6,5,'Excellent product quality'),
INSERT INTO Feedback(SellerID,ProductID,Rating,Comment) values((select SellerID from SellerProduct where SellerID =2101),11,5,'Quality of item was great. Quality of the wrapping was good. Fantastic delivery'),
INSERT INTO Feedback(SellerID,ProductID,Rating,Comment) values((select SellerID from SellerProduct where SellerID =2101),4,2,'Product was fine'),
INSERT INTO Feedback(SellerID,ProductID,Rating,Comment) values((select SellerID from SellerProduct where SellerID =2101),13,3,'Fine packaging. Notably super delivery'),
INSERT INTO Feedback(SellerID,ProductID,Rating,Comment) values((select SellerID from SellerProduct where SellerID =2101),1,3,NULL),
INSERT INTO Feedback(SellerID,ProductID,Rating,Comment) values((select SellerID from SellerProduct where SellerID =2101),5,4,'Delivered product was fine'),
INSERT INTO Feedback(SellerID,ProductID,Rating,Comment) values((select SellerID from SellerProduct where SellerID =2101),15,4,NULL),
INSERT INTO Feedback(SellerID,ProductID,Rating,Comment) values((select SellerID from SellerProduct where SellerID =2101),14,5,'Very, very high-standard delivery. Lovely packaging. Recommended'),
INSERT INTO Feedback(SellerID,ProductID,Rating,Comment) values((select SellerID from SellerProduct where SellerID =2101),10,5,'Great packaging. Delivery was high-standard'),
INSERT INTO Feedback(SellerID,ProductID,Rating,Comment) values((select SellerID from SellerProduct where SellerID =2101),12,3,NULL),
INSERT INTO Feedback(SellerID,ProductID,Rating,Comment) values((select SellerID from SellerProduct where SellerID =2101),8,3,'Good Seller'),
INSERT INTO Feedback(SellerID,ProductID,Rating,Comment) values((select SellerID from SellerProduct where SellerID =2101),9,2,'Delivered late')
			

select * from Feedback f 




