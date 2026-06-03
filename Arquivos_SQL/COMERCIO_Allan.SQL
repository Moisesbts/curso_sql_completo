--COMÉRCIO

CREATE DATABASE COMERCIO;

USE COMERCIO;

CREATE TABLE CLIENTE(
	IDCLIENTE INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	SEXO ENUM('M','F') NOT NULL,
	EMAIL VARCHAR(50) UNIQUE,
	CPF VARCHAR(15) UNIQUE
);

CREATE TABLE ENDERECO(
	ID_ENDERECO INT PRIMARY KEY AUTO_INCREMENT,
	RUA VARCHAR(30) NOT NULL,
	NUMERO VARCHAR(4) NOT NULL,
	BAIRRO VARCHAR(30) NOT NULL,
	CIDADE VARCHAR(30) NOT NULL,
	ESTADO CHAR(2) NOT NULL,
	ID_CLIENTE INT UNIQUE,
	FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(IDCLIENTE)
	
	
);

CREATE TABLE TELEFONE (
	ID_TELEFONE INT PRIMARY KEY AUTO_INCREMENT,
	TIPO ENUM('RES','COM','CEL') NOT NULL,
	NUMERO VARCHAR(15) NOT NULL,
	ID_CLIENTE INT,
	FOREIGN KEY (ID_CLIENTE) 
	REFERENCES CLIENTE(IDCLIENTE)

);

/* ENDEREÇO É OBRIGATÓRIO - 
CADASTRO DE SOMENTE UM.

TELEFONE - NÃO OBRIGATÓRIO
CADASTRO DE MAIS DE UM (OPCIONAL)

*/

/* CHAE ESTRANGEIRA É A CHAVE PRIMARIA DE UMA TABELA 
QUE VAI ATÉ A OUTRA TABELA PARA FAZER REFERENCIA ENTRE 
REGISTROS
*/

/* EM RELACIONAMENTOS 1 X 1 A CHAVE ESTRANGEIRA FICA NA TABELA MAIS FRACA */

/* EM RELACIONAMENTO 1 X N A CHAVE ESTRANGEIRA FICARÁ SEMPRE NA CARDINALIDADE "N" */

--APAGAR TABELA:

DROP TABLE CLIENTE;
DROP TABLE ENDERECO;
DROP TABLE TELEFONE;

INSERT INTO CLIENTE VALUES(NULL, 'JOAO','M','JOAO@IG.COM','1234567890');
INSERT INTO CLIENTE VALUES(NULL, 'CARLOS','M','CARLOS@IG.COM','1234557890');
INSERT INTO CLIENTE VALUES(NULL, 'ANA','F','ANA@IG.COM','0987654321');
INSERT INTO CLIENTE VALUES(NULL, 'CLARA','F',NULL,'4567891235');
INSERT INTO CLIENTE VALUES(NULL, 'JORGE','M','JORGE@IG.COM','4561230789');
INSERT INTO CLIENTE VALUES(NULL, 'CELIA','F','CELIA@IG.COM','1237894569');

select * from cliente;

+-----------+--------+------+---------------+------------+
| IDCLIENTE | NOME   | SEXO | EMAIL         | CPF        |
+-----------+--------+------+---------------+------------+
|         1 | JOAO   | M    | JOAO@IG.COM   | 1234567890 |
|         2 | CARLOS | M    | CARLOS@IG.COM | 1234557890 |
|         3 | ANA    | F    | ANA@IG.COM    | 0987654321 |
|         4 | CLARA  | F    | NULL          | 4567891235 |
|         5 | JORGE  | M    | JORGE@IG.COM  | 4561230789 |
|         6 | CELIA  | F    | CELIA@IG.COM  | 1237894569 |
+-----------+--------+------+---------------+------------+

DESC ENDERECO;

INSERT INTO ENDERECO VALUES(NULL,'RUA ANTONIO SÁ','100','CENTRO','BELO HORIZONTE','MG',4);
INSERT INTO ENDERECO VALUES(NULL,'RUA CAPITÃO HERMES','198','CENTRO','RIO DE JANEIRO','RJ',1);
INSERT INTO ENDERECO VALUES(NULL,'RUA PRESIDENTE VARGAS','100','JARDINS','SÃO PAULO','SP',3);
INSERT INTO ENDERECO VALUES(NULL,'RUA ALFANDEGA','100','ESTÁCIO','RIO DE JANEIRO','RJ',2);
INSERT INTO ENDERECO VALUES(NULL,'RUA CAPITÃO SALSISHA','100','FLAMENGO','RIO DE JANEIRO','RJ',6);
INSERT INTO ENDERECO VALUES(NULL,'RUA URUGUAIANA','100','CENTRO','VITÓRIA','ES',5);

INSERT INTO ENDERECO VALUES(NULL,'RUA ALFANDEGA','100','CENTRO','SÃO PAULO','SP',5); --NÃO PERMITE, POIS A CHAVE 'ID_CLIENTE' É UNIQUE


INSERT INTO TELEFONE VALUES(NULL,'CEL','16992961260',5);
INSERT INTO TELEFONE VALUES(NULL,'RES','16992961260',2);
INSERT INTO TELEFONE VALUES(NULL,'CEL','16992943260',4);
INSERT INTO TELEFONE VALUES(NULL,'COM','16992957260',5);
INSERT INTO TELEFONE VALUES(NULL,'CEL','11992961260',1);
INSERT INTO TELEFONE VALUES(NULL,'RES','16992961260',1);
INSERT INTO TELEFONE VALUES(NULL,'COM','16992926760',3);
INSERT INTO TELEFONE VALUES(NULL,'RES','16992234660',6);

/*SELEÇÃO, PROJEÇÃO E JUNÇÃO */

-- PROJEÇÃO: TUDO QUE VOCê QUER VER NA TELA 

SELECT NOW() AS DATA_ATUAL; 
-- EXIBE A DATA E HORA ATUAL RENOMEANDO A COLUNA COM "DATA_ATUAL";

SELECT 2+2 AS SOMA; 
-- EXIBE O RESULTADO DA SOMA E RENOMEITA A TABELA COMO "SOMA"

SELECT 2+2 AS SOMA, NOME, NOW() FROM CLIENTE; 
-- EXIBE A SOMA, E AS COLUNAS NOME (DA TABELA CLIENTE), E A DATA E HORA ATUAIS;

/* SELEÇÃO -> É UM SUBCONJUNTO DO CONJUNTO TOTAL DE REGISTROS DE UMA TABELA
A CLAUSULA DE SELEÇÃO É O "WHERE" */

SELECT NOME, SEXO EMAIL
FROM CLIENTE 
WHERE SEXO = "F";
-- PROJETA AS COLUNAS "NOME, SEXO E e-MAIL" DA TABELA CLIENTE COM A CONDIÇÃO "F" NO SEXO (TODAS AS MULHERES)

SELECT NUMERO
FROM TELEFONE 
WHERE TIPO = "CEL";
-- PROJETA A COLUNA DOS NUMERO DE TELEFONE COM A CONDIÇÃO "TIPO" SENDO CELULAR;


/* JUNÇÃO -> JOIN */


SELECT NOME, EMAIL, IDCLIENTE 
FROM CLIENTE;

SELECT ID_CLIENTE, BAIRO, CIDADE
FROM ENDERECO;

SELECT NOME, SEXO, BAIRO, CIDADE
FROM CLIENTE, ENDERECO 
WHERE IDCLIENTE = ID_CLIENTE;
-- PROJETA DAS DUAS TABELAS, PORÉM NÃO É UMA BOA PRÁTICA UTILIZAR DESSA MANEIRA

SELECT NOME, SEXO, BAIRO, CIDADE
FROM CLIENTE, ENDERECO 
WHERE IDCLIENTE = ID_CLIENTE
AND SEXO = "F";
-- PROJETA DAS DUAS TABELAS, PORÉM NÃO É UMA BOA PRÁTICA UTILIZAR DESSA MANEIRA

SELECT NOME, SEXO, BAIRRO, CIDADE
FROM CLIENTE 
INNER JOIN  ENDERECO 
ON IDCLIENTE = ID_CLIENTE;

-- PROJETA NOME SEXO, BAIRRO E CIDADE JÁ UTILIZANDO AS REGRAS DO JOIN


SELECT NOME, SEXO, EMAIL, TIPO, NUMERO
FROM CLIENTE
INNER JOIN	TELEFONE 
ON IDCLIENTE = ID_CLIENTE;
-- PROJETA NOME, SEXO, EMAIL, TIPO E NUMERO UTLIZANDO JOIN ENTRE AS TABELAS "CLIENTE" E "TELEFONE"

