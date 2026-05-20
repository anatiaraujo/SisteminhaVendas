-- Ranking Ticket médio por Cliente

--SELECT *
--FROM Sales.Customer

--SELECT * 
--FROM SALES.SalesOrderHeader

SELECT sc.CustomerID, SUM (so.TotalDue) as [TotalGeral], COUNT (so.SalesOrderID) as [Qtde de Pedidos],

-- Ticket Médio = TotalGeral / QtdePedidos

((SUM (so.TotalDue) *1.0 / COUNT (so.SalesOrderID))) AS [Ticket Médio]
FROM Sales.Customer AS sc
INNER JOIN Sales.SalesOrderHeader as so on so.CustomerID = sc.CustomerID
GROUP BY sc.CustomerID
ORDER BY [Ticket Médio] DESC