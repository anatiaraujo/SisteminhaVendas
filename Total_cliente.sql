
-- Calcular o total gasto por cliente 

SELECT c.Nome, SUM (i.Qtde * i.PrecoUnitario) as ValorTotal
FROM Cliente as c
INNER JOIN	Pedido as p on p.ClienteId = c.ClienteId
INNER JOIN ItemPedido as i on i.PedidoId = p.PedidoId
GROUP BY c.Nome
ORDER BY ValorTotal desc