/* NOME, SEXO, BAIRRO, CIDADE, TIPO, NUMERO */

-- METODO 1

SELECT CLIENTE.NOME, CLIENTE.SEXO, ENDERECO.BAIRRO, ENDERECO.CIDADE,ENDERECO.NUMERO, TELEFONE.TIPO, TELEFONE.NUMERO
FROM CLIENTE 
INNER JOIN ENDERECO 
ON CLIENTE.IDCLIENTE = ENDERECO.ID_CLIENTE
INNER JOIN TELEFONE 
ON CLIENTE.IDCLIENTE = TELEFONE.ID_CLIENTE;

-- METODO 2

SELECT C.NOME, C.SEXO, E.BAIRRO, E.CIDADE,E.NUMERO, T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E -- SÃO INSERIDAS "ARIAS" OU PONTEIRAMENTOS PARA DEIXAR A QUERY MAIS ORGANIZADA. INSERE-SE UMA LETRA
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;


/*

DML - DATA MANIPULATION LANGUAGE
DDL - DATA DEFINITION LANGUAGE
DCL - DATA CONTROL LANGUAGE
TCL - TRANSACTION CONTROL LANGUAGE

*/

-- DML - DATA MANIPULATION LANGUAGE

/* INSERT */

INSERT INTO CLIENTE VALUES(NULL, "PAULA", "M", NULL, "77458565"); 
INSERT INTO ENDERECO VALUES(NULL, "RUA JOAQUIM SILVA","55" ,"ALVORADA", "NITEROI", "RJ",7);

SELECT * FROM CLIENTE;

/* FILTROS */


SELECT * FROM CLIENTE
WHERE SEXO = "M";

/* UPDATE */

-- CONFIRMAR SE É O CADASTRO CERTO À SER ATUALIZADO
SELECT * FROM CLIENTE
WHERE IDCLIENTE = 8;

UPDATE CLIENTE
	SET SEXO = "F"
	WHERE IDCLIENTE = 7;

/* DELETE */

INSERT INTO CLIENTE VALUES (NULL, "XXX", "M",NULL, "XXX" );

DELETE FROM CLIENTE 
	WHERE IDCLIENTE = 8;


-- DDL - DATA DEFINITION LANGUAGE

CREATE TABLE PRODUTO(
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
	NOME_PRODUTO VARCHAR(30) NOT NULL,
	PRECO INT,
	FRETE FLOAT(10,2) NOT NULL
	);

/* ALTER TABLE */



/* ALTERANDO O NOME DE UMA COLUNA - CHANCE */

ALTER TABLE PRODUTO
CHANGE PRECO VALOR_UNITARIO INT NOT NULL;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | int(11)     | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

ALTER TABLE PRODUTO
CHANGE VALOR_UNITARIO VALOR_UNITARIO INT ;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | int(11)     | YES  |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

/* MODIFY */


ALTER TABLE PRODUTO
MODIFY VALOR_UNITARIO VARCHAR(50) NOT NULL;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | varchar(50) | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+


/* ADICIONANDO COLUNAS */

ALTER TABLE PRODUTO
ADD PESO FLOAT(10,2) NOT NULL;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | varchar(50) | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
| PESO           | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

/* APAGANDO UMA COLUNA */

ALTER TABLE PRODUTO
DROP COLUMN PESO;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | varchar(50) | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

/* ADICIONANDO UMA COLUNA NA ORDEM ESPECIFICA */

ALTER TABLE PRODUTO 
ADD COLUMN PESO FLOAT(10,2) NOT NULL
AFTER NOME_PRODUTO;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| PESO           | float(10,2) | NO   |     | NULL    |                |
| VALOR_UNITARIO | varchar(50) | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+


ALTER TABLE PRODUTO 
ADD COLUMN PESO FLOAT(10,2) NOT NULL
FIRST ;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| PESO           | float(10,2) | NO   |     | NULL    |                |
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | varchar(50) | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+


-- EXERCÍCIOS!!


-- RELATÓRIO GERAL DE TODOS OS CLIENTES:


DESC CLIENTE;

+-----------+---------------+------+-----+---------+----------------+
| Field     | Type          | Null | Key | Default | Extra          |
+-----------+---------------+------+-----+---------+----------------+
| IDCLIENTE | int(11)       | NO   | PRI | NULL    | auto_increment |
| NOME      | varchar(30)   | NO   |     | NULL    |                |
| SEXO      | enum('M','F') | NO   |     | NULL    |                |
| EMAIL     | varchar(50)   | YES  | UNI | NULL    |                |
| CPF       | varchar(15)   | YES  | UNI | NULL    |                |
+-----------+---------------+------+-----+---------+----------------+


DESC ENDERECO;

+-------------+--------------+------+-----+---------+----------------+
| Field       | Type         | Null | Key | Default | Extra          |
+-------------+--------------+------+-----+---------+----------------+
| ID_ENDERECO | int(11)      | NO   | PRI | NULL    | auto_increment |
| RUA         | varchar(30)  | NO   |     | NULL    |                |
| BAIRRO      | varchar(255) | YES  |     | NULL    |                |
| CIDADE      | varchar(30)  | NO   |     | NULL    |                |
| ESTADO      | char(2)      | NO   |     | NULL    |                |
| ID_CLIENTE  | int(11)      | YES  | UNI | NULL    |                |
+-------------+--------------+------+-----+---------+----------------+

DESC TELEFONE;

+-------------+-------------------------+------+-----+---------+----------------+
| Field       | Type                    | Null | Key | Default | Extra          |
+-------------+-------------------------+------+-----+---------+----------------+
| ID_TELEFONE | int(11)                 | NO   | PRI | NULL    | auto_increment |
| TIPO        | enum('RES','COM','CEL') | NO   |     | NULL    |                |
| NUMERO      | varchar(15)             | NO   |     | NULL    |                |
| ID_CLIENTE  | int(11)                 | YES  | MUL | NULL    |                |
+-------------+-------------------------+------+-----+---------+----------------

SELECT C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, C.CPF, E.RUA, E.BAIRRO, E.CIDADE, ESTADO, TIPO, NUMERO
FROM CLIENTE C 
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE
ORDER BY IDCLIENTE;

+-----------+---------+------+-------------------+------------+-----------------------+------------+----------------+--------+------+-------------+
| IDCLIENTE | NOME    | SEXO | EMAIL             | CPF        | RUA                   | BAIRRO     | CIDADE         | ESTADO | TIPO | NUMERO      |
+-----------+---------+------+-------------------+------------+-----------------------+------------+----------------+--------+------+-------------+
|         1 | JOAO    | M    | JOAO@IG.COM       | 1234567890 | RUA CAPITÃO HERMES    | CENTRO     | RIO DE JANEIRO | RJ     | CEL  | 11992961260 |
|         1 | JOAO    | M    | JOAO@IG.COM       | 1234567890 | RUA CAPITÃO HERMES    | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 16992961260 |
|         2 | CARLOS  | M    | CARLOS@IG.COM     | 1234557890 | RUA ALFANDEGA         | ESTÁCIO    | RIO DE JANEIRO | RJ     | RES  | 16992961260 |
|         3 | ANA     | F    | ANA@IG.COM        | 0987654321 | RUA PRESIDENTE VARGAS | JARDINS    | SÃO PAULO      | SP     | COM  | 16992926760 |
|         4 | CLARA   | F    | NULL              | 4567891235 | RUA ANTONIO SÁ        | CENTRO     | BELO HORIZONTE | MG     | CEL  | 16992943260 |
|         5 | JORGE   | M    | JORGE@IG.COM      | 4561230789 | RUA URUGUAIANA        | CENTRO     | VITÓRIA        | ES     | CEL  | 16992961260 |
|         5 | JORGE   | M    | JORGE@IG.COM      | 4561230789 | RUA URUGUAIANA        | CENTRO     | VITÓRIA        | ES     | COM  | 16992957260 |
|         6 | CELIA   | F    | CELIA@IG.COM      | 1237894569 | RUA CAPITÃO SALSISHA  | FLAMENGO   | RIO DE JANEIRO | RJ     | RES  | 16992234660 |
|         9 | FLAVIO  | M    | FLAVIO@IG.COM     | 4657765    | RUA GUEDES            | CASCADURA  | B. HORIZONTE   | MG     | RES  | 68976565    |
|         9 | FLAVIO  | M    | FLAVIO@IG.COM     | 4657765    | RUA GUEDES            | CASCADURA  | B. HORIZONTE   | MG     | CEL  | 99656675    |
|        11 | GIOVANA | F    | NULL              | 0876655    | RUA VISCONDESSA       | CENTRO     | RIO DE JANEIRO | RJ     | CEL  | 33567765    |
|        11 | GIOVANA | F    | NULL              | 0876655    | RUA VISCONDESSA       | CENTRO     | RIO DE JANEIRO | RJ     | CEL  | 88668786    |
|        11 | GIOVANA | F    | NULL              | 0876655    | RUA VISCONDESSA       | CENTRO     | RIO DE JANEIRO | RJ     | COM  | 55689654    |
|        12 | KARLA   | M    | KARLA@GMAIL.COM   | 545676778  | RUA NELSON MANDELA    | COPACABANA | RIO DE JANEIRO | RJ     | COM  | 88687979    |
|        13 | DANIELE | M    | DANIELE@GMAIL.COM | 43536789   | RUA ARAUJO LIMA       | CENTRO     | VITORIA        | ES     | COM  | 88965676    |
|        15 | EDUARDO | M    | NULL              | 54376457   | AV CAPITAO ANTUNES    | CENTRO     | CURITIBA       | PR     | CEL  | 89966809    |
|        16 | ANTONIO | F    | ANTONIO@IG.COM    | 12436767   | AV CARLOS BARROSO     | JARDINS    | SAO PAULO      | SP     | COM  | 88679978    |
|        17 | ANTONIO | M    | ANTONIO@UOL.COM   | 3423565    | ALAMEDA SAMPAIO       | BOM RETIRO | CURITIBA       | PR     | CEL  | 99655768    |
|        18 | ELAINE  | M    | ELAINE@GLOBO.COM  | 32567763   | RUA DA LAPA           | LAPA       | SAO PAULO      | SP     | RES  | 89955665    |
|        19 | CARMEM  | M    | CARMEM@IG.COM     | 787832213  | RUA GERONIMO          | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 89766554    |
|        19 | CARMEM  | M    | CARMEM@IG.COM     | 787832213  | RUA GERONIMO          | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 77455786    |
|        20 | ADRIANA | F    | ADRIANA@GMAIL.COM | 88556942   | RUA GOMES FREIRE      | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 77755785    |
|        20 | ADRIANA | F    | ADRIANA@GMAIL.COM | 88556942   | RUA GOMES FREIRE      | CENTRO     | RIO DE JANEIRO | RJ     | COM  | 44522578    |
+-----------+---------+------+-------------------+------------+-----------------------+------------+----------------+--------+------+-------------+


