
use AdventureWorks2019
go
-- Homework
--Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, with no filter. 
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product AS p;
--Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, excludes the rows that ListPrice is 0.
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product AS p
WHERE p.ListPrice = 0;
--Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are NULL for the Color column.
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product AS p
WHERE p.Color IS NULL;
--Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the Color column.
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product AS p
WHERE p.Color IS NOT NULL;
--Write a query that retrieves the columns ProductID, Name, Color and ListPrice from the Production.Product table, the rows that are not NULL for the column Color, and the column ListPrice has a value greater than zero.
SELECT p.ProductID, p.Name, p.Color, p.ListPrice
FROM Production.Product AS p
WHERE p.Color IS NOT NULL AND p.ListPrice > 0;
--Write a query that concatenates the columns Name and Color from the Production.Product table by excluding the rows that are null for color.
SELECT p.Name + ' - ' + p.Color AS NameColor
FROM Production.Product as p
WHERE Color IS NOT NULL;
--Write a query that generates the following result set  from Production.Product:
--NAME: LL Crankarm  --  COLOR: Black
--NAME: ML Crankarm  --  COLOR: Black
--NAME: HL Crankarm  --  COLOR: Black
--NAME: Chainring Bolts  --  COLOR: Silver
--NAME: Chainring Nut  --  COLOR: Silver
--NAME: Chainring  --  COLOR: Black

SELECT 'NAME: ' + p.Name + '  --  COLOR: ' + p.Color AS ProductDescription
FROM Production.Product as p
WHERE (Name IN ('LL Crankarm', 'ML Crankarm', 'HL Crankarm', 'Chainring Bolts', 'Chainring Nut', 'Chainring')
AND Color IN ('Black', 'Silver'));
--Write a query to retrieve the to the columns ProductID and Name from the Production.Product table filtered by ProductID from 400 to 500
SELECT p.ProductID, p.Name
FROM Production.Product as p
where ProductID between 400 and 500;

--Write a query to retrieve the to the columns  ProductID, Name and color from the Production.Product table restricted to the colors black and blue
SELECT p.ProductID, p.Name, p.Color
FROM Production.Product as p
WHERE Color IN ('Black', 'Blue');
--Write a query to get a result set on products that begins with the letter S. 
SELECT p.ProductID, p.Name, p.Color
FROM Production.Product as p
WHERE Name LIKE 'S%';
--Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. 
SELECT p.Name, p.ListPrice
FROM Production.Product as p
ORDER BY Name;
--Write a query that retrieves the columns Name and ListPrice from the Production.Product table. Your result set should look something like the following. Order the result set by the Name column. The products name should start with either 'A' or 'S'
SELECT p.Name, p.ListPrice
FROM Production.Product as p
where p.Name like 'S%' or p.Name like 'A%'
ORDER BY p.Name;
--Write a query so you retrieve rows that have a Name that begins with the letters SPO, but is then not followed by the letter K. After this zero or more letters can exists. Order the result set by the Name column.
SELECT Name
FROM Production.Product
WHERE Name LIKE 'SPO%' AND Name NOT LIKE 'SPOK%'
ORDER BY Name;
--Write a query that retrieves unique colors from the table Production.Product. Order the results  in descending  manner
SELECT DISTINCT Color
FROM Production.Product
WHERE Color IS NOT NULL
ORDER BY Color DESC;
--Write a query that retrieves the unique combination of columns ProductSubcategoryID and Color from the Production.Product table. Format and sort so the result set accordingly to the following. We do not want any rows that are NULL.in any of the two columns in the result.
SELECT DISTINCT p.ProductSubcategoryID, p.Color
FROM Production.Product as p
WHERE p.ProductSubcategoryID IS NOT NULL AND p.Color IS NOT NULL
ORDER BY p.ProductSubcategoryID, p.Color;

