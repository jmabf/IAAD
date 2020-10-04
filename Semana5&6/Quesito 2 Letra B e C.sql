-- LETRA B

-- I. Listar os nomes de todos os programadores e os nomes das respectivas startups em que eles trabalham.
-- Apresentar a consulta de três formas: junção na cláusula where,
-- conexão interna (inner join) e junção natural.

-- where
use BD_startup;
select p.id_programador, s.nome_startup from programador as p, startup as s
where s.id_startup = p.id_startup;

-- inner join
use bd_startup;
select p.id_programador, s.nome_startup from programador as p inner join startup as s
where s.id_startup = p.id_startup;

-- junção natural
use bd_startup;
select p.id_programador, s.nome_startup from programador as p natural join startup as s
where s.id_startup = p.id_startup;



-- II. Listar os nomes dos programadores e das linguagens em que eles programam,
-- mas apenas os programadores que programam em pelo menos uma linguagem de programação cadastrada no BD_Startup.
use bd_startup;
select p.nome_programador, lp.linguagem from programador as p inner join programador_linguagem as pl, linguagem_programacao as lp
where lp.id_linguagem = pl.id_linguagem and p.id_programador = pl.id_programador;

-- III. Listar os nomes dos programadores e das linguagens em que eles programam.
-- Observação: se o programador não estiver associado a nenhuma das linguagens de programação cadastradas
-- no BD_Startup, no resultado da consulta deve constar null no nome da linguagem de programação.

-- ERRADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
use bd_startup;
select p.nome_programador, lp.linguagem from programador as p 
right join programador_linguagem as pl
on p.id_programador = pl.id_programador
inner join linguagem_programacao as lp 
on lp.id_linguagem = pl.id_linguagem;

-- IV. Listar os nomes dos programadores que não programam nas linguagens cadastradas
-- no BD_Startup (observação: esses programadores programam outras LP, por exemplo C++, Ruby, Scala etc.)
use bd_startup;
select p.nome_programador from programador as p join programador_linguagem as pl
where p.id_programador = pl.id_programador and pl.id_linguagem = null;

-- V. Listar os nomes de todas as startups e seus programadores
-- independentemente se a startup tem ou não programadores
use bd_startup;
select s.nome_startup, p.nome_programador from startup as s left join programador as p
on s.id_startup = p.id_startup;

-- VI. Listar os nomes das startups que estão sem programadores.
use bd_startup;
select distinct s.nome_startup from startup as s join programador as p
where s.id_startup not in(select p.id_startup from programador as p);





-- LETRA C

USE BD_STARTUP;

SELECT * 
FROM startup as s
LEFT JOIN programador as p
ON s.id_startup = p.id_startup
UNION
SELECT *
FROM startup as s
RIGHT JOIN programador as p
ON s.id_startup = p.id_startup;
