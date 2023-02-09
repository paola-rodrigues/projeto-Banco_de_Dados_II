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

CREATE TABLE Alocacao(
	id_professor SERIAL,
	id_curso SERIAL,
	dia_da_semana enum_dia_da_semana,
	horario time not null,
	foreign key(id_professor) references professor(id_professor),
	foreign key(id_curso) references curso(id_curso),
	primary key (id_professor, id_curso, dia_da_semana, horario)
);


SAVEPOINT ponto_de_backup; -- Criando um ponto de salvamento para backup
BEGIN; -- inicializar uma transação

--  Crias os INSERTS das Tabelas
INSERT INTO departamentos (nome)
	values ('medicina'),
	('farmácia'),
	('ciências biologicas'),
	('tecnologia da informação'),
	('engenharia'),
	('cultural'),
	('esportes')
	;

INSERT INTO curso (nome)
	VALUES ('algebra'),
	('Introducao a programacao'),
	('quimica'),
	('sociologia'),
	('filosofia'),
	('música'),
	('lógica de programação'),
	('física'),
	('geometria'),
	('física quântica'),
	('banco de dados'),
	('banco de dados 2'),
	('inteligencia artifical')
	;

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
	('Valeria Carvalho','45145696371', 2),
	('rosangela neves','83420102312', 4),
	('marcos dos santos','78965414785',4),
	('janderson felipe','21356483407',4),
	('jonathan salustiano','23498756743',4),
	('felipe caldas', '89785245632', 4),
	('felipe carreras', '12897346520', 4),
	('yuri romão', '53426789142',5),
	('bartô galeno', '56756438792',6),
	('fernando santos','58484489648',6),
	('fabio maranhão','70346252129',6),
	('marcos filho','70856483417',6),
	('boro baratheon', '70125456339',6),
	('geraldo de rivia','11122255536',6),
	('lucas angeelus','18798767789',7),
	('leo santana','27896547321',7),
	('paulo rubens','56423189773',7),
	('oziel melo','85263941791',7),
	('ronaldo alves','47358196223',7),
	('lucas moura','78145976238',7),   
	('cristiano ronaldo','77700033352',7),
	('maysa figueroa','19594875230',5),
	('rhuann pontes','78412354875',5),
	('raldney alves','38767788890',5),
	('yuri gabriel','65677489376',5)
;

INSERT INTO alocacao (id_professor,id_curso,dia_da_semana,horario)
	VALUES (1,1, 'quarta','19:00:00'),
	(2,1,'sexta', '19:00:00'),
	(27,12,'quarta','10:00;00'),
	(28,11,'quarta','12:00:00'),
	(1,3,'quinta','10;00:00'),
	(3,4,'quinta','12:00:00'),
	(3,5,'segunda','08:00:00'),
	(3,6,'terca','10:30:00'),
	(5,3,'quinta','12:00:00'),
	(5,4,'sexta','08:00:00'),
	(5,5,'segunda','17:00:00'),
	(48,1,'quarta','12:00:00'),
	(48,8,'quarta','14:00:00'),
	(48,9,'quarta','17:00:00'),
	(41,4,'quinta','13:00:00'),
	(41,5,'quinta','16:00:00'),
	(41,8,'sexta','19:00:00'),
	(9,3,'quinta','08:00:00'),
	(9,4,'terca','13:00:00'),
	(9,8,'quarta','17:00:00')
; 
EXCEPTION
COMMIT; -- Confirma todas as operações

-- Cria um Index para a Coluna 'horario' na Tabela 'Alocacao'

CREATE INDEX alocação_horario_index ON alocacao (horario)

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