SELECT CLIENTE 
WHERE IDCLIENTE = 12
OR IDCLIENTE = 14



-- RELATÓRIO GERAL DE HOMENS:

SELECT C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, C.CPF, E.RUA, E.BAIRRO, E.CIDADE, E.ESTADO, T.TIPO, T.NUMERO
FROM CLIENTE C 
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE C.SEXO = "M";

+-----------+---------+------+-------------------+------------+---------------------+------------+----------------+--------+------+-------------+
| IDCLIENTE | NOME    | SEXO | EMAIL             | CPF        | RUA                 | BAIRRO     | CIDADE         | ESTADO | TIPO | NUMERO      |
+-----------+---------+------+-------------------+------------+---------------------+------------+----------------+--------+------+-------------+
|         1 | JOAO    | M    | JOAO@IG.COM       | 1234567890 | RUA CAPITÃO HERMES  | CENTRO     | RIO DE JANEIRO | RJ     | CEL  | 11992961260 |
|         1 | JOAO    | M    | JOAO@IG.COM       | 1234567890 | RUA CAPITÃO HERMES  | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 16992961260 |
|         2 | CARLOS  | M    | CARLOS@IG.COM     | 1234557890 | RUA ALFANDEGA       | ESTÁCIO    | RIO DE JANEIRO | RJ     | RES  | 16992961260 |
|         5 | JORGE   | M    | JORGE@IG.COM      | 4561230789 | RUA URUGUAIANA      | CENTRO     | VITÓRIA        | ES     | CEL  | 16992961260 |
|         5 | JORGE   | M    | JORGE@IG.COM      | 4561230789 | RUA URUGUAIANA      | CENTRO     | VITÓRIA        | ES     | COM  | 16992957260 |
|         9 | FLAVIO  | M    | FLAVIO@IG.COM     | 4657765    | RUA GUEDES          | CASCADURA  | B. HORIZONTE   | MG     | RES  | 68976565    |
|         9 | FLAVIO  | M    | FLAVIO@IG.COM     | 4657765    | RUA GUEDES          | CASCADURA  | B. HORIZONTE   | MG     | CEL  | 99656675    |
|        12 | KARLA   | M    | KARLA@GMAIL.COM   | 545676778  | RUA NELSON MANDELA  | COPACABANA | RIO DE JANEIRO | RJ     | COM  | 88687979    |
|        13 | DANIELE | M    | DANIELE@GMAIL.COM | 43536789   | RUA ARAUJO LIMA     | CENTRO     | VITORIA        | ES     | COM  | 88965676    |
|        15 | EDUARDO | M    | NULL              | 54376457   | AV CAPITAO ANTUNES  | CENTRO     | CURITIBA       | PR     | CEL  | 89966809    |
|        17 | ANTONIO | M    | ANTONIO@UOL.COM   | 3423565    | ALAMEDA SAMPAIO     | BOM RETIRO | CURITIBA       | PR     | CEL  | 99655768    |
|        18 | ELAINE  | M    | ELAINE@GLOBO.COM  | 32567763   | RUA DA LAPA         | LAPA       | SAO PAULO      | SP     | RES  | 89955665    |
|        19 | CARMEM  | M    | CARMEM@IG.COM     | 787832213  | RUA GERONIMO        | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 77455786    |
|        19 | CARMEM  | M    | CARMEM@IG.COM     | 787832213  | RUA GERONIMO        | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 89766554    |
+-----------+---------+------+-------------------+------------+---------------------+------------+----------------+--------+------+-------------+

-- CORREÇÃO DO SEXO EM ALGUNS IDS:

-- 12,13,18,19

SELECT * FROM CLIENTE 
WHERE IDCLIENTE = 12 
OR IDCLIENTE = 13
OR IDCLIENTE = 18
OR IDCLIENTE = 19;

-- MANEIRA ALTERANTIVA

SELECT * FROM CLIENTE
	WHERE IDCLIENTE IN(12,13,18,19);


UPDATE CLIENTE SET SEXO = "F"
	WHERE IDCLIENTE IN(12,13,18,19)


UPDATE CLIENTE SET SEXO = "M"
	WHERE IDCLIENTE IN(16)

-- CORRRIGIDO:

+-----------+---------+------+-----------------+------------+---------------------+------------+----------------+--------+------+-------------+
| IDCLIENTE | NOME    | SEXO | EMAIL           | CPF        | RUA                 | BAIRRO     | CIDADE         | ESTADO | TIPO | NUMERO      |
+-----------+---------+------+-----------------+------------+---------------------+------------+----------------+--------+------+-------------+
|         1 | JOAO    | M    | JOAO@IG.COM     | 1234567890 | RUA CAPITÃO HERMES  | CENTRO     | RIO DE JANEIRO | RJ     | CEL  | 11992961260 |
|         1 | JOAO    | M    | JOAO@IG.COM     | 1234567890 | RUA CAPITÃO HERMES  | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 16992961260 |
|         2 | CARLOS  | M    | CARLOS@IG.COM   | 1234557890 | RUA ALFANDEGA       | ESTÁCIO    | RIO DE JANEIRO | RJ     | RES  | 16992961260 |
|         5 | JORGE   | M    | JORGE@IG.COM    | 4561230789 | RUA URUGUAIANA      | CENTRO     | VITÓRIA        | ES     | CEL  | 16992961260 |
|         5 | JORGE   | M    | JORGE@IG.COM    | 4561230789 | RUA URUGUAIANA      | CENTRO     | VITÓRIA        | ES     | COM  | 16992957260 |
|         9 | FLAVIO  | M    | FLAVIO@IG.COM   | 4657765    | RUA GUEDES          | CASCADURA  | B. HORIZONTE   | MG     | RES  | 68976565    |
|         9 | FLAVIO  | M    | FLAVIO@IG.COM   | 4657765    | RUA GUEDES          | CASCADURA  | B. HORIZONTE   | MG     | CEL  | 99656675    |
|        15 | EDUARDO | M    | NULL            | 54376457   | AV CAPITAO ANTUNES  | CENTRO     | CURITIBA       | PR     | CEL  | 89966809    |
|        17 | ANTONIO | M    | ANTONIO@UOL.COM | 3423565    | ALAMEDA SAMPAIO     | BOM RETIRO | CURITIBA       | PR     | CEL  | 99655768    |
+-----------+---------+------+-----------------+------------+---------------------+------------+----------------+--------+------+-------------+




