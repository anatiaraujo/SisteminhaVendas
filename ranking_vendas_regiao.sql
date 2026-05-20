--Ranking de Vendas por Região

SELECT st.Name as Region, SUM (so.TotalDue) as TotalVendas
FROM Sales.SalesOrderHeader as so
INNER JOIN Sales.Customer as sc on sc.CustomerID = so.CustomerID
INNER JOIN Sales.SalesTerritory as st on sc.TerritoryID = st.TerritoryID
GROUP BY st.Name
ORDER BY TotalVendas DESC
