--Total Sales
Select SUM(o.TotalPrice) As TotalSales
From [Order] o ;

--Each Product Sales
Select ProductTitle , SUM(oi.Quantity * oi.UnitPrice) As ProductSales
From OrderItem oi
Join Product p ON oi.ProductId = p.ProductId
Group By p.ProductTitle
Order By ProductSales Desc ;

--Monthly Sales
Select Year(o.OrderDate) As Year ,
	   Month (o.OrderDate) As Month ,
	   SUM(o.TotalPrice) As MonthlySales
From [Order] o
Group By Year(o.OrderDate) , Month (o.OrderDate)
Order By Year , Month Desc ;

--Top Customers
Select c.Name , SUM(o.TotalPrice) As CustomerSales
From [Order] o 
Join Customer c ON o.CustomerId = c.CustomerId
Group By c.Name
Order By CustomerSales Desc ;

--Best Selling product 
Select Top 1 p.ProductTitle , SUM(oi.Quantity) As TotalQuantity
From Product p 
Join OrderItem oi ON p.ProductId = oi.ProductId
Group By p.ProductTitle
Order By TotalQuantity Desc ;

--Average Order Value
Select AVG(TotalPrice) As AvgOrderValue
From [Order] ;

--Oreder Count
Select c.Name , COUNT(o.OrderId) As OrederCount
From Customer c 
Join [Order] o ON c.CustomerId = o.CustomerId
Group By c.Name
Order By OrederCount Desc ;

--Total Paid by Payment Method 
Select PaymentMethod , SUM(Amount) As TotalPaid
From Payment
Group By PaymentMethod 
Order By TotalPaid Desc ;

--Inactive Customers
Select c.Name 
From Customer c 
Left Join [Order] o ON c.CustomerId = o.CustomerId
Where o.OrderId IS NULL ;

--Products with No Sales
Select p.ProductTitle
From Product p 
Left Join OrderItem oi ON p.ProductId = oi.ProductId
Where oi.ProductId IS NULL ;