-- RELATÓRIO GERAL DE MULHERES;

SELECT C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, C.CPF, E.RUA, E.BAIRRO, E.CIDADE, T.ESTADO, T.TIPO, T.NUMERO
FROM CLIENTE C 
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE C.SEXO = "F";

+-----------+---------+------+-------------------+------------+-----------------------+----------+----------------+--------+------+-------------+
| IDCLIENTE | NOME    | SEXO | EMAIL             | CPF        | RUA                   | BAIRRO   | CIDADE         | ESTADO | TIPO | NUMERO      |
+-----------+---------+------+-------------------+------------+-----------------------+----------+----------------+--------+------+-------------+
|         3 | ANA     | F    | ANA@IG.COM        | 0987654321 | RUA PRESIDENTE VARGAS | JARDINS  | SÃO PAULO      | SP     | COM  | 16992926760 |
|         4 | CLARA   | F    | NULL              | 4567891235 | RUA ANTONIO SÁ        | CENTRO   | BELO HORIZONTE | MG     | CEL  | 16992943260 |
|         6 | CELIA   | F    | CELIA@IG.COM      | 1237894569 | RUA CAPITÃO SALSISHA  | FLAMENGO | RIO DE JANEIRO | RJ     | RES  | 16992234660 |
|        11 | GIOVANA | F    | NULL              | 0876655    | RUA VISCONDESSA       | CENTRO   | RIO DE JANEIRO | RJ     | CEL  | 33567765    |
|        11 | GIOVANA | F    | NULL              | 0876655    | RUA VISCONDESSA       | CENTRO   | RIO DE JANEIRO | RJ     | CEL  | 88668786    |
|        11 | GIOVANA | F    | NULL              | 0876655    | RUA VISCONDESSA       | CENTRO   | RIO DE JANEIRO | RJ     | COM  | 55689654    |
|        16 | ANTONIO | F    | ANTONIO@IG.COM    | 12436767   | AV CARLOS BARROSO     | JARDINS  | SAO PAULO      | SP     | COM  | 88679978    |
|        20 | ADRIANA | F    | ADRIANA@GMAIL.COM | 88556942   | RUA GOMES FREIRE      | CENTRO   | RIO DE JANEIRO | RJ     | RES  | 77755785    |
|        20 | ADRIANA | F    | ADRIANA@GMAIL.COM | 88556942   | RUA GOMES FREIRE      | CENTRO   | RIO DE JANEIRO | RJ     | COM  | 44522578    |
+-----------+---------+------+-------------------+------------+-----------------------+----------+----------------+--------+------+-------------+

-- QUANTIDADE DE HOMENS E MULHERES

SELECT COUNT(*) AS QUANTIDADE, SEXO
FROM CLIENTE 
GROUP BY SEXO;


-- 	ID'S E EMAIL DAS MULHERES QUE MOREM NO CENTRO DO RIO DE JANEIRO E NÃO TEM NENHUM CELULAR


SELECT C.IDCLIENTE, C.EMAIL, C.NOME, C.SEXO, T.TIPO, E.BAIRRO, E.CIDADE
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE
	WHERE C.SEXO = "F"
		AND E.BAIRRO = "CENTRO" AND E.CIDADE = "RIO DE JANEIRO"
		AND (T.TIPO = "RES" or T.TIPO = "COM");

-- RELATÓRIO COM NOME, EMAIL, E TELEFONE CELULAR DAS MULHERES QUE MORAM, NO ESTADO DE SÃO PAULO


SELECT C.NOME, C.SEXO, C.EMAIL, T.NUMERO AS CELULAR
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE
	WHERE T.TIPO = "CEL" AND E.ESTADO = "RJ";
		
-- Nome, Email, Celular de mulheres que morem no Estado de SP

SELECT C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, T.NUMERO AS CELULAR, E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
	WHERE SEXO = "F"
	AND ESTADO = "SP";


/* IFNULL */

-- FUNÇÃO: BLOCO DE PROGRAMAÇÃOQ UE EXECUTA ALGO


/* NOME DO CLIENTEM, EMAIL, NUMERO, ESTADO */

-- SEM IFNULL

SELECT C.NOME, C.EMAIL, T.NUMERO, E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE;

+---------+-------------------+-------------+--------+
| NOME    | EMAIL             | NUMERO      | ESTADO |
+---------+-------------------+-------------+--------+
| JORGE   | JORGE@IG.COM      | 16992961260 | ES     |
| CARLOS  | CARLOS@IG.COM     | 16992961260 | RJ     |
| CLARA   | NULL              | 16992943260 | MG     |
| JORGE   | JORGE@IG.COM      | 16992957260 | ES     |
| JOAO    | JOAO@IG.COM       | 11992961260 | RJ     |
| JOAO    | JOAO@IG.COM       | 16992961260 | RJ     |
| ANA     | ANA@IG.COM        | 16992926760 | SP     |
| CELIA   | CELIA@IG.COM      | 16992234660 | RJ     |
| FLAVIO  | FLAVIO@IG.COM     | 68976565    | MG     |
| FLAVIO  | FLAVIO@IG.COM     | 99656675    | MG     |
| GIOVANA | NULL              | 33567765    | RJ     |
| GIOVANA | NULL              | 88668786    | RJ     |
| GIOVANA | NULL              | 55689654    | RJ     |
| KARLA   | KARLA@GMAIL.COM   | 88687979    | RJ     |
| DANIELE | DANIELE@GMAIL.COM | 88965676    | ES     |
| EDUARDO | NULL              | 89966809    | PR     |
| ANTONIO | ANTONIO@IG.COM    | 88679978    | SP     |
| ANTONIO | ANTONIO@UOL.COM   | 99655768    | PR     |
| ELAINE  | ELAINE@GLOBO.COM  | 89955665    | SP     |
| CARMEM  | CARMEM@IG.COM     | 77455786    | RJ     |
| CARMEM  | CARMEM@IG.COM     | 89766554    | RJ     |
| ADRIANA | ADRIANA@GMAIL.COM | 77755785    | RJ     |
| ADRIANA | ADRIANA@GMAIL.COM | 44522578    | RJ     |
+---------+-------------------+-------------+--------+

-- UTILIZANDO IFNULL

SELECT 	C.NOME, 
		IFNULL(C.EMAIL,'NAO TEM E-MAL'), 
		T.NUMERO, 
		E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE;

+---------+---------------------------------+-------------+--------+
| NOME    | IFNULL(C.EMAIL,'NAO TEM E-MAL') | NUMERO      | ESTADO |
+---------+---------------------------------+-------------+--------+
| JORGE   | JORGE@IG.COM                    | 16992961260 | ES     |
| CARLOS  | CARLOS@IG.COM                   | 16992961260 | RJ     |
| CLARA   | NAO TEM E-MAL                   | 16992943260 | MG     |
| JORGE   | JORGE@IG.COM                    | 16992957260 | ES     |
| JOAO    | JOAO@IG.COM                     | 11992961260 | RJ     |
| JOAO    | JOAO@IG.COM                     | 16992961260 | RJ     |
| ANA     | ANA@IG.COM                      | 16992926760 | SP     |
| CELIA   | CELIA@IG.COM                    | 16992234660 | RJ     |
| FLAVIO  | FLAVIO@IG.COM                   | 68976565    | MG     |
| FLAVIO  | FLAVIO@IG.COM                   | 99656675    | MG     |
| GIOVANA | NAO TEM E-MAL                   | 33567765    | RJ     |
| GIOVANA | NAO TEM E-MAL                   | 88668786    | RJ     |
| GIOVANA | NAO TEM E-MAL                   | 55689654    | RJ     |
| KARLA   | KARLA@GMAIL.COM                 | 88687979    | RJ     |
| DANIELE | DANIELE@GMAIL.COM               | 88965676    | ES     |
| EDUARDO | NAO TEM E-MAL                   | 89966809    | PR     |
| ANTONIO | ANTONIO@IG.COM                  | 88679978    | SP     |
| ANTONIO | ANTONIO@UOL.COM                 | 99655768    | PR     |
| ELAINE  | ELAINE@GLOBO.COM                | 89955665    | SP     |
| CARMEM  | CARMEM@IG.COM                   | 77455786    | RJ     |
| CARMEM  | CARMEM@IG.COM                   | 89766554    | RJ     |
| ADRIANA | ADRIANA@GMAIL.COM               | 77755785    | RJ     |
| ADRIANA | ADRIANA@GMAIL.COM               | 44522578    | RJ     |
+---------+---------------------------------+-------------+--------+


SELECT 	C.NOME, 
		IFNULL(C.EMAIL,'NAO TEM E-MAL') AS 'E-MAIL', 
		T.NUMERO, 
		E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE;


