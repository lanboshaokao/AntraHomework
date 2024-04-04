USE AdventureWorks2019
go

-- How many products can you find in the Production.Product table?
select count(productid) 
from Production.Product
--Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.
SELECT COUNT(*)
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL;

--How many Products reside in each SubCategory? Write a query to display the results with the following titles.
SELECT 
    ProductSubcategoryID, 
    COUNT(ProductID) AS CountedProducts
FROM 
    Production.Product
GROUP BY 
    ProductSubcategoryID
ORDER BY 
    ProductSubcategoryID;

--How many products that do not have a product subcategory.

select count(*) as ProductsWithoutSubcategory
from Production.Product as p
where p.ProductSubcategoryID is null;

--Write a query to list the sum of products quantity in the Production.ProductInventory table.

select sum(p.Quantity) as TotalProductQuantity 
from Production.ProductInventory as p

--Write a query to list the sum of products in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100.
select p.productid, sum(p.Quantity) as TheSum
from Production.ProductInventory as p
where p.LocationID = 40
group by p.ProductID
having sum(p.Quantity) < 100;

--Write a query to list the sum of products with the shelf information in the Production.ProductInventory table and LocationID set to 40 and limit the result to include just summarized quantities less than 100
select p.Shelf, p.productid, sum(p.Quantity) as TheSum
from Production.ProductInventory as p
where p.LocationID = 40
group by p.ProductID, p.shelf
having sum(p.Quantity) < 100;
--  Write the query to list the average quantity for products where column LocationID has the value of 10 from the table Production.ProductInventory table.
select p.productid, avg(p.Quantity) as AverageProductQuantity 
from Production.ProductInventory as p
where p.LocationID = 10
group by p.ProductID

--Write query  to see the average quantity  of  products by shelf  from the table Production.ProductInventory
select p.shelf, p.productid, avg(p.Quantity)
from Production.ProductInventory as p
group by p.ProductID, p.Shelf

--Write query  to see the average quantity  of  products by shelf excluding rows that has the value of N/A in the column Shelf from the table Production.ProductInventory
select p.ProductID, p.Shelf, AVG(p.quantity)
from Production.ProductInventory as p
where p.Shelf = 'N/A'
group by p.ProductID, p.Shelf

--List the members (rows) and average list price in the Production.Product table. This should be grouped independently over the Color and the Class column. Exclude the rows where Color or Class are null.
select p.Color, p.Class, count(p.productid) as TheCount, avg(p.ListPrice) as AvgPrice
from Production.Product as p
where p.Color is not null and p.Class is not null
group by p.Color, p.Class

--Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. Join them and produce a result set similar to the following.
select * from Person.StateProvince;

select * from Person.CountryRegion;

--Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables. Join them and produce a result set similar to the following.
select s.Name as Country, p.Name as Province
from Person.CountryRegion as p, Person.StateProvince as s
where p.CountryRegionCode = s.CountryRegionCode

-- Write a query that lists the country and province names from person. CountryRegion and person. StateProvince tables and list the countries filter them by Germany and Canada. Join them and produce a result set similar to the following.
select p.Name as Country, s.Name as Province
from person.StateProvince as s, person.CountryRegion as p
where s.CountryRegionCode = p.CountryRegionCode
and p.Name in ('Germany', 'Canada')


use northwind
go
--List all Products that have been sold at least once in the last 25 years.
select p.ProductID, o.OrderDate
from Products p, [Order Details] od, Orders o
where p.ProductID = od.ProductID and od.OrderID = o.OrderID
and o.OrderDate >= DATEADD(YEAR, -25, GETDATE());
-- List top 5 locations (Zip Code) where the products sold most.
select top 5 o.ShipPostalCode, count(*) as TotalSales
from Orders o, [Order Details] od
where o.OrderID = od.OrderID
group by o.ShipPostalCode
order by TotalSales DESC;

--List top 5 locations (Zip Code) where the products sold most in the last 25 years.
select top 5 o.ShipPostalCode, count(*) as TotalSales
from Orders o, [Order Details] od
where o.OrderID = od.OrderID and o.OrderDate >= DATEADD(YEAR, -25, GETDATE())
group by o.ShipPostalCode
order by TotalSales DESC;

--List all city names and number of customers in that city.
select c.City, count(*) as NumberOfCustomers
from Customers c
group by c.City

-- List city names with more than 2 customers, and number of customers in that city.
select c.City, count(*) as NumberOfCustomers
from Customers c
group by c.City
having count(*) > 2; 

-- List the names of customers who placed orders after 1/1/98 with order date.
select cu.CompanyName, o.OrderDate
from Orders o, Customers cu
where o.CustomerID = cu.CustomerID
and o.OrderDate > '1998-01-01'

-- List the names of all customers with most recent order dates.
select cu.CompanyName, max(o.OrderDate) as MostRecentOrderDate
from Customers cu, Orders o
where cu.CustomerID = o.CustomerID
group by cu.CompanyName

--Display the names of all customers along with the count of products they bought.
select cu.CompanyName, count(od.ProductID) as ProductsBought
from Customers cu, orders o, [Order Details] od
where cu.CustomerID = o.CustomerID and o.OrderID = od.OrderID
group by cu.CompanyName

--Display the customer IDs who bought more than 100 Products with count of products.
select o.CustomerID, count(od.ProductID) as ProductsBought
from orders o, [Order Details] od
where o.OrderID = od.OrderID
group by o.CustomerID
having count(od.ProductID) > 100;

--List all of the possible ways that suppliers can ship their products.
select distinct s.CompanyName as SupplierCompanyName, sh.CompanyName as ShippingCompanyName
from Suppliers s, Products p, [Order Details] od, Orders o, Shippers sh
where s.SupplierID = p.SupplierID
and p.ProductID = od.ProductID
and od.OrderID = o.OrderID
and o.ShipVia = sh.ShipperID;

--Display the products ordered each day.
select o.OrderDate, p.ProductName
from Orders o, [Order Details] od, Products p
where o.OrderID = od.OrderID and od.ProductID = p.ProductID
order by o.OrderDate;

--Displays pairs of employees who have the same job title.
select e1.FirstName as Employee1FirstName, e1.LastName as Employee1LastName, 
       e2.FirstName as Employee2FirstName, e2.LastName as Employee2LastName, 
       e1.Title
from Employees e1, Employees e2
where e1.Title = e2.Title and e1.EmployeeID < e2.EmployeeID;

--Display all the Managers who have more than 2 employees reporting to them.

select m.EmployeeID, m.LastName, m.FirstName, COUNT(e.EmployeeID) as NumberOfReportees
from Employees e, Employees m
where e.ReportsTo = m.EmployeeID
group by m.EmployeeID, m.LastName, m.FirstName
having count(e.EmployeeID) > 2;


select c.City, c.CompanyName as name, c.ContactName, 'Customer' as type
from Customers c
union ALL
select s.City, s.CompanyName, s.ContactName, 'Supplier'
from Suppliers s
order by City, type, name;
