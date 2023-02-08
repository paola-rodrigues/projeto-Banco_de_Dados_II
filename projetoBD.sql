-- Database: Projetobd

-- DROP DATABASE IF EXISTS "Projetobd";

CREATE DATABASE "Projetobd"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

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

--  INSERTS

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
VALUES ('matheus','11122233344', 3),
('lucas','22233344455', 1),
('clovis', '33344455566', 1);

INSERT INTO alocação (id_professor,id_curso,dia_da_semana,horario)
VALUES (2, 1, 'quarta','19:00:00'),
(3, 2, 'sexta', '19:00:00');

-- Index

CREATE INDEX alocação_horario_index ON alocação (horario)

-- Teste

SELECT * FROM alocação;