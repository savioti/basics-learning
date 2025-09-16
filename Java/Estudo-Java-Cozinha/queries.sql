-- 1) Criar Banco de Dados chamado Restaurante

CREATE DATABASE restaurante;

-- 2) Criar as tabelas Cozinha, Ingrediente e Funcionario
--   Essas tabelas deverão ter os campos conforme o exercício que vocês estão fazendo de Cozinha.

USE restaurante;

CREATE TABLE funcao (
    id INT NOT NULL AUTO_INCREMENT,
    tipo_funcao VARCHAR(30),
    PRIMARY KEY (id)
);

INSERT INTO funcao (tipo_funcao)
VALUES ('cozinheiro'), ('ajudante'), ('limpeza'), ('outro');

CREATE TABLE especialidade_cozinha (
    id INT NOT NULL AUTO_INCREMENT,
    nome_especialidade VARCHAR(30),
    PRIMARY KEY (id)
);

INSERT INTO especialidade_cozinha (nome_especialidade)
VALUES ('mineira'), ('chinesa'), ('italiana'), ('japonesa'), ('mexicana');

CREATE TABLE ingrediente (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(30),
    data_validade DATE,
    PRIMARY KEY (id)
);

CREATE TABLE funcionario (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60),
    tipo_funcao INT,
    PRIMARY KEY (id)
);

CREATE TABLE cozinha (
    id INT NOT NULL AUTO_INCREMENT,
    especialidade INT,
    hora_abertura TIME,
    hora_fechamento TIME,
    prato_principal VARCHAR(50),
    PRIMARY KEY (id)
);

-- 4) Incluir 5 itens na tabela de cozinha, 8 na tabela e ingredientes e 10 na tabela de funcionários.

INSERT INTO ingrediente (nome, data_validade)
VALUES ('Feijão', '2030-12-31'), ('Farinha', '2030-12-31'), ('Carne', '2021-4-14'),
('Macarrão', '2030-12-31'), ('Molho', '2021-4-21'), ('Brócolis', '2021-4-7'),
('Carne de porco', '2021-4-21'), ('Champignon', '2021-4-10');

INSERT INTO funcionario (nome, tipo_funcao)
VALUES ('Altieres Pereira', 1), ('Dara Vieira', 1), ('Ângelo Savioti', 1),
('José Luiz da Silva', 2), ('Arlan Silva', 2), ('Luciana Pereira', 2),
('Bernardo Oliveira', 3), ('Ana Maria', 3), ('Luiz Fernando', 3),
('Sebastião Maia', 4);

INSERT INTO cozinha (especialidade, hora_abertura, hora_fechamento, prato_principal)
VALUES (1, '14:00', '20:00', 'Feijoada'), (2, '10:00', '21:00', 'Yakissoba'),
(3, '13:00', '22:00', 'Espaguete'), (4, '15:00', '22:00', 'Sushi'),
(5, '12:00', '21:00', 'Taco');

-- 5) Criar uma consulta que retorne a quantidade de cozinhas cadastradas no banco de dados.

SELECT count(*) FROM cozinha;

-- 6) Criar uma consulta que possua um filtro, buscando as cozinhas que possuam o horário de fechamento as 22 horas.

SELECT * FROM cozinha WHERE hora_fechamento >= '22:00';

-- 7) Criar uma consulta que liste quais ingredientes estão vencidos.

SELECT * FROM ingrediente WHERE current_date() > data_validade;

-- 8) Criar relacionamentos entre as tabelas:
--    Uma cozinha pode ter mais de um ingrediente.
--    Uma cozinha também pode ter mais de um funcionário.
--    Alterar o banco para possibilitar estes relacionamentos.

CREATE TABLE ingredientes_cozinha (
    id_cozinha INT,
    id_ingrediente INT
);

CREATE TABLE funcionarios_cozinha (
    id_cozinha INT,
    id_funcionario INT
);

INSERT INTO ingredientes_cozinha
VALUES (1, 9), (1, 10), (1, 15), (2, 11), (2, 12), (2, 14), (2, 16), (3, 13),
(3, 12), (3, 11);

INSERT INTO funcionarios_cozinha
VALUES (1, 1), (1, 6), (2, 7), (2, 2), (3, 3), (3, 5), (1, 7), (2, 8), (3, 9), (1, 10);

-- 9) Criar uma consulta que realize a junção das tabelas Cozinha, 
-- Ingrediente e Funcionario e informe as cozinhas não possuam ingredientes.

SELECT id FROM cozinha c 
    LEFT JOIN ingredientes_cozinha i ON c.id = i.id_cozinha
    WHERE i.id_cozinha IS NULL;

-- 10) Criar uma consulta que realize a junção das tabelas Cozinha, Ingrediente e Funcionario
--  e informe as cozinhas que possuam número de funcionários maior que 4;

SELECT c.id FROM cozinha c
    JOIN funcionarios_cozinha HAVING count(id_funcionario) >= 4;
