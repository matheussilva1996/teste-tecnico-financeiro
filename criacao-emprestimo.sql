-- criacao tabela CLIENTE

CREATE TABLE CLIENTE (
    Nome VARCHAR(50),
    CPF VARCHAR(11),
    UF VARCHAR(2),
    Celular VARCHAR(20)
);

-- cricao tabela TIPO FINANCIAMENTO 

CREATE TABLE TIPO_FINANCIAMENTO (
    ID INT PRIMARY KEY,
    Tipo VARCHAR(50)
);


-- criacao tabela financimento


CREATE TABLE FINANCIAMENTO (
  idFinanciamento INT PRIMARY KEY,
  CPF VARCHAR2(11),
  TipoFinanciamentoID INT,
  ValorTotal NUMBER(10, 2),
  DataUltimoVencimento DATE,
  FOREIGN KEY (TipoFinanciamentoID) REFERENCES TIPO_FINANCIAMENTO(ID)
);

CREATE SEQUENCE FINANCIAMENTO_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER FINANCIAMENTO_TRIGGER
BEFORE INSERT ON FINANCIAMENTO
FOR EACH ROW
BEGIN
  :NEW.idFinanciamento := FINANCIAMENTO_SEQ.NEXTVAL;
END;
/

-- criacao tabela N PARCELA

CREATE TABLE PARCELA (
    IdFinanciamento INT,
    NumeroParcela INT,
    ValorParcela DECIMAL(10, 2),
    DataVencimento DATE,
    DataPagamento DATE,
    FOREIGN KEY (IdFinanciamento) REFERENCES FINANCIAMENTO (IdFinanciamento)
);

-- Inserir clientes
INSERT INTO CLIENTE (Nome, CPF, UF, Celular) VALUES ('Cliente 1', '11111111111', 'SP', '1111111111');
INSERT INTO CLIENTE (Nome, CPF, UF, Celular) VALUES ('Cliente 2', '22222222222', 'RJ', '2222222222');
INSERT INTO CLIENTE (Nome, CPF, UF, Celular) VALUES ('Cliente 3', '33333333333', 'SP', '3333333333');
INSERT INTO CLIENTE (Nome, CPF, UF, Celular) VALUES ('Cliente 4', '44444444444', 'MG', '4444444444');
INSERT INTO CLIENTE (Nome, CPF, UF, Celular) VALUES ('Cliente 5', '55555555555', 'AM', '5555555555');

/*

CLIENTE:
NOME	    CPF	        UF	CELULAR
Cliente 1	11111111111	SP	1111111111
Cliente 2	22222222222	RJ	2222222222
Cliente 3	33333333333	SP	3333333333
Cliente 4	44444444444	MG	4444444444
Cliente 5	55555555555	AM	5555555555

*/

-- Inserir tipos de financiamento
INSERT INTO TIPO_FINANCIAMENTO (ID, Tipo) VALUES (1, 'DIRETO');
INSERT INTO TIPO_FINANCIAMENTO (ID, Tipo) VALUES  (2, 'CONSIGNADO');
INSERT INTO TIPO_FINANCIAMENTO (ID, Tipo) VALUES  (3, 'PESSOA JURIDICA');
INSERT INTO TIPO_FINANCIAMENTO (ID, Tipo) VALUES  (4, 'PESSOA FISICA');
INSERT INTO TIPO_FINANCIAMENTO (ID, Tipo) VALUES  (5, 'IMOBILIARIO');

/*

TIPO_FINANCIAMENTO:
ID	TIPO
1	DIRETO
2	CONSIGNADO
3	PESSOA JURIDICA
4	PESSOA FISICA
5	IMOBILIARIO

*/

