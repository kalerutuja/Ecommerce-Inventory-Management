
---------------------Computed column using function - calculate age ------------------------
ALTER TABLE Customer ADD CurrentAge AS DATEDIFF(YEAR, DOB, GETDATE())

SELECT * FROM Customer