+---------+-------------------+-------------+--------+
| NOME    | E-MAIL            | NUMERO      | ESTADO |
+---------+-------------------+-------------+--------+
| JORGE   | JORGE@IG.COM      | 16992961260 | ES     |
| CARLOS  | CARLOS@IG.COM     | 16992961260 | RJ     |
| CLARA   | NAO TEM E-MAL     | 16992943260 | MG     |
| JORGE   | JORGE@IG.COM      | 16992957260 | ES     |
| JOAO    | JOAO@IG.COM       | 11992961260 | RJ     |
| JOAO    | JOAO@IG.COM       | 16992961260 | RJ     |
| ANA     | ANA@IG.COM        | 16992926760 | SP     |
| CELIA   | CELIA@IG.COM      | 16992234660 | RJ     |
| FLAVIO  | FLAVIO@IG.COM     | 68976565    | MG     |
| FLAVIO  | FLAVIO@IG.COM     | 99656675    | MG     |
| GIOVANA | NAO TEM E-MAL     | 33567765    | RJ     |
| GIOVANA | NAO TEM E-MAL     | 88668786    | RJ     |
| GIOVANA | NAO TEM E-MAL     | 55689654    | RJ     |
| KARLA   | KARLA@GMAIL.COM   | 88687979    | RJ     |
| DANIELE | DANIELE@GMAIL.COM | 88965676    | ES     |
| EDUARDO | NAO TEM E-MAL     | 89966809    | PR     |
| ANTONIO | ANTONIO@IG.COM    | 88679978    | SP     |
| ANTONIO | ANTONIO@UOL.COM   | 99655768    | PR     |
| ELAINE  | ELAINE@GLOBO.COM  | 89955665    | SP     |
| CARMEM  | CARMEM@IG.COM     | 77455786    | RJ     |
| CARMEM  | CARMEM@IG.COM     | 89766554    | RJ     |
| ADRIANA | ADRIANA@GMAIL.COM | 77755785    | RJ     |
| ADRIANA | ADRIANA@GMAIL.COM | 44522578    | RJ     |
+---------+-------------------+-------------+--------+


/* VIEW */


-- CRIAÇÃO DA VIEW:
CREATE VIEW RELATORIO AS 
-- QUERY EM SI:
	SELECT C.NOME, 
	C.SEXO, 
	C.EMAIL, 
	T.TIPO, 
	T.NUMERO, 
	E.BAIRRO, 
	E.CIDADE, 
	E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE;


-- VIEW RELATORIO

SELECT * FROM RELATORIO;

+---------+------+-------------------+------+-------------+------------+----------------+--------+
| NOME    | SEXO | EMAIL             | TIPO | NUMERO      | BAIRRO     | CIDADE         | ESTADO |
+---------+------+-------------------+------+-------------+------------+----------------+--------+
| JORGE   | M    | JORGE@IG.COM      | CEL  | 16992961260 | CENTRO     | VITÓRIA        | ES     |
| CARLOS  | M    | CARLOS@IG.COM     | RES  | 16992961260 | ESTÁCIO    | RIO DE JANEIRO | RJ     |
| CLARA   | F    | NULL              | CEL  | 16992943260 | CENTRO     | BELO HORIZONTE | MG     |
| JORGE   | M    | JORGE@IG.COM      | COM  | 16992957260 | CENTRO     | VITÓRIA        | ES     |
| JOAO    | M    | JOAO@IG.COM       | CEL  | 11992961260 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@IG.COM       | RES  | 16992961260 | CENTRO     | RIO DE JANEIRO | RJ     |
| ANA     | F    | ANA@IG.COM        | COM  | 16992926760 | JARDINS    | SÃO PAULO      | SP     |
| CELIA   | F    | CELIA@IG.COM      | RES  | 16992234660 | FLAMENGO   | RIO DE JANEIRO | RJ     |
| FLAVIO  | M    | FLAVIO@IG.COM     | RES  | 68976565    | CASCADURA  | B. HORIZONTE   | MG     |
| FLAVIO  | M    | FLAVIO@IG.COM     | CEL  | 99656675    | CASCADURA  | B. HORIZONTE   | MG     |
| GIOVANA | F    | NULL              | CEL  | 33567765    | CENTRO     | RIO DE JANEIRO | RJ     |
| GIOVANA | F    | NULL              | CEL  | 88668786    | CENTRO     | RIO DE JANEIRO | RJ     |
| GIOVANA | F    | NULL              | COM  | 55689654    | CENTRO     | RIO DE JANEIRO | RJ     |
| KARLA   | F    | KARLA@GMAIL.COM   | COM  | 88687979    | COPACABANA | RIO DE JANEIRO | RJ     |
| DANIELE | F    | DANIELE@GMAIL.COM | COM  | 88965676    | CENTRO     | VITORIA        | ES     |
| EDUARDO | M    | NULL              | CEL  | 89966809    | CENTRO     | CURITIBA       | PR     |
| ANTONIO | M    | ANTONIO@IG.COM    | COM  | 88679978    | JARDINS    | SAO PAULO      | SP     |
| ANTONIO | M    | ANTONIO@UOL.COM   | CEL  | 99655768    | BOM RETIRO | CURITIBA       | PR     |
| ELAINE  | F    | ELAINE@GLOBO.COM  | RES  | 89955665    | LAPA       | SAO PAULO      | SP     |
| CARMEM  | F    | CARMEM@IG.COM     | RES  | 77455786    | CENTRO     | RIO DE JANEIRO | RJ     |
| CARMEM  | F    | CARMEM@IG.COM     | RES  | 89766554    | CENTRO     | RIO DE JANEIRO | RJ     |
| ADRIANA | F    | ADRIANA@GMAIL.COM | RES  | 77755785    | CENTRO     | RIO DE JANEIRO | RJ     |
| ADRIANA | F    | ADRIANA@GMAIL.COM | COM  | 44522578    | CENTRO     | RIO DE JANEIRO | RJ     |
+---------+------+-------------------+------+-------------+------------+----------------+--------+

-- PARA EXIBIR AS VIEWS CRIADAS: 

SHOW TABLES;

-- A VIEW NÃO DUPLICA OS DADOS DO BANCO, E SIM CRIA "TABELAS VIRUAIS".

-- DELETAR VIEW:

DROP VIEW RELATORIO;

-- INSERINDO UM PREFIXO (SERVE PARA IDENTIFICAR MAIS FACILEMNTE UMA VIEW).

CREATE VIEW V_RELATORIO AS 
	SELECT C.NOME, 
	C.SEXO, 
	IFNULL (C.EMAIL, 'CLIENTE SEM EMAIL') AS "E-MAIL",
	T.TIPO, 
	T.NUMERO, 
	E.BAIRRO, 
	E.CIDADE, 
	E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE;

-- EXIBIR NOME, NÚMERO E ESTADO UTILIZANDO A VIEW

SELECT NOME, NUMERO, ESTADO
FROM V_RELATORIO;


/* Update, insert and Delete - DML */
-- não é possivel executar funções de DML dentro de Views com Join

INSERT INTO V_RELATORIO VALUES(
"ANDREIA", "F", "ANDREIA@UOL.COM.BR", "CEL", "987456258","CENTRO","VITORIA","ES");

CREATE TABLE JOGADORES(
	IDJOGADOR INT,
	NOME varchar(30),
	ESTADO CHAR(2)
	);

INSERT INTO JOGADORES VALUES(1,"GUERRERO","RS");
INSERT INTO JOGADORES VALUES(2,"GABIGOL","SP");
INSERT INTO JOGADORES VALUES(3,"GANSO","RJ");
INSERT INTO JOGADORES VALUES(4,"NEYMAR","SP");
INSERT INTO JOGADORES VALUES(5,"ROONEY","RS");


CREATE VIEW V_JOGADORES AS 
SELECT NOME, ESTADO
FROM JOGADORES;

-- OPERAÇÃO DELETE É PERMITIDA EM VIEWS QUE NÃO TEM "JOIN"
DELETE FROM v_JOGADORES
	WHERE NOME = "GUERRERO";

-- OPERAÇÃO INSERT É PERMITIDA EM VIEWS QUE NÃO TEM "JOIN"
INSERT INTO V_JOGADORES VALUES("GUERRERO","RS");

SELECT * FROM V_RELATORIO
WHERE SEXO = "F";

DROP TABLE JOGADORES;


/* ORDER BY */


CREATE TABLE ALUNOS(
NUMERO INT,
NOME VARCHAR(30)
);

