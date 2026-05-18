-- Curva ABC por Região

WITH BaseCliente as (
SELECT c.Nome, r.Regiao, SUM (i.Qtde * i.PrecoUnitario) as ValorTotalPed
FROM Cliente as c
INNER JOIN	Pedido as p on p.ClienteId = c.ClienteId
INNER JOIN ItemPedido as i on i.PedidoId = p.PedidoId
INNER JOIN Regiao as r on c.ClienteId = r.ClienteId
GROUP BY c.Nome, r.Regiao
),

Calculos as (
SELECT 
	Nome,
	ValorTotalPed, 
	Regiao,
	--Total por regiao
	SUM(ValorTotalPed) OVER (PARTITION BY Regiao) AS [Valor Total por Regiao],
	-- percentual dentro da regiao
	(ValorTotalPed * 1.0 / SUM (ValorTotalPed) OVER (PARTITION BY (Regiao))*100) as Porc,
	-- acumulado por regiao
	SUM(ValorTotalPed) OVER (
		PARTITION BY Regiao 
		ORDER BY ValorTotalPed DESC
		) AS [Acumulado Por Regiao],
	-- perc acumulado por regiao
	SUM(ValorTotalPed) OVER (
		PARTITION BY Regiao 
		ORDER BY ValorTotalPed DESC ) * 1.0 / (SUM(ValorTotalPed) OVER (PARTITION BY Regiao)) *100 as [Perc Acumulado por Regiao]
FROM BaseCliente
)

SELECT 
	Nome,
	ValorTotalPed,
	Porc,
	Regiao,
	[Perc Acumulado por Regiao],
	CASE
		WHEN [Perc Acumulado por Regiao] <= 80 THEN 'A'
		WHEN [Perc Acumulado por Regiao] <= 95 THEN 'B'
	ELSE 'C'
	END as [Classificação ABC]
FROM Calculos
ORDER BY [Valor Total por Regiao] DESC;
