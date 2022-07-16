CREATE DATABASE mod3;
USE mod3;

CREATE TABLE cursos (
	id int auto_increment primary key,
    nome varchar(100) NOT NULL,
    tipo varchar(100) NOT NULL  
);

CREATE TABLE turmas (
	id int auto_increment primary key,
	numero int NOT NULL,
    nome_turma varchar(100) NOT NULL,
    cursos_id int NOT NULL,
    foreign key (cursos_id) references cursos(id)
);

CREATE TABLE alunos (
	id int auto_increment primary key,
    cpf varchar(14) NOT NULL,
    nome varchar(100) NOT NULL,
    data_nascimento date NOT NULL,
    turmas_id int NOT NULL,
    foreign key (turmas_id) references turmas(id)
); 

CREATE TABLE entregas (
	aluno_id int NOT NULL,
    modulo int NOT NULL,
	link_repositorio varchar(150) NOT NULL,
    conceito varchar(50),
    foreign key (aluno_id) references alunos(id)
);

ALTER TABLE alunos 
ADD email varchar(255) NOT NULL;

INSERT INTO cursos (nome, tipo) VALUES 
('Front-End', 'Online'),
('Back-End', 'Online'), 
('DevOps', 'Presencial');


INSERT INTO turmas (numero, nome_turma, cursos_id) VALUES
(10, 'turma front end 1', 1),
(15, 'turma back end 1', 2),
(20, 'turma devops 1', 3);


INSERT INTO alunos (cpf, nome, data_nascimento, turmas_id, email) VALUES
('000.000.000-00', 'Gabriel Alves', '2003-10-14', 2, 'GabrielAlves@gmail.com'),
('111.111.111-11', 'Magnus Arthur', '2002-02-21', 1, 'MagnusArthur@gmail.com'),
('222.222.222-22', 'Bruna Xavier', '2000-02-05', 3, 'BrunaXavier@gmail.com'),
('333.333.333-33', 'Bruno Birth', '1999-02-18', 3, 'BrunoBirth@gmail.com');


INSERT INTO entregas VALUES
(1, 3, 'https://website.com.br/', 'Mais que pronto'),
(2, 3, 'https://website.com.br/', 'Mais que pronto'),
(3, 3, 'https://website.com.br/', 'Pronto'),
(4, 3, 'https://website.com.br/', 'Pronto');


-- Query 1
SELECT * FROM entregas
	WHERE modulo = 1 AND conceito = 'Mais que pronto';
    
-- Query 2
SELECT turmas_id AS turma, COUNT(turmas_id) AS alunos_na_turma FROM alunos
	GROUP BY turmas_id;
    
-- Query 3
SELECT COUNT(conceito) AS quantidade_de_projetos FROM entregas
	WHERE conceito = 'Ainda não está pronto' OR conceito = 'Chegando lá';
    
-- Query 4
SELECT turmas_id AS turma, count(conceito) AS quantidade_de_projetos FROM alunos
	INNER JOIN entregas ON alunos.id = entregas.aluno_id
    WHERE conceito = 'Mais que pronto'
    GROUP BY turmas_id
    ORDER BY quantidade_de_projetos DESC
    LIMIT 1; 