INSERT INTO ALUNOS VALUES(1,"JOÃO");
INSERT INTO ALUNOS VALUES(1,"MARIA");
INSERT INTO ALUNOS VALUES(2,"ZOE");
INSERT INTO ALUNOS VALUES(2,"ANDRÉ");
INSERT INTO ALUNOS VALUES(3,"CLARA");
INSERT INTO ALUNOS VALUES(1,"CLARA");
INSERT INTO ALUNOS VALUES(4,"MAFRA");
INSERT INTO ALUNOS VALUES(5,"JANAINA");
INSERT INTO ALUNOS VALUES(1,"JANAINA");
INSERT INTO ALUNOS VALUES(3,"MARCELO");
INSERT INTO ALUNOS VALUES(4,"GIOVANI");
INSERT INTO ALUNOS VALUES(5,"ANTÔNIO");
INSERT INTO ALUNOS VALUES(6,"ANA");
INSERT INTO ALUNOS VALUES(6,"VIVIANE");


SELECT * FROM ALUNOS
-- ORDENADO PELO NOME DA COLUNA
ORDER BY NUMERO;

+--------+----------+
| NUMERO | NOME     |
+--------+----------+
|      1 | JOÃO     |
|      1 | MARIA    |
|      1 | CLARA    |
|      1 | JANAINA  |
|      2 | ZOE      |
|      2 | ANDRÉ    |
|      3 | CLARA    |
|      3 | MARCELO  |
|      4 | MAFRA    |
|      4 | GIOVANI  |
|      5 | JANAINA  |
|      5 | ANTÔNIO  |
|      6 | ANA      |
|      6 | VIVIANE  |
+--------+----------+

SELECT * FROM ALUNOS
-- ORDENADO PELO ÍNDICE (ORDEM) DA COLUNA
ORDER BY 1;

SELECT * FROM ALUNOS
-- ORDENADO POR MAIS DE UMA COLUNA (FUNCIONA TANTO COM O NOME DA COLUNA, QUANTO COM ÍNDICE)
ORDER BY NUMERO, NOME;

+--------+----------+
| NUMERO | NOME     |
+--------+----------+
|      1 | CLARA    |
|      1 | JANAINA  |
|      1 | JOÃO     |
|      1 | MARIA    |
|      2 | ANDRÉ    |
|      2 | ZOE      |
|      3 | CLARA    |
|      3 | MARCELO  |
|      4 | GIOVANI  |
|      4 | MAFRA    |
|      5 | ANTÔNIO  |
|      5 | JANAINA  |
|      6 | ANA      |
|      6 | VIVIANE  |
+--------+----------+

SELECT NOME FROM ALUNOS
-- ORDENADO POR MAIS DE UMA COLUNA, PORÉM EXIBINDO APENAS O RESULTADO PARA "NOME" (NÃO FUNCIONA COM ÍNDICE)
ORDER BY NUMERO, NOME;

+----------+
| NOME     |
+----------+
| CLARA    |
| JANAINA  |
| JOÃO     |
| MARIA    |
| ANDRÉ    |
| ZOE      |
| CLARA    |
| MARCELO  |
| GIOVANI  |
| MAFRA    |
| ANTÔNIO  |
| JANAINA  |
| ANA      |
| VIVIANE  |
+----------+

-- ORDEY BY SÓ FUNCIONA COM ÍNDICE SE A COLUNA RELATIVA A ELE FOR EXIBIDA NA PROJEÇÃO

SELECT * FROM ALUNOS
ORDER BY NUMERO ASC -- ASC = ASCENDENTE (CRESCENTE)

SELECT * FROM ALUNOS
ORDER BY NUMERO DESC -- ASC = DESCENDENTE (DECRESCENTE);

+--------+----------+
| NUMERO | NOME     |
+--------+----------+
|      6 | ANA      |
|      6 | VIVIANE  |
|      5 | JANAINA  |
|      5 | ANTÔNIO  |
|      4 | MAFRA    |
|      4 | GIOVANI  |
|      3 | CLARA    |
|      3 | MARCELO  |
|      2 | ZOE      |
|      2 | ANDRÉ    |
|      1 | JOÃO     |
|      1 | MARIA    |
|      1 | CLARA    |
|      1 | JANAINA  |
+--------+----------+

SELECT * FROM ALUNOS
-- PROJETA O NÚMERO CRESCENTE, E O NOME DECRESCENTE
ORDER BY NUMERO ASC, NOME DESC ;

+--------+----------+
| NUMERO | NOME     |
+--------+----------+
|      1 | MARIA    |
|      1 | JOÃO     |
|      1 | JANAINA  |
|      1 | CLARA    |
|      2 | ZOE      |
|      2 | ANDRÉ    |
|      3 | MARCELO  |
|      3 | CLARA    |
|      4 | MAFRA    |
|      4 | GIOVANI  |
|      5 | JANAINA  |
|      5 | ANTÔNIO  |
|      6 | VIVIANE  |
|      6 | ANA      |
+--------+----------+

-- ORDENANDO PELA PRIMEIRA COLUNA

SELECT C.NOME, 
	C.SEXO, 
	IFNULL (C.EMAIL, 'CLIENTE SEM EMAIL') AS "E-MAIL",
	T.TIPO, 
	T.NUMERO, 
	E.BAIRRO, 
	E.CIDADE, 
	E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T 
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E 
ON C.IDCLIENTE = E.ID_CLIENTE
ORDER BY 1;

+---------+------+-------------------+------+-------------+------------+----------------+--------+
| NOME    | SEXO | E-MAIL            | TIPO | NUMERO      | BAIRRO     | CIDADE         | ESTADO |
+---------+------+-------------------+------+-------------+------------+----------------+--------+
| ADRIANA | F    | ADRIANA@GMAIL.COM | COM  | 44522578    | CENTRO     | RIO DE JANEIRO | RJ     |
| ADRIANA | F    | ADRIANA@GMAIL.COM | RES  | 77755785    | CENTRO     | RIO DE JANEIRO | RJ     |
| ANA     | F    | ANA@IG.COM        | COM  | 16992926760 | JARDINS    | SÃO PAULO      | SP     |
| ANTONIO | M    | ANTONIO@UOL.COM   | CEL  | 99655768    | BOM RETIRO | CURITIBA       | PR     |
| ANTONIO | M    | ANTONIO@IG.COM    | COM  | 88679978    | JARDINS    | SAO PAULO      | SP     |
| CARLOS  | M    | CARLOS@IG.COM     | RES  | 16992961260 | ESTÁCIO    | RIO DE JANEIRO | RJ     |
| CARMEM  | F    | CARMEM@IG.COM     | RES  | 89766554    | CENTRO     | RIO DE JANEIRO | RJ     |
| CARMEM  | F    | CARMEM@IG.COM     | RES  | 77455786    | CENTRO     | RIO DE JANEIRO | RJ     |
| CELIA   | F    | CELIA@IG.COM      | RES  | 16992234660 | FLAMENGO   | RIO DE JANEIRO | RJ     |
| CLARA   | F    | CLIENTE SEM EMAIL | CEL  | 16992943260 | CENTRO     | BELO HORIZONTE | MG     |
| DANIELE | F    | DANIELE@GMAIL.COM | COM  | 88965676    | CENTRO     | VITORIA        | ES     |
| EDUARDO | M    | CLIENTE SEM EMAIL | CEL  | 89966809    | CENTRO     | CURITIBA       | PR     |
| ELAINE  | F    | ELAINE@GLOBO.COM  | RES  | 89955665    | LAPA       | SAO PAULO      | SP     |
| FLAVIO  | M    | FLAVIO@IG.COM     | CEL  | 99656675    | CASCADURA  | B. HORIZONTE   | MG     |
| FLAVIO  | M    | FLAVIO@IG.COM     | RES  | 68976565    | CASCADURA  | B. HORIZONTE   | MG     |
| GIOVANA | F    | CLIENTE SEM EMAIL | CEL  | 33567765    | CENTRO     | RIO DE JANEIRO | RJ     |
| GIOVANA | F    | CLIENTE SEM EMAIL | CEL  | 88668786    | CENTRO     | RIO DE JANEIRO | RJ     |
| GIOVANA | F    | CLIENTE SEM EMAIL | COM  | 55689654    | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@IG.COM       | CEL  | 11992961260 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@IG.COM       | RES  | 16992961260 | CENTRO     | RIO DE JANEIRO | RJ     |
| JORGE   | M    | JORGE@IG.COM      | CEL  | 16992961260 | CENTRO     | VITÓRIA        | ES     |
| JORGE   | M    | JORGE@IG.COM      | COM  | 16992957260 | CENTRO     | VITÓRIA        | ES     |
| KARLA   | F    | KARLA@GMAIL.COM   | COM  | 88687979    | COPACABANA | RIO DE JANEIRO | RJ     |
+---------+------+-------------------+------+-------------+------------+----------------+--------+

