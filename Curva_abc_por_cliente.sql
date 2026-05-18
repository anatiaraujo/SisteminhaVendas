-- Curva ABC por cliente

WITH BaseCliente as (
SELECT c.Nome, SUM (i.Qtde * i.PrecoUnitario) as ValorTotalPed
FROM Cliente as c
INNER JOIN	Pedido as p on p.ClienteId = c.ClienteId
INNER JOIN ItemPedido as i on i.PedidoId = p.PedidoId
GROUP BY c.Nome
),

Calculos as (
SELECT 
	Nome,
	ValorTotalPed, 
	SUM(ValorTotalPed) OVER () AS ValorTotal,
	(ValorTotalPed * 1.0 / SUM (ValorTotalPed) OVER()) *100 as Porc,
	SUM(ValorTotalPed) OVER (ORDER BY ValorTotalPed DESC) AS Acumulado,
	SUM(ValorTotalPed) OVER (ORDER BY ValorTotalPed DESC)/(SUM(ValorTotalPed) OVER ()) *100 as [Perc Acumulado]
FROM BaseCliente
)

SELECT 
	Nome,
	ValorTotalPed,
	Porc,
	[Perc Acumulado],
	CASE
		WHEN [Perc Acumulado] <= 80 THEN 'A'
		WHEN [Perc Acumulado] <= 95 THEN 'B'
	ELSE 'C'
	END as [Classificação ABC]
FROM Calculos
ORDER BY ValorTotalPed DESC;
