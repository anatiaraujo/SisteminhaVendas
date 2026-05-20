-- Ranking Cliente por região


SELECT st.Name, sc.CustomerID,
SUM (so.TotalDue) as [TotalGeral],
SUM (SUM(SO.TOTALDUE)) OVER (PARTITION BY (ST.Name)) as [TotalRegional],
ROW_NUMBER() OVER (PARTITION BY st.Name ORDER BY SUM(so.TotalDue) DESC) as Ranking
FROM Sales.Customer AS sc
INNER JOIN Sales.SalesOrderHeader as so on so.CustomerID = sc.CustomerID
INNER JOIN Sales.SalesTerritory AS st ON sc.TerritoryID = st.TerritoryID
GROUP BY st.Name, sc.CustomerID