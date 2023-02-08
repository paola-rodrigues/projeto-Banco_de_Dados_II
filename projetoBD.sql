-- Database: Projetobd

-- DROP DATABASE IF EXISTS "Projetobd";


--  Cria o Banco de Dados
CREATE DATABASE "Projetobd"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

--  Cria as Tabelas
CREATE TABLE Departamentos(
	id_departamento SERIAL PRIMARY KEY,
	nome varchar(45) not null
);

CREATE TABLE Curso(
	id_curso SERIAL PRIMARY KEY,
	nome varchar(45) not null
);

CREATE TABLE professor(
	id_professor SERIAL PRIMARY KEY,
	nome varchar(45) not null,
	cpf varchar (11) not null,
	id_departamento int,
	foreign key(id_departamento) references departamentos(id_departamento)
);

-- Cria a ENUM para usar na tabela Alocação OBS: Particularidade do PostgreSQL
CREATE TYPE enum_dia_da_semana AS ENUM ('segunda','terca','quarta','quinta','sexta','sabado','domingo');

CREATE TABLE Alocação(
	id_professor SERIAL,
	id_curso SERIAL,
	dia_da_semana enum_dia_da_semana,
	horario time not null,
	foreign key(id_professor) references professor(id_professor),
	foreign key(id_curso) references curso(id_curso),
	primary key (id_professor, id_curso, dia_da_semana, horario)
);

--  Crias os INSERTS das Tabelas

INSERT INTO departamentos (nome)
	values ('Exatas'),
	('naturezas'),
	('Humanas');

INSERT INTO curso (nome)
	VALUES ('algebra'),
	('Introducao a programacao'),
	('quimica'),
	('sociologia');

INSERT INTO professor (nome,cpf,id_departamento)
	VALUES ('matheus silva','11122233344', 3),
	('lucas rodrigues','22233344455', 1),
	('clovis silva', '33344455566', 1),
	('lucas nascimento','22233344455', 1),
	('allan arruda', '13300170009', 2),
	('filipe costa','06135221110', 2),
	('angelica casagrande','26948614325', 1),
	('carlos henrique','36715106101',2),
	('gustavo albuquerque','91005598122',2),
	('gustavo banhos','90010907920',3),
	('isaac maia','00726444961', 1),
	('jose neto','09921025006', 1),         
	('jose augusto','06662625251', 1),      
	('lidenberg rodrigues','04464260136', 1), 	   
	('bruna bezerra','14456724776', 2),
	('mara oliveira','14030098039', 2),
	('mateus bandeira','32945645640', 3),
	('marleton bandeira','50760138109', 1), 
	('mariana bandeira','27105177916', 3),           
	('maria bandeira','80184590721', 1),  	       
	('natália aguiar','70901165411', 2),
	('raiane silva','70605114761', 2),  
	('raquel silva','06705114761', 2),   
	('suzana silva','09165615955', 2),             
	('Tales Carvalho','72345695107', 2),           
	('Thiago Carvalho','51045625856', 2),  
	('Valeria Carvalho','45145696371', 2) 
;

INSERT INTO alocação (id_professor,id_curso,dia_da_semana,horario)
	VALUES (2, 1, 'quarta','19:00:00'),
	(3, 2, 'sexta', '19:00:00');

-- Cria um Index para a Coluna 'horario' na Tabela 'Alocação'

CREATE INDEX alocação_horario_index ON alocação (horario)

-- Cria uma View para a Tabela professor

CREATE VIEW view_professor AS SELECT * FROM professor;

-- Cria uma Usuário com autorização apenas de ver os cursos

CREATE USER estudante WITH PASSWORD 'estudante';
GRANT SELECT ON curso TO estudante;

-- Teste

-- Muda para o usuário estudante
SET ROLE 'estudante';

-- O SELECT não funciona com uma tabela não autorizada
SELECT nome, cpf FROM view_professor;

-- O SELECT funciona com uma tabela autorizada
SELECT * FROM curso;