-- UTILIZANDO EM VIEW:

SELECT * FROM V_RELATORIO
ORDER BY 1;

+---------+------+-------------------+------+-------------+------------+----------------+--------+
| NOME    | SEXO | E-MAIL            | TIPO | NUMERO      | BAIRRO     | CIDADE         | ESTADO |
+---------+------+-------------------+------+-------------+------------+----------------+--------+
| ADRIANA | F    | ADRIANA@GMAIL.COM | COM  | 44522578    | CENTRO     | RIO DE JANEIRO | RJ     |
| ADRIANA | F    | ADRIANA@GMAIL.COM | RES  | 77755785    | CENTRO     | RIO DE JANEIRO | RJ     |
| ANA     | F    | ANA@IG.COM        | COM  | 16992926760 | JARDINS    | SÃO PAULO      | SP     |
| ANTONIO | M    | ANTONIO@UOL.COM   | CEL  | 99655768    | BOM RETIRO | CURITIBA       | PR     |
| ANTONIO | M    | ANTONIO@IG.COM    | COM  | 88679978    | JARDINS    | SAO PAULO      | SP     |
| CARLOS  | M    | CARLOS@IG.COM     | RES  | 16992961260 | ESTÁCIO    | RIO DE JANEIRO | RJ     |
| CARMEM  | F    | CARMEM@IG.COM     | RES  | 89766554    | CENTRO     | RIO DE JANEIRO | RJ     |
| CARMEM  | F    | CARMEM@IG.COM     | RES  | 77455786    | CENTRO     | RIO DE JANEIRO | RJ     |
| CELIA   | F    | CELIA@IG.COM      | RES  | 16992234660 | FLAMENGO   | RIO DE JANEIRO | RJ     |
| CLARA   | F    | CLIENTE SEM EMAIL | CEL  | 16992943260 | CENTRO     | BELO HORIZONTE | MG     |
| DANIELE | F    | DANIELE@GMAIL.COM | COM  | 88965676    | CENTRO     | VITORIA        | ES     |
| EDUARDO | M    | CLIENTE SEM EMAIL | CEL  | 89966809    | CENTRO     | CURITIBA       | PR     |
| ELAINE  | F    | ELAINE@GLOBO.COM  | RES  | 89955665    | LAPA       | SAO PAULO      | SP     |
| FLAVIO  | M    | FLAVIO@IG.COM     | CEL  | 99656675    | CASCADURA  | B. HORIZONTE   | MG     |
| FLAVIO  | M    | FLAVIO@IG.COM     | RES  | 68976565    | CASCADURA  | B. HORIZONTE   | MG     |
| GIOVANA | F    | CLIENTE SEM EMAIL | CEL  | 33567765    | CENTRO     | RIO DE JANEIRO | RJ     |
| GIOVANA | F    | CLIENTE SEM EMAIL | CEL  | 88668786    | CENTRO     | RIO DE JANEIRO | RJ     |
| GIOVANA | F    | CLIENTE SEM EMAIL | COM  | 55689654    | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@IG.COM       | CEL  | 11992961260 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@IG.COM       | RES  | 16992961260 | CENTRO     | RIO DE JANEIRO | RJ     |
| JORGE   | M    | JORGE@IG.COM      | CEL  | 16992961260 | CENTRO     | VITÓRIA        | ES     |
| JORGE   | M    | JORGE@IG.COM      | COM  | 16992957260 | CENTRO     | VITÓRIA        | ES     |
| KARLA   | F    | KARLA@GMAIL.COM   | COM  | 88687979    | COPACABANA | RIO DE JANEIRO | RJ     |
+---------+------+-------------------+------+-------------+------------+----------------+--------+


-- ";" é um delimitador, ou seja, o banco (mySQl) entende que o final do código é sinalizado por ponto e virgula.

-- MUDAR O DELIMITADOR:

DELIMITER $ -- MODIFICA O DELIMITAR DE ; PARA $

SELECT * FROM V_RELATORIO
ORDER BY 1$

+---------+------+-------------------+------+-------------+------------+----------------+--------+
| NOME    | SEXO | E-MAIL            | TIPO | NUMERO      | BAIRRO     | CIDADE         | ESTADO |
+---------+------+-------------------+------+-------------+------------+----------------+--------+
| ADRIANA | F    | ADRIANA@GMAIL.COM | COM  | 44522578    | CENTRO     | RIO DE JANEIRO | RJ     |
| ADRIANA | F    | ADRIANA@GMAIL.COM | RES  | 77755785    | CENTRO     | RIO DE JANEIRO | RJ     |
| ANA     | F    | ANA@IG.COM        | COM  | 16992926760 | JARDINS    | SÃO PAULO      | SP     |
| ANTONIO | M    | ANTONIO@UOL.COM   | CEL  | 99655768    | BOM RETIRO | CURITIBA       | PR     |
| ANTONIO | M    | ANTONIO@IG.COM    | COM  | 88679978    | JARDINS    | SAO PAULO      | SP     |
| CARLOS  | M    | CARLOS@IG.COM     | RES  | 16992961260 | ESTÁCIO    | RIO DE JANEIRO | RJ     |
| CARMEM  | F    | CARMEM@IG.COM     | RES  | 89766554    | CENTRO     | RIO DE JANEIRO | RJ     |
| CARMEM  | F    | CARMEM@IG.COM     | RES  | 77455786    | CENTRO     | RIO DE JANEIRO | RJ     |
| CELIA   | F    | CELIA@IG.COM      | RES  | 16992234660 | FLAMENGO   | RIO DE JANEIRO | RJ     |
| CLARA   | F    | CLIENTE SEM EMAIL | CEL  | 16992943260 | CENTRO     | BELO HORIZONTE | MG     |
| DANIELE | F    | DANIELE@GMAIL.COM | COM  | 88965676    | CENTRO     | VITORIA        | ES     |
| EDUARDO | M    | CLIENTE SEM EMAIL | CEL  | 89966809    | CENTRO     | CURITIBA       | PR     |
| ELAINE  | F    | ELAINE@GLOBO.COM  | RES  | 89955665    | LAPA       | SAO PAULO      | SP     |
| FLAVIO  | M    | FLAVIO@IG.COM     | CEL  | 99656675    | CASCADURA  | B. HORIZONTE   | MG     |
| FLAVIO  | M    | FLAVIO@IG.COM     | RES  | 68976565    | CASCADURA  | B. HORIZONTE   | MG     |
| GIOVANA | F    | CLIENTE SEM EMAIL | CEL  | 33567765    | CENTRO     | RIO DE JANEIRO | RJ     |
| GIOVANA | F    | CLIENTE SEM EMAIL | CEL  | 88668786    | CENTRO     | RIO DE JANEIRO | RJ     |
| GIOVANA | F    | CLIENTE SEM EMAIL | COM  | 55689654    | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@IG.COM       | CEL  | 11992961260 | CENTRO     | RIO DE JANEIRO | RJ     |
| JOAO    | M    | JOAO@IG.COM       | RES  | 16992961260 | CENTRO     | RIO DE JANEIRO | RJ     |
| JORGE   | M    | JORGE@IG.COM      | CEL  | 16992961260 | CENTRO     | VITÓRIA        | ES     |
| JORGE   | M    | JORGE@IG.COM      | COM  | 16992957260 | CENTRO     | VITÓRIA        | ES     |
| KARLA   | F    | KARLA@GMAIL.COM   | COM  | 88687979    | COPACABANA | RIO DE JANEIRO | RJ     |
+---------+------+-------------------+------+-------------+------------+----------------+--------+


/* STORED PROCEDURES */


SELECT "MAFRA"; -- EXIBE MAFRA




-- CRIANDO O DELIMITER 
DELIMITER $

-- CRIANDO A PROCEDURE 

CREATE PROCEDURE NOME_EMPRESA()
BEGIN

	SELECT "UNIVERSIDADE DOS DADOS" AS EMPRESA;

END 
$


-- CHAMAR PROCEDURE

CALL NOME_EMPRESA()$ -- PROJETA "UNIVERSIADADE DOS DADOS" COM O NOME DA COLUNA COMO "EMPRESA".


-- PROCEDURES COM PARAMETROS


SELECT 10 + 10 AS CONTAS$



CREATE PROCEDURE CONTA()
BEGIN
		SELECT 10 + 10 AS CONTA;

END 
$

CALL CONTA$


-- APAGANDO PROCEDURE

DROP PROCEDURE CONTA$



-- CRIANDO AS PROCEDURES COM PARÂMETROS E VARIÁVEIS

CREATE PROCEDURE CONTA(NUMERO1 INT, NUMERO2 INT) -- UTILIZA OS PARAMETROS COMO UMA ESPECIE DE VARIÁVEIS
BEGIN
		SELECT NUMERO1 + NUMERO2 AS CONTA; -- ESSA PROCEDURE SERVE PARA PROJETAR OS VALORES INSERIDOS DENTRO DA PROCEDURE "CONTA" UTILIZANDO AS VARIÁVEIS NUMERO1 E NUMERO2.

END 
$


CALL CONTA(100,50)$ -- "CALL" DA PROCEDURE "CONTA" REALIZANDO A COMATÓRIA CONFIGURADA DENTRO DO SELECT.


/* PROCEDURES */


CREATE DATABASE PROJETO $ -- CRIA UM NOVO DB "PROJETO".

CREATE TABLE CURSOS(
	ID_CURSO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	HORAS INT(3) NOT NULL,
	VALOR FLOAT(10,2)NOT NULL
	)$

INSERT INTO CURSOS VALUES(NULL, "JAVA", 30, 500.00)$
INSERT INTO CURSOS VALUES(NULL, "FUNDAMENTOS DE DB", 40, 700.00)$


-- CRIAÇÃO DA PROCEDURE CAD_CURSO

CREATE PROCEDURE CAD_CURSO(P_NOME VARCHAR(30),
						   P_HORAS INT(3),
						   P_PRECO FLOAT(10,2))

BEGIN
	INSERT INTO CURSOS VALUES(NULL,P_NOME,P_HORAS,P_PRECO);

END 
$

CALL CAD_CURSO("BI SQL SERVER",35,3000);
CALL CAD_CURSO("POWER BI",20,1000.00);
CALL CAD_CURSO("TABLEU",30,1200.00);


/* EXERCÍCIO: CRIAR PROCEDURE PARA CONSULTAR CURSOS */

-- solução "Allan"


CREATE PROCEDURE CON_CURSO (CON_IDCURSO INT)

BEGIN
	SELECT NOME, HORAS, VALOR FROM CURSOS
	WHERE ID_CURSO = CON_IDCURSO;

END 
$

CALL CON_CURSO(1) -- PROJETA O CURSO REFERENTE A ID_CURSO NUMERO 1


/* FUNÇÕES DE AGREGAÇÃO */


CREATE TABLE VENDEDORES(
	IDVENDEDOR INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	SEXO VARCHAR(1),
	JANEIRO FLOAT(10,2),
	FEVEREIRO FLOAT(10,2),
	MARCO FLOAT(10,2)
)$

INSERT INTO VENDEDORES VALUES (NULL, "CARLOS","M",76234.78,69584.45,75884.66);
INSERT INTO VENDEDORES VALUES (NULL, "MARIA","F",76234.78,69584.45,75884.66);
INSERT INTO VENDEDORES VALUES (NULL, "ANTONIO","M",44444.78,69584.45,45678.66);
INSERT INTO VENDEDORES VALUES (NULL, "CLARA","F",76234.78,8469.45,75884.66);
INSERT INTO VENDEDORES VALUES (NULL, "ANDERSON","M",76234.78,69584.45,75884.66);
INSERT INTO VENDEDORES VALUES (NULL, "IVONE","F",655554.78,55555.45,75884.66);
INSERT INTO VENDEDORES VALUES (NULL, "JOAO","M",76234.78,69584.45,11111.66);
INSERT INTO VENDEDORES VALUES (NULL, "CELIA","F",12345.78,69584.45,75884.66);



SELECT * FROM VENDEDORES;

+------------+----------+------+-----------+-----------+----------+
| IDVENDEDOR | NOME     | SEXO | JANEIRO   | FEVEREIRO | MARCO    |
+------------+----------+------+-----------+-----------+----------+
|          1 | CARLOS   | M    |  76234.78 |  69584.45 | 75884.66 |
|          2 | MARIA    | F    |  76234.78 |  69584.45 | 75884.66 |
|          3 | ANTONIO  | M    |  44444.78 |  69584.45 | 45678.66 |
|          4 | CLARA    | F    |  76234.78 |   8469.45 | 75884.66 |
|          5 | ANDERSON | M    |  76234.78 |  69584.45 | 75884.66 |
|          6 | IVONE    | F    | 655554.75 |  55555.45 | 75884.66 |
|          7 | JOAO     | M    |  76234.78 |  69584.45 | 11111.66 |
|          8 | CELIA    | F    |  12345.78 |  69584.45 | 75884.66 |
+------------+----------+------+-----------+-----------+----------+

-- MAX - TRAZ O VALOR MÁXIMO DE UMA COLUNA

SELECT MAX(FEVEREIRO) AS MAIOR_FEV
FROM VENDEDORES;

+-----------+
| MAIOR_FEV |
+-----------+
|  69584.45 |
+-----------+

-- MAX - TRAZ O VALOR MÍNIMO DE UMA COLUNA

SELECT MIN(MARCO) AS MAIOR_MAR
FROM VENDEDORES;

+-----------+
| MAIOR_MAR |
+-----------+
|  11111.66 |
+-----------+

-- MAX - TRAZ O VALOR MÉDIO DE UMA COLUNA

SELECT AVG(MARCO) AS MEDIA_MAR
FROM VENDEDORES;

+--------------+
| MEDIA_MAR    |
+--------------+
| 64012.282227 |
+--------------+


SELECT MAX(JANEIRO) AS MAXIMO_JAN, -- PROJETA O MÁXIMO DE JANEIRO
	   MIN(JANEIRO) AS MINIMO_JAN, -- PROJETA O MÍNIMO DE JANEIRO
	   TRUNCATE (AVG(JANEIRO),2) AS MEDIA_JAN   -- PROJETA O MÉDIO DE JANEIRO (TRUNCATE - LIMITA A QUANTIDADE DE CASAS DECIMAIS QUE PRECISAMOS, EM NOSSO CASO, 2)
	   FROM VENDEDORES
	   ;

+------------+------------+-----------+
| MAXIMO_JAN | MINIMO_JAN | MEDIA_JAN |
+------------+------------+-----------+
|  655554.75 |   12345.78 | 136689.90 |
+------------+------------+-----------+


SELECT 'TESTE GITHUB';

SELECT "SEGUNDO TESTE";

SELECT "COMMIT CASA";

/* AGREGANDO COM SUM */

SELECT SUM(JANEIRO) AS TOTAL_JANEIRO
FROM VENDEDORES;

+---------------+
| TOTAL_JANEIRO |
+---------------+
|     820370.09 |
+---------------+


/* AGREGANDO COM SUM APENAS PESSOAS DO SEXO FEMININNO */

SELECT SEXO, SUM(JANEIRO) AS TOTAL_JANEIRO
FROM VENDEDORES
WHERE SEXO = "F";

+------+---------------+
| SEXO | TOTAL_JANEIRO |
+------+---------------+
| F    |     820370.09 |
+------+---------------+


/* SOMA OS VALORES DE JANEIRO, FEVEREIRO E MARÇO EM CADA RESPECTIVA TABELA RENOMEADA */

SELECT 
		SUM(JANEIRO) AS TOTAL_JANEIRO,
		SUM(FEVEREIRO) AS TOTAL_FEVEREIRO,
		SUM(MARCO) AS TOTAL_MARCO

FROM VENDEDORES;

+---------------+-----------------+-------------+
| TOTAL_JANEIRO | TOTAL_FEVEREIRO | TOTAL_MARCO |
+---------------+-----------------+-------------+
|    1093519.22 |       481531.62 |   512098.26 |
+---------------+-----------------+-------------+

/* AGREGA OS TOTAIS DE MARÇO COM A SOMA PARA CADA SEXO */


SELECT SEXO, SUM(MARCO) AS TOTAL_MARCO
	FROM VENDEDORES
	GROUP BY SEXO;

+------+-------------+
| SEXO | TOTAL_MARCO |
+------+-------------+
| F    |   303538.62 |
| M    |   208559.63 |
+------+-------------+

-- QUAL VENDEDOR VENDEU MENOS EM MARÇO (VALOR E NOME DO VENDEDOR)

SELECT NOME, MIN(MARCO) AS MÍNIMO_MARCO
	FROM VENDEDORES
	GROUP BY MARCO;

+--------+---------------+
| NOME   | MÍNIMO_MARCO  |
+--------+---------------+
| CARLOS |      11111.66 |
+--------+---------------+

-- QUAL VENDEDOR VENDEU MAIS EM MARÇO (VALOR E NOME DO VENDEDOR)

SELECT NOME, MAX(MARCO) AS MÁXIMO_MARCO
	FROM VENDEDORES;
