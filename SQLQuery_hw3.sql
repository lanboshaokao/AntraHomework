 -- List all cities that have both Employees and Customers.

 select e.City
 from Employees e
 where exists(
 select 1
 from Customers c
 where e.City = c.City);

 --List all cities that have Customers but no Employee.
 --a. use sub-query
 select c.City
 from Customers c
 where not exists(
	select 1
	from Employees e
	where e.City = c.City);

 --b. do not user sub-query
 --left join的使用, 用于查找这种一个表有, 一个表没有的情况适用, 只要有一个相同的共同的feature就可以连接.
select distinct c.City
from Customers as c
left join Employees as e on c.City = e.City
where e.City is null;

--List all products and their total order quantities throughout all orders.
--注意groupby的时候, 如果select中定义了多少内容, 就需要在group by中同时merge多少内容.
select p.ProductID, p.ProductName, sum(od.Quantity) as TotalOrderQuantities
from Products as p
left join [Order Details] as od on p.ProductID = od.ProductID
group by p.ProductID, p.ProductName
order by p.productID

-- List all Customer Cities and total products ordered by that city.
select c.City, sum(od.Quantity) as TotalProducts
from Customers c
join Orders o on c.CustomerID = o.CustomerID
join [Order Details] od on o.OrderID = od.OrderID
group by c.City
order by TotalProducts DESC;

--List all Customer Cities that have at least two customers.
--a. Use Union
(select City
from Customers
group by city
having count(CustomerID) >= 2)
union
(select City
from Customers
group by city
having count(CustomerID) >= 2)


--b. Use sub-query and no union
select c.City
from customers as c 
where (
	select count(*)
	from Customers c2
	where c2.City = c.City
	) >= 2
group by c.City;

--   List all Customer Cities that have ordered at least two different kinds of products.

select cus.City, count(prod.productid) as Products
from Customers as cus
join orders ord on cus.CustomerID = ord.CustomerID
join [Order Details] od on ord.Orderid = od.OrderID
join Products prod on od.ProductID = prod.ProductID
group by cus.City
having count(distinct prod.ProductID) >= 2;

-- List all Customers who have ordered products, but have the ‘ship city’ on the order different from their own customer cities.
select distinct c.companyname
from customers c
join orders ord on c.CustomerID = ord.CustomerID
where ord.ShipCity != c.city;

-- List 5 most popular products, their average price, and the customer city that ordered most quantity of it.
with ProductQuantities as (
    select 
        od.ProductID, 
        SUM(od.Quantity) as TotalQuantitySold
    from 
        [Order Details] od
    group by 
        od.ProductID
),
AveragePrices as (
    select 
        od.ProductID, 
        avg(od.UnitPrice) as AveragePrice
    from 
        [Order Details] od
    group by 
        od.ProductID
),
MaxCityQuantities as (
    select 
        od.ProductID, 
        c.City, 
        SUM(od.Quantity) as QuantityPerCity,
        ROW_NUMBER() over (partition by od.ProductID order by sum(od.Quantity) DESC) as RowNum
    from 
        [Order Details] od
    join 
        Orders o on od.OrderID = o.OrderID
    join 
        Customers c on o.CustomerID = c.CustomerID
    group by
        od.ProductID, c.City
)
select top 5
    pq.ProductID,
    p.ProductName,
    ap.AveragePrice,
    mcq.City as TopCity,
    pq.TotalQuantitySold
from 
    ProductQuantities pq
join 
    AveragePrices ap on pq.ProductID = ap.ProductID
join 
    MaxCityQuantities mcq on pq.ProductID = mcq.ProductID
join 
    Products p on pq.ProductID = p.ProductID
where 
    mcq.RowNum = 1
order by 
    pq.TotalQuantitySold DESC;




--List all cities that have never ordered something but we have employees there.
--a.Use sub-query
select distinct e.City
from Employees e
where e.City not in (
    select o.ShipCity from Orders o
);

--b.Do not use sub-query
select distinct e.City
from Employees e
left join Orders o ON e.City = o.ShipCity
WHERE o.OrderID is null;

--List one city, if exists, that is the city from where the employee sold most orders (not the product quantity) is, and also the city of most total quantity of products ordered from. (tip: join  sub-query)
with EmployeeSales as (
    select top 1 e.City as EmployeeCity, count(o.OrderID) as TotalOrders
    from Employees e
    join Orders o on e.EmployeeID = o.EmployeeID
    group by e.City
    order by TotalOrders DESC
),
ProductQuantities as (
    select top 1 o.ShipCity as OrderCity, sum(od.Quantity) as TotalQuantity
    from Orders o
    join [Order Details] od on o.OrderID = od.OrderID
    group by o.ShipCity
    order by TotalQuantity DESC
)
select 
    es.EmployeeCity as 'TopEmployeeSalesCity', 
    pq.OrderCity as 'TopQuantityCity'
from 
    EmployeeSales es
full join 
    ProductQuantities pq on es.EmployeeCity = pq.OrderCity;

--How do you remove the duplicates record of a table?
WITH CTE AS (
   SELECT 
      *, 
      ROW_NUMBER() OVER (
         PARTITION BY [Column1], [Column2], ..., [ColumnN] -- columns that define a duplicate
         ORDER BY [SomeUniqueColumn] -- often a date or a unique ID
      ) AS rn
   FROM 
      [YourTable]
)
DELETE FROM CTE WHERE rn > 1;