-- Inserir financiamentos
INSERT INTO FINANCIAMENTO (IDFINANCIAMENTO,CPF, TipoFinanciamentoID, ValorTotal, DataUltimoVencimento) VALUES (1,'11111111111', 1, 10000.00, TO_DATE('2024-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO FINANCIAMENTO (IDFINANCIAMENTO,CPF, TipoFinanciamentoID, ValorTotal, DataUltimoVencimento) VALUES (2,'22222222222', 2, 20000.00,TO_DATE('2024-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO FINANCIAMENTO (IDFINANCIAMENTO,CPF, TipoFinanciamentoID, ValorTotal, DataUltimoVencimento) VALUES (3,'33333333333', 3, 30000.00, TO_DATE('2024-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO FINANCIAMENTO (IDFINANCIAMENTO,CPF, TipoFinanciamentoID, ValorTotal, DataUltimoVencimento) VALUES (4,'44444444444', 4, 40000.00, TO_DATE('2024-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO FINANCIAMENTO (IDFINANCIAMENTO,CPF, TipoFinanciamentoID, ValorTotal, DataUltimoVencimento) VALUES (5,'55555555555', 5, 50000.00, TO_DATE('2024-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO FINANCIAMENTO (IDFINANCIAMENTO,CPF, TipoFinanciamentoID, ValorTotal, DataUltimoVencimento) VALUES (6,'66666666666', 1, 60000.00, TO_DATE('2024-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));


/*

IDFINANCIAMENTO	CPF	        TIPOFINANCIAMENTOID	VALORTOTAL	DATAULTIMOVENCIMENTO
1	            11111111111	1	                10000	    01-JUN-24
2	            22222222222	2	                20000	    01-JUN-24
3	            33333333333	3	                30000	    01-JUN-24
4	            44444444444	4	                40000	    01-JUN-24
5	            55555555555	5	                50000	    01-JUN-24
6	            66666666666	1	                60000	    01-JUN-24

*/

-- Inserir parcelas
-- Cliente 1
INSERT INTO PARCELA (IdFinanciamento, NumeroParcela, ValorParcela, DataVencimento, DataPagamento)
SELECT
    f.IdFinanciamento,
    p.Numero,
    p.ValorParcela,
    p.DataVencimento,
    CASE
        WHEN p.Numero <= 9 THEN p.DataVencimento - INTERVAL '1' DAY
        ELSE NULL
    END
FROM
    FINANCIAMENTO f
    CROSS JOIN (
        SELECT 1 AS Numero, 1000.00 AS ValorParcela, TO_DATE('2023-07-01', 'YYYY-MM-DD') AS DataVencimento FROM DUAL
        UNION ALL SELECT 2, 1000.00, TO_DATE('2023-08-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 3, 1000.00, TO_DATE('2023-09-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 4, 1000.00, TO_DATE('2023-10-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 5, 1000.00, TO_DATE('2023-11-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 6, 1000.00, TO_DATE('2023-12-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 7, 1000.00, TO_DATE('2024-01-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 8, 1000.00, TO_DATE('2024-02-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 9, 1000.00, TO_DATE('2024-03-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 10, 1000.00, TO_DATE('2024-04-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 11, 1000.00, TO_DATE('2024-05-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 12, 1000.00, TO_DATE('2024-06-01', 'YYYY-MM-DD') FROM DUAL
    ) p
WHERE
    f.CPF = '11111111111';


-- Cliente 2
INSERT INTO PARCELA (IdFinanciamento, NumeroParcela, ValorParcela, DataVencimento, DataPagamento)
SELECT
    f.IdFinanciamento,
    p.Numero,
    p.ValorParcela,
    p.DataVencimento,
    NULL
FROM
    FINANCIAMENTO f
    CROSS JOIN (
        SELECT 1 AS Numero, 2000.00 AS ValorParcela, TO_DATE('2023-07-01', 'YYYY-MM-DD') AS DataVencimento FROM DUAL
        UNION ALL SELECT 2, 2000.00, TO_DATE('2023-08-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 3, 2000.00, TO_DATE('2023-09-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 4, 2000.00, TO_DATE('2023-10-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 5, 2000.00, TO_DATE('2023-11-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 6, 2000.00, TO_DATE('2023-12-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 7, 2000.00, TO_DATE('2024-01-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 8, 2000.00, TO_DATE('2024-02-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 9, 2000.00, TO_DATE('2024-03-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 10, 2000.00, TO_DATE('2024-04-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 11, 2000.00, TO_DATE('2024-05-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 12, 2000.00, TO_DATE('2024-06-01', 'YYYY-MM-DD') FROM DUAL
    ) p
WHERE
    f.CPF = '22222222222';


-- Cliente 3
INSERT INTO PARCELA (IdFinanciamento, NumeroParcela, ValorParcela, DataVencimento, DataPagamento)
SELECT
    f.IdFinanciamento,
    p.Numero,
    p.ValorParcela,
    p.DataVencimento,
    CASE
        WHEN p.Numero <= 7 THEN p.DataVencimento - INTERVAL '1' DAY
        ELSE NULL
    END
FROM
    FINANCIAMENTO f
    CROSS JOIN (
        SELECT 1 AS Numero, 3000.00 AS ValorParcela, TO_DATE('2023-07-01', 'YYYY-MM-DD') AS DataVencimento FROM DUAL
        UNION ALL SELECT 2, 3000.00, TO_DATE('2023-08-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 3, 3000.00, TO_DATE('2023-09-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 4, 3000.00, TO_DATE('2023-10-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 5, 3000.00, TO_DATE('2023-11-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 6, 3000.00, TO_DATE('2023-12-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 7, 3000.00, TO_DATE('2024-01-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 8, 3000.00, TO_DATE('2024-02-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 9, 3000.00, TO_DATE('2024-03-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 10, 3000.00, TO_DATE('2024-04-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 11, 3000.00, TO_DATE('2024-05-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 12, 3000.00, TO_DATE('2024-06-01', 'YYYY-MM-DD') FROM DUAL
    ) p
WHERE
    f.CPF = '33333333333';


-- Cliente 4
INSERT INTO PARCELA (IdFinanciamento, NumeroParcela, ValorParcela, DataVencimento, DataPagamento)
SELECT
    f.IdFinanciamento,
    p.Numero,
    p.ValorParcela,
    p.DataVencimento,
    CASE
        WHEN p.Numero = 1 THEN p.DataVencimento + INTERVAL '5' DAY
        ELSE NULL
    END
FROM
    FINANCIAMENTO f
    CROSS JOIN (
        SELECT 1 AS Numero, 4000.00 AS ValorParcela, TO_DATE('2023-07-01', 'YYYY-MM-DD') AS DataVencimento FROM DUAL
        UNION ALL SELECT 2, 4000.00, TO_DATE('2023-08-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 3, 4000.00, TO_DATE('2023-09-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 4, 4000.00, TO_DATE('2023-10-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 5, 4000.00, TO_DATE('2023-11-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 6, 4000.00, TO_DATE('2023-12-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 7, 4000.00, TO_DATE('2024-01-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 8, 4000.00, TO_DATE('2024-02-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 9, 4000.00, TO_DATE('2024-03-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 10, 4000.00, TO_DATE('2024-04-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 11, 4000.00, TO_DATE('2024-05-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 12, 4000.00, TO_DATE('2024-06-01', 'YYYY-MM-DD') FROM DUAL
    ) p
WHERE
    f.CPF = '44444444444';

-- Cliente 5
INSERT INTO PARCELA (IdFinanciamento, NumeroParcela, ValorParcela, DataVencimento, DataPagamento)
SELECT
    f.IdFinanciamento,
    p.Numero,
    p.ValorParcela,
    p.DataVencimento,
    CASE
        WHEN p.Numero <= 9 THEN p.DataVencimento - INTERVAL '1' DAY
        ELSE NULL
    END
FROM
    FINANCIAMENTO f
    CROSS JOIN (
        SELECT 1 AS Numero, 5000.00 AS ValorParcela, TO_DATE('2023-07-01', 'YYYY-MM-DD') AS DataVencimento FROM DUAL
        UNION ALL SELECT 2, 5000.00, TO_DATE('2023-08-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 3, 5000.00, TO_DATE('2023-09-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 4, 5000.00, TO_DATE('2023-10-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 5, 5000.00, TO_DATE('2023-11-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 6, 5000.00, TO_DATE('2023-12-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 7, 5000.00, TO_DATE('2024-01-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 8, 5000.00, TO_DATE('2024-02-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 9, 5000.00, TO_DATE('2024-03-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 10, 5000.00, TO_DATE('2024-04-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 11, 5000.00, TO_DATE('2024-05-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 12, 5000.00, TO_DATE('2024-06-01', 'YYYY-MM-DD') FROM DUAL
    ) p
WHERE
    f.CPF = '55555555555';


-- Cliente 6
INSERT INTO PARCELA (IdFinanciamento, NumeroParcela, ValorParcela, DataVencimento, DataPagamento)
SELECT
    f.IdFinanciamento,
    p.Numero,
    p.ValorParcela,
    p.DataVencimento,
    CASE
        WHEN p.Numero <= 7 THEN p.DataVencimento - INTERVAL '1' DAY
        ELSE NULL
    END
FROM
    FINANCIAMENTO f
    CROSS JOIN (
        SELECT 1 AS Numero, 6000.00 AS ValorParcela, TO_DATE('2023-07-01', 'YYYY-MM-DD') AS DataVencimento FROM DUAL
        UNION ALL SELECT 2, 6000.00, TO_DATE('2023-08-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 3, 6000.00, TO_DATE('2023-09-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 4, 6000.00, TO_DATE('2023-10-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 5, 6000.00, TO_DATE('2023-11-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 6, 6000.00, TO_DATE('2023-12-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 7, 6000.00, TO_DATE('2024-01-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 8, 6000.00, TO_DATE('2024-02-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 9, 6000.00, TO_DATE('2024-03-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 10, 6000.00, TO_DATE('2024-04-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 11, 6000.00, TO_DATE('2024-05-01', 'YYYY-MM-DD') FROM DUAL
        UNION ALL SELECT 12, 6000.00, TO_DATE('2024-06-01', 'YYYY-MM-DD') FROM DUAL
    ) p
WHERE
    f.CPF = '66666666666';

/*

IDFINANCIAMENTO	NUMEROPARCELA	VALORPARCELA	DATAVENCIMENTO	DATAPAGAMENTO
1	            1	            1000	        01-JUL-23	    30-JUN-23
1	            2	            1000	        01-AUG-23	    31-JUL-23
1	            3	            1000	        01-SEP-23	    31-AUG-23
1	            4	            1000	        01-OCT-23	    30-SEP-23
1	            5	            1000	        01-NOV-23	    31-OCT-23
1	            6	            1000	        01-DEC-23	    30-NOV-23
1	            7	            1000	        01-JAN-24	    31-DEC-23
1	            8	            1000	        01-FEB-24	    15-JAN-24 
1	            9	            1000	        01-MAR-24	     - 
1	            10	            1000	        01-APR-24	     - 
1	            11	            1000	        01-MAY-24	     - 
1	            12	            1000	        01-JUN-24	     - 
2	            1	            2000	        01-JUL-23	     - 
2	            2	            2000	        01-AUG-23	     - 
2	            3	            2000	        01-SEP-23	     - 
2	            4	            2000	        01-OCT-23	     - 
2	            5	            2000	        01-NOV-23	     - 
2	            6	            2000	        01-DEC-23	     - 
2	            7	            2000	        01-JAN-24	     - 
2	            8	            2000	        01-FEB-24	     - 
2	            9	            2000	        01-MAR-24	     - 
2	            10	            2000	        01-APR-24	     - 
2	            11	            2000	        01-MAY-24	     - 
2	            12	            2000	        01-JUN-24	     - 
3	            1	            3000	        01-JUL-23	    30-JUN-23
3	            2	            3000	        01-AUG-23	    31-JUL-23
3	            3	            3000	        01-SEP-23	    31-AUG-23
3	            4	            3000	        01-OCT-23	    30-SEP-23
3	            5	            3000	        01-NOV-23	    31-OCT-23
3	            6	            3000	        01-DEC-23	    30-NOV-23
3	            7	            3000	        01-JAN-24	    31-DEC-23
3	            8	            3000	        01-FEB-24	     - 
3	            9	            3000	        01-MAR-24	     - 
3	            10	            3000	        01-APR-24	     - 
3	            11	            3000	        01-MAY-24	     - 
3	            12	            3000	        01-JUN-24	     - 
4	            1	            4000	        01-JUL-23	    06-JUL-23
4	            2	            4000	        01-AUG-23	     - 
4	            3	            4000	        01-SEP-23	     - 
4	            4	            4000	        01-OCT-23	     - 
4	            5	            4000	        01-NOV-23	     - 
4	            6	            4000	        01-DEC-23	     - 
4	            7	            4000	        01-JAN-24	     - 
4	            8	            4000	        01-FEB-24	     - 
4	            9	            4000	        01-MAR-24	     - 
4	            10	            4000	        01-APR-24	     - 
4	            11	            4000	        01-MAY-24	     - 
4	            12	            4000	        01-JUN-24	     - 
5	            1	            5000	        01-JUL-23	    30-JUN-23
5	            2	            5000	        01-AUG-23	    31-JUL-23
5	            3	            5000	        01-SEP-23	    31-AUG-23
5	            4	            5000	        01-OCT-23	    30-SEP-23
5	            5	            5000	        01-NOV-23	    31-OCT-23
5	            6	            5000	        01-DEC-23	    30-NOV-23
5	            7	            5000	        01-JAN-24	    31-DEC-23
5	            8	            5000	        01-FEB-24	     - 
5	            9	            5000	        01-MAR-24	     - 
5	            10	            5000	        01-APR-24	     - 
5	            11	            5000	        01-MAY-24	     - 
5	            12	            5000	        01-JUN-24	     - 
6	            1	            6000	        01-JUL-23	    30-JUN-23
6	            2	            6000	        01-AUG-23	    31-JUL-23
6	            3	            6000	        01-SEP-23	    31-AUG-23
6	            4	            6000	        01-OCT-23	    30-SEP-23
6	            5	            6000	        01-NOV-23	    31-OCT-23
6	            6	            6000	        01-DEC-23	    30-NOV-23
6	            7	            6000	        01-JAN-24	    31-DEC-23
6	            8	            6000	        01-FEB-24	     - 
6	            9	            6000	        01-MAR-24	     - 
6	            10	            6000	        01-APR-24	     - 
6	            11	            6000	        01-MAY-24	     - 
6	            12	            6000	        01-JUN-24	     - 
*/

-- query busca pessoas que ja pagaram 60% das parcelas no estado de SP

SELECT c.Nome, c.CPF
FROM CLIENTE c
INNER JOIN FINANCIAMENTO 	f ON c.CPF = f.CPF
LEFT JOIN PARCELA 			p ON f.IdFinanciamento = p.IdFinanciamento
WHERE c.UF = 'SP'
GROUP BY c.Nome, c.CPF
HAVING COUNT(p.IdFinanciamento) > 0 AND SUM(CASE WHEN p.DataPagamento IS NOT NULL THEN 1 ELSE 0 END) / COUNT(p.IdFinanciamento) > 0.6;

/*
NOME	    CPF
Cliente 1	11111111111
*/


-- query de busca dos 4 primeiros clientes que possuem alguma parcela com mais de cinco dia sem atraso (Data Vencimento maior que data atual E data pagamento nula).

SELECT c.Nome, c.CPF
FROM CLIENTE c
INNER JOIN FINANCIAMENTO 		f ON c.CPF = f.CPF
INNER JOIN PARCELA 				p ON f.IdFinanciamento = p.IdFinanciamento
WHERE p.DataVencimento > SYSDATE AND p.DataPagamento IS NULL
GROUP BY c.Nome, c.CPF
FETCH FIRST 4 ROWS ONLY;

/*
NOME	    CPF
Cliente 1	11111111111
Cliente 2	22222222222
Cliente 3	33333333333
Cliente 4	44444444444
*/