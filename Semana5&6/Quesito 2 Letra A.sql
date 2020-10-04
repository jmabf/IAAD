create schema BD_Startup;
use BD_Startup;

create table Startup(
	id_startup varchar(2) not null,
	nome_startup varchar(50) not null,
    primary key(id_startup));
    
create table Linguagem_Programacao(
	id_linguagem varchar(10) not null,
    linguagem varchar(10) not null,
    primary key(id_linguagem));
    
create table Programador(
	id_programador varchar(2) not null,
    id_startup varchar(2) not null,
    nome_programador varchar(50) not null,
    primary key(id_programador));
    
create table Programador_Linguagem(
	id_programador varchar(2) not null,
    id_linguagem varchar(10) not null,
    primary key(id_programador,id_linguagem));
    
insert into Startup values
	('1','Startup 1'),
	('2','Startup 2'),
	('3','Startup 3'),
	('4','Startup 4'),
	('5','Startup 5'),
	('6','Startup 6');
 
insert into Programador values
	('1','1','João'),
    ('2','2','Paula'),
    ('3','3','Renata'),
    ('4','4','Felipe'),
    ('5','4','Ana'),
    ('6','1','Alexandre');
    
insert into linguagem_programacaoid_linguagem values
	('1','Python'),
    ('2','PHP'),
    ('3','Java'),
    ('4','Swift'),
    ('5','C#'),
    ('6','JavaScript');
    
insert into Programador_Linguagem values
	('1','1'),
    ('1','2'),
    ('2','3'),
    ('3','4'),
    ('3','5'),
    ('4','6');
    
alter table Programador add foreign key(id_startup) references Startup(id_startup);
alter table Programador_Linguagem add foreign key(id_programador) references Programador(id_programador);
alter table Programador_Linguagem add foreign key(id_linguagem) references Linguagem_Programacao(id_linguagem);    
 