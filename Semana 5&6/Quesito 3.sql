-- letra A
use empresa_seunome;
select d.dnome, COUNT(f.cpf) from funcionario as f join departamento as d on f.dnr=d.dnumero GROUP BY dnr
HAVING AVG(Salario) > 30000;

-- letra B
SELECT d.dnome, COUNT(f.Cpf)
FROM funcionario as f
JOIN departamento as d
ON d.Dnumero = f.Dnr
WHERE f.Salario> 30000 AND f.Sexo = 'M'
GROUP BY dnr;


-- letra C
select Pnome from funcionario
where Dnr = (select Dnr from funcionario where salario = 
(select max(salario) from funcionario));

-- letra D
select Pnome, cpf_supervisor from funcionario 
where cpf_supervisor in (select cpf from funcionario where cpf_supervisor = 88866555576);

-- letra E 
select Pnome from funcionario where salario >= (select min(salario) from funcionario) + 10000;

-- letra F 
create view viewqualquer as select d.Dnome, f.Pnome, f.salario from departamento as d
inner join funcionario as f
on d.cpf_gerente = f.cpf;


-- letra H 
create view viewqualquer as select p.Projnome, d.Dnome, count(f.cpf), sum(t.horas) from projeto as p
left join departamento as d
on d.Dnumero = p.Dnum
inner join funcionario as f
on f.dnr = d.Dnumero
inner join trabalha_em as t
on t.Fcpf = f.cpf 
group by Projnome;

-- letra I 
create view viewqualquer as select p.Projnome, d.Dnome, count(f.cpf), sum(t.horas) from projeto as p
left join departamento as d
on d.Dnumero = p.Dnum
inner join funcionario as f
on f.dnr = d.Dnumero
inner join trabalha_em as t
on t.Fcpf = f.cpf 
group by Projnome having count(f.cpf) > 1;

-- letra J
	-- Primeiro
select dnr, count(cpf), sum(salario), AVG(salario) from
funcionario group by dnr;

	-- Segundo
select dnr, count(cpf) from funcionario group by dnr having sum(salario) > 100000;
	
    -- Terceiro
select dnr, avg(salario) from funcionario 
group by dnr
having count(cpf) > (select count(*) from funcionario where dnr = 4);