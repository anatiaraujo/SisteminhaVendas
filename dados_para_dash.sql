-- Consulta para dashboard com Ticket Médio, Percentual e qtde de clientes por Classe

WITH BaseCliente as (
SELECT c.Nome, SUM (i.Qtde * i.PrecoUnitario) as ValorTotal,
	CASE 
		WHEN SUM (i.Qtde * i.PrecoUnitario) >= 2000 THEN 'VIP'
		WHEN SUM (i.Qtde * i.PrecoUnitario) >= 500 THEN 'Regular'
		ELSE 'Basic'
		END AS ClasseCliente
FROM Cliente as c
INNER JOIN	Pedido as p on p.ClienteId = c.ClienteId
INNER JOIN ItemPedido as i on i.PedidoId = p.PedidoId
GROUP BY c.Nome
)

SELECT 
	ClasseCliente,
	COUNT (*) AS Qtde,
	COUNT (*) * 100 / SUM(COUNT(*)) OVER () AS Perc,
	AVG(ValorTotal) as TicketMedio
FROM BaseCliente
GROUP BY ClasseCliente

