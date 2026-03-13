/*
    2.	Implemente uma consulta para listar o total/quantidade de serviços cadastrados.
*/
SELECT 
    COUNT(*) AS `QUANTIDADE DE SERVIÇOS DISPONIVEIS` 
FROM Servico;

/* 
    3.	Implemente uma consulta para listar a data de abertura, o equipamento e a prioridade 
    de todas as ordens de serviço cujo estado seja “Aberta”. A lista obtida deve ser mostrada 
    em ordem crescente pela data de abertura.

    Regra: Listar data de abertura, equipamento e prioridade em ordem crescente pela data.
*/
SELECT 
    DATE_FORMAT(dataAbertura, '%d/%m/%Y') AS `DATA DE ABERTURA`, 
    UPPER(equipamento) AS EQUIPAMENTO, 
    UPPER(prioridade) AS PRIORIDADE
FROM OrdemServico
WHERE estado = 'Aberta'
ORDER BY dataAbertura ASC;

-- ou

CREATE OR REPLACE VIEW `view_ordemservico_resumo` AS
SELECT
    ordem.idOrdem AS ORDEM,
    ordem.dataAbertura AS `DATA DE ABERTURA ISO`,
    DATE_FORMAT(ordem.dataAbertura, '%d/%m/%Y') AS `DATA DE ABERTURA`,
    UPPER(ordem.equipamento) AS EQUIPAMENTO,
    UPPER(ordem.prioridade) AS PRIORIDADE,
    ordem.estado AS ESTADO
FROM OrdemServico AS ordem;

DROP PROCEDURE IF EXISTS `procedure_listar_os_por_estado`;
DELIMITER $$
CREATE PROCEDURE `procedure_listar_os_por_estado` (IN _estado VARCHAR(20))
BEGIN
    -- Quando _estado for NULL ou vazio, lista tudo; caso contrário, filtra pelo estado
    IF _estado IS NULL OR TRIM(_estado) = '' THEN
        SELECT
            view_ordem.`DATA DE ABERTURA`,
            view_ordem.EQUIPAMENTO,
            view_ordem.PRIORIDADE
        FROM `view_ordemservico_resumo` AS view_ordem
        ORDER BY view_ordem.`DATA DE ABERTURA ISO` ASC;
    ELSE
        SELECT
            view_ordem.`DATA DE ABERTURA`,
            view_ordem.EQUIPAMENTO,
            view_ordem.PRIORIDADE
        FROM `view_ordemservico_resumo` AS view_ordem
        WHERE view_ordem.ESTADO = _estado
        ORDER BY view_ordem.`DATA DE ABERTURA ISO` ASC;
    END IF;
END$$
DELIMITER ;

CALL `procedure_listar_os_por_estado`('Aberta');

/*
    4.	Implemente uma consulta para listar os serviços executados em cada ordem de serviço. 
    A lista deve retornar à identificação da ordem de serviço, a descrição do serviço, a quantidade, 
    o valor unitário e o subtotal (quantidade x valor unitário). A lista obtida deve ser mostrada em 
    ordem crescente pela identificação da ordem de serviço.

    Regra: Retornar ID da ordem, descrição, quantidade, valor unitário e subtotal, em ordem crescente 
    pelo ID da ordem.
*/
SELECT 
    ordem_servico.idOrdem AS ORDEM, 
    servico.descricao AS `DESCRIÇÃO`, 
    ordem_servico.quantidade AS QUANTIDADE, 
    ordem_servico.valorUnitario AS `VALOR UNITÁRIO (R$)`, 
    (ordem_servico.quantidade * ordem_servico.valorUnitario) AS `SUBTOTAL (R$)`
FROM OrdemServico_Servico AS ordem_servico
JOIN Servico AS servico 
    ON ordem_servico.idServico = servico.idServico
ORDER BY ORDEM ASC;

-- ou 

CREATE OR REPLACE VIEW `view_itens_ordemservico` AS
SELECT 
    ordem_servico.idOrdem AS ORDEM, 
    servico.descricao AS `DESCRIÇÃO`, 
    ordem_servico.quantidade AS QUANTIDADE, 
    ordem_servico.valorUnitario AS `VALOR UNITÁRIO (R$)`, 
    (ordem_servico.quantidade * ordem_servico.valorUnitario) AS `SUBTOTAL (R$)`
FROM OrdemServico_Servico AS ordem_servico
JOIN Servico AS servico 
    ON ordem_servico.idServico = servico.idServico;

SELECT * 
FROM `view_itens_ordemservico`
ORDER BY ORDEM ASC;

/*
    5.	Implemente uma consulta para listar a identificação de cada ordem de serviço e seu total, 
    isto é, a soma de todos os subtotais de seus serviços executados, sendo que cada subtotal 
    é a (quantidade x valor unitário). Os resultados devem ser mostrados em ordem decrescente do valor total.

    Dica: Utilize a cláusula group by.
    
    Regra: Soma dos subtotais agrupada por ordem, em ordem decrescente do valor total.
*/
SELECT 
    idOrdem AS ORDEM, 
    SUM(quantidade * valorUnitario) AS `VALOR TOTAL (R$)`
FROM OrdemServico_Servico
GROUP BY ORDEM
ORDER BY `VALOR TOTAL (R$)` DESC;

-- ou

CREATE OR REPLACE VIEW `view_total_por_ordemservico` AS
SELECT
    ordem_servico.idOrdem AS ORDEM,
    SUM(ordem_servico.quantidade * ordem_servico.valorUnitario) AS `VALOR TOTAL (R$)`
FROM `OrdemServico_Servico` AS ordem_servico
GROUP BY ORDEM;

SELECT *
FROM `view_total_por_ordemservico`
ORDER BY `VALOR TOTAL (R$)` DESC;
