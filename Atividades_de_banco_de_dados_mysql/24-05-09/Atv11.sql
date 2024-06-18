/*
90. Criar uma trigger de “Insert” para a tabela "Movimentacao" chamada “tr_AtualizaEstoque_I”
	  Quando for incluida uma nova linha na tabela “Movimentacao”
      Se Movimentacao.Tipo ='E'(entrada)
   Então 
     Somar a Movimentacao.QtdeMov em Produto.QtdeProduto
    Senão
     Se Movimentacao.Tipo ='S' (saída)
           Subtrair a Movimentacao.QtdeMov em Produto.QtdeProduto
*/

CREATE TRIGGER tr_AtualizaEstoque_I
ON Movimentacao
AFTER INSERT
AS
BEGIN
    UPDATE Produto
    SET QtdeProduto = 
        CASE 
            WHEN (SELECT TipoMov FROM inserted) = 'E' THEN (SELECT QtdeMov FROM inserted) + Produto.QtdeProduto
            WHEN (SELECT TipoMov FROM inserted) = 'S' THEN Produto.QtdeProduto - (SELECT QtdeMov FROM inserted)
        END
    FROM Produto
    INNER JOIN inserted ON Produto.IDProduto = inserted.IDProduto;
END;



/*
91. Alterar a trigger (“tr_AtualizaEstoque_I”) criada no exercício anterior. Acrescentar a seguinte regra:
Se  ( Produto.PrecoUnitMinProduto > Movimentacao.PrecoUnitMov )
Então
     Produto.PrecoUnitMinProduto = Movimentacao.PrecoUnitMov
Se  ( Produto.PrecoUnitMaxProduto < Movimentacao.PrecoUnitMov )
Então
           Produto.PrecoUnitMaxProduto = Movimentacao.PrecoUnitMov
Calcular 
     Produto.PrecoUnitMedProduto = (Produto.PrecoUnitMinProduto + Produto.PrecoUnitMaxProduto)/2 
*/
ALTER TRIGGER tr_AtualizaEstoque_I
ON Movimentacao
AFTER INSERT
AS
BEGIN
    UPDATE Produto
    SET 
        QtdeProduto = QtdeProduto + 
            CASE WHEN (SELECT TipoMov FROM inserted) = 'E' THEN (SELECT QtdeMov FROM inserted) ELSE -(SELECT QtdeMov FROM inserted) END,
        PrecoUnitMinProduto = CASE WHEN PrecoUnitMinProduto > (SELECT PrecoUnitMov FROM inserted) THEN (SELECT PrecoUnitMov FROM inserted) ELSE PrecoUnitMinProduto END,
        PrecoUnitMaxProduto = CASE WHEN PrecoUnitMaxProduto < (SELECT PrecoUnitMov FROM inserted) THEN (SELECT PrecoUnitMov FROM inserted) ELSE PrecoUnitMaxProduto END,
        PrecoUnitMedProduto = (PrecoUnitMinProduto + PrecoUnitMaxProduto) / 2.0
    WHERE IDProduto IN (SELECT IDProduto FROM inserted);
END;

/*
92. Criar uma trigger de “Delete” para a tabela "Movimentacao" chamada “tr_AtualizaEstoque_D”
–      Quando for excluida uma linha na tabela “Movimentacao”
•       Se Movimentacao.Tipo ='E'(entrada)
   Então 
     Subtrair a Movimentacao.QtdeMov em Produto.QtdeProduto
    Senão
     Se Movimentacao.Tipo ='S' (saída)
           Somar a Movimentacao.QtdeMov em Produto.QtdeProduto
*/
CREATE TRIGGER tr_AtualizaEstoque_D
ON Movimentacao
AFTER DELETE
AS
BEGIN
    UPDATE Produto
    SET QtdeProduto = 
        CASE 
            WHEN 'E' IN (SELECT TipoMov FROM deleted) THEN QtdeProduto - (SELECT QtdeMov FROM deleted WHERE TipoMov = 'E')
            WHEN 'S' IN (SELECT TipoMov FROM deleted) THEN QtdeProduto + (SELECT QtdeMov FROM deleted WHERE TipoMov = 'S')
        END
    WHERE IDProduto IN (SELECT IDProduto FROM deleted);
END;


/*
93. Criar uma trigger de “Update” para a tabela "Movimentacao" chamada “tr_AtualizaEstoque_U”
–      Quando for excluida uma linha na tabela “Movimentacao”
•       Se Movimentacao.Tipo ='E'(entrada)
   Então 
     Subtrair a antiga Movimentacao.QtdeMov em Produto.QtdeProduto
     Somar a nova Movimentacao.QtdeMov em Produto.QtdeProduto
    Senão
     Se Movimentacao.Tipo ='S' (saída)
           Somar a antiga Movimentacao.QtdeMov antiga em Produto.QtdeProduto
           Subtrair a nova Movimentacao.QtdeMov em Produto.QtdeProduto
*/
CREATE TRIGGER tr_AtualizaEstoque_U
ON Movimentacao
AFTER UPDATE
AS
BEGIN
    UPDATE Produto
    SET QtdeProduto = 
        CASE 
            WHEN 'E' IN (SELECT TipoMov FROM deleted) THEN
                QtdeProduto - (SELECT QtdeMov FROM deleted WHERE TipoMov = 'E') + (SELECT QtdeMov FROM inserted WHERE TipoMov = 'E')
            WHEN 'S' IN (SELECT TipoMov FROM deleted) THEN
                QtdeProduto + (SELECT QtdeMov FROM deleted WHERE TipoMov = 'S') - (SELECT QtdeMov FROM inserted WHERE TipoMov = 'S')
        END
    WHERE IDProduto IN (SELECT IDProduto FROM deleted);
END;

