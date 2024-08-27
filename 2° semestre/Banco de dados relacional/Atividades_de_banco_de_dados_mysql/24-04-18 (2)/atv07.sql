create table Employees(
employeeId int not null primary key,
lastName varchar(255),
firstName varchar(255),
birthDate datetime,
notes varchar(255)
)

create table Orders(
orderId int not null PRIMARY KEY,
customerId int,
employeeId int,
shipperId int,
orderDate datetime,
FOREIGN KEY (customerId) references customers(customerId),
FOREIGN KEY (employeeId) references employees(employeeId),
FOREIGN KEY (shipperId) references shippers(shipperId)
)

create table OrderDetails(
orderDetailId int not null primary key,
orderId int,
productId int,
quantity int,
FOREIGN KEY (orderId) references orders(orderId),
FOREIGN KEY (productId) references products(productId)
)

create table Products(
productId int not null primary key,
productName varchar(255),
unity varchar(255),
price decimal(10,2),
supplierId int,
categoryId int,
FOREIGN KEY (supplierId) references suppliers(supplierId),
FOREIGN KEY (categoryId) references categories(categoryId)
)

create table Suppliers(
supplierId int not null primary key,
supplierName varchar(255),
contactName varchar(255),
address varchar(255),
city varchar(255),
country varchar(255),
phone varchar(255)
)

create table Categories(
categoryId int not null primary key,
categoryName varchar(255),
description varchar(255)
)

create table Shippers(
shipperId int not null primary key,
shipperName varchar(255),
phone varchar(255)
)

create table Customers(
customerID int not null primary key,
customerName varchar(255),
contactName varchar(255),
address varchar(255),
city varchar(255),
country varchar(255)
)

create view v_orders as
Select TOP 100 PERCENT
o.orderId, o.orderDate, e.firstName -- , d.productId, d.quantity, p.price
, SUM(d.quantity * p.price) as Total
FROM
Orders o
Inner Join Employees e ON (e.employeeId = o.employeeId)
Inner Join OrderDetails d ON (d.orderId = o.orderId)
Inner Join Products p ON (p.productId = d.productId)
GROUP BY o.orderId, o.orderDate, e.firstName
ORDER BY Total DESC

create view v_orders as
SELECT TOP 100 PERCENT
o.OrderID, o.OrderDate, e.FirstName
,p.ProductName, c.CategoryName, d.Quantity , p.Price
,d.Quantity * p.Price As 'Total Produto'
FROM
Orders o
Inner JOIN Employees e On (e.EmployeeID = o.EmployeeID)
Inner JOIN OrderDetails d On (d.orderid = o.orderid)
Inner JOIN Products p ON (p.ProductID = d.ProductID )
Inner JOIN Categories c ON (c.CategoryID = p.CategoryID)

create view v_orders as
SELECT TOP 100 PERCENT
c.customername,
SUM(d.Quantity * p.Price) as 'Total de Vendas',
AVG(d.Quantity * p.Price) as 'Média de Vendas'
FROM
Orders o
INNER JOIN OrderDetails d ON (d.OrderID= o.OrderID)
INNER JOIN Customers c ON (c.CustomerID = o.CustomerID )
INNER JOIN Products p ON (p.ProductID = d.ProductID)
GROUP BY c.customername
ORDER BY 3 DESC

create view v_orders as
SELECT TOP 100 PERCENT
c.categoryname,
SUM(d.Quantity * p.Price) as 'Total de Vendas',
AVG(d.Quantity * p.Price) as 'Média de Vendas'
FROM
OrderDetails d 
INNER JOIN Products p ON (p.ProductID = d.ProductID)
INNER JOIN Categories c ON (c.categoryid = p.categoryid )
GROUP BY c.categoryname
ORDER BY 3 DESC

create view v_orders as
SELECT TOP 100 PERCENT
  e.LastName+', '+e.FirstName as 'Empregado',
SUM(d.Quantity * p.Price) as 'Total de Vendas',
AVG(d.Quantity * p.Price) as 'Média de Vendas'
FROM
Orders o
INNER JOIN OrderDetails d ON (d.OrderID= o.OrderID)
INNER JOIN Employees e ON (e.employeeid = o.employeeid )
INNER JOIN Products p ON (p.ProductID = d.ProductID)
GROUP BY e.LastName+', '+e.FirstName
ORDER BY 3 DESC

create view v_orders as
SELECT TOP 100 PERCENT
  s.ShipperName,
SUM(d.Quantity * p.Price) as 'Total de Vendas',
AVG(d.Quantity * p.Price) as 'Média de Vendas'
FROM
Orders o
INNER JOIN OrderDetails d ON (d.OrderID= o.OrderID)
INNER JOIN Shippers s ON (s.ShipperID= o.ShipperID)
INNER JOIN Products p ON (p.ProductID = d.ProductID)
GROUP BY s.ShipperName
ORDER BY 3 DESC

create view v_orders as
SELECT TOP 100 PERCENT
p.productname,
SUM(d.Quantity * p.Price) as 'Total de Vendas',
AVG(d.Quantity * p.Price) as 'Média de Vendas'
FROM
OrderDetails d 
INNER JOIN Products p ON (p.ProductID = d.ProductID)
GROUP BY p.productname
ORDER BY 3 DESC

create view v_orders as
SELECT TOP 100 PERCENT
  s.ShipperName,
  p.ProductName,
  SUM(d.Quantity * p.Price) as 'Total de Vendas'
FROM
Orders o
INNER JOIN OrderDetails d ON (d.OrderID= o.OrderID)
INNER JOIN Shippers s ON (s.ShipperID= o.ShipperID)
INNER JOIN Products p ON (p.ProductID = d.ProductID)
GROUP BY s.ShipperName, p.ProductName
ORDER BY 'Total de Vendas' DESC

create view v_orders as
SELECT TOP 100 PERCENT
   YEAR(o.OrderDate) AS 'Ano',
   MONTH(o.OrderDate) AS 'Mês',
   AVG(d.Quantity * p.Price) as 'Média de Vendas'
FROM
Orders o
INNER JOIN OrderDetails d ON (d.OrderID= o.OrderID)
INNER JOIN Products p ON (p.ProductID = d.ProductID)
GROUP BY YEAR(o.OrderDate),MONTH(o.OrderDate)
ORDER BY 'Ano' DESC,'Mês' DESC

create view v_dates as
select 
 DATEPART(mm,OrderDate),Month(Orderdate) as mes 
,DATEPART(dy,OrderDate) as 'dia do ano'
,DATEPART(dy,GetDate()) as 'dia do ano atual'
,DATEPART(dw,GetDate()) as 'dia da semana'
,DATEPART(day,GetDate()) as 'dia'
from Orders

