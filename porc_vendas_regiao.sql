
--Porcentagem de vendas por região

SELECT st.Name as Region, SUM (so.TotalDue) as TotalRegional, SUM(SUM(so.TotalDue)) OVER () as TotalVendas,
(SUM (so.TotalDue) *1.0/SUM(SUM(so.TotalDue)) OVER ())  * 100 as Percentual
FROM Sales.SalesOrderHeader as so
INNER JOIN Sales.Customer as sc on sc.CustomerID = so.CustomerID
INNER JOIN Sales.SalesTerritory as st on sc.TerritoryID = st.TerritoryID
GROUP BY st.Name
ORDER BY TotalRegional DESC
