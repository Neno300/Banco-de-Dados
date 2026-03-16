create database empresa;
use empresa;

create table funcionarios (
id int auto_increment primary key,
nome varchar (100) not null,
cargo varchar (50),
salario decimal (10,2),
data_admissao date
);

create table departamentos (
id int auto_increment primary key,
nome varchar (50) not null,
localizacao varchar(50)
);

insert into funcionarios (nome, cargo, salario, data_admissao, departamento_id)
values ('Carlos Silva', 'Analista', 4500.00, '2023-06-15', 1), 
('Maria Eduarda', 'Desenvolvedora', 5000.00, '2023-02-16', 2),
('Gabriel Ferreira', 'Suporte', 4500.00,'2024-07-20', 3);


insert into departamentos (nome, localizacao)
values ('TI', 'São Paulo'), 
('RH', 'Rio de Janeiro'), 
('Financeiro', 'Curitiba');

alter table funcionarios add departamento_id int;
alter table funcionarios add foreign key (departamento_id)
references departamentos(id);

select funcionarios.nome, funcionarios.cargo, departamentos.nome as departamento
from funcionarios
inner join departamentos on funcionarios.departamento_id = departamentos.id;

create table projetos (
id int auto_increment primary key,
nome varchar(100) not null,
orcamento decimal(10,2),
data_inicio date,
departamento_id int,
foreign key (departamento_id) references departamentos(id)
);

insert into projetos (nome, orcamento, data_inicio, departamento_id)
values ('Sistemas ERP', 50000.00, '2023-07-01' , 1),
('Recrutamento Digital', 15000.00, '2023-08-15', 2),
('Automatização Financeira', 30000.00, '2023-09-10', 3);

select projetos.nome, projetos.orcamento, departamentos.nome as departamento
from projetos
inner join departamentos on projetos.departamento_id = departamentos.id;

create table equipe (
id_equip int auto_increment primary key,
id_funcionario int,
id_projeto int,
funcao varchar(50),
foreign key (id_funcionario) references funcionarios(id),
foreign key (id_projeto) references projetos(id)
);

create table tarefa (
id_tarefa int auto_increment primary key,
descricao varchar(255) not null,
prazo date,
status enum ('Pendente', 'Em andamento', 'Concluida') default 'Pendente',
id_funcionario int,
id_projeto int,
foreign key (id_funcionario) references funcionarios(id),
foreign key (id_projeto) references projetos(id)
);

create table cliente (
id_cliente int auto_increment primary key,
nome varchar(100) not null,
contato varchar(50),
email varchar(100)
);

create table contrato (
id_contrato int auto_increment primary key,
id_cliente int,
id_projeto int,
data_assinatura date,
valor decimal (12,2),
foreign key (id_cliente) references cliente(id_cliente),
foreign key (id_projeto) references projetos(id)
);

insert into equipe (funcao, id_funcionario, id_projeto) 
values ('Desenvolvimento de software', 1, 1), ('Contratação', 2, 2), ('Suporte ao cliente', 3 , 3);

insert into tarefa (descricao, prazo, id_projeto, id_funcionario)
values ('Sistema ERP', '2026-09-22', 1, 1),
('Recrutamento', '2026-10-23', 2, 2),
('Automatização financeira da empresa', '2026-12-31', 3, 3);

insert into cliente (nome, contato, email)
values ('Gabriel Santos', '1698174-9898', 'gabriel.s@gmail.com'),
('Carla DeMarco', '1197766-5544', 'carla.dm@gmail.com'),
('Leon S. Kennedy', '1294545-2323', 'leonkennedy@gmail.com');

insert into contrato (data_assinatura, valor, id_cliente, id_projeto)
values ('2026-01-01', 50000.00, 1, 1), ('2026-02-02', 55000.00, 2, 2), ('2026-03-03', 60000.00, 3, 3);

alter table cliente add id_projeto int;
update cliente set id_projeto = 1 where id_cliente = 1;
update cliente set id_projeto = 2 where id_cliente = 2;
update cliente set id_projeto = 3 where id_cliente = 3;

alter table funcionarios add id_projeto int;
update funcionarios set id_projeto = 1 where id = 1;
update funcionarios set id_projeto = 2 where id = 2;
update funcionarios set id_projeto = 3 where id = 3;

delete from contrato where valor < 55000.00 and id_contrato = 1;
delete from equipe where id_equip = 6;
delete from tarefa where id_tarefa = 9;
delete from funcionarios where id = 3;

delete from cliente where id_cliente = 1;

select * from funcionarios;

select * from projetos where orcamento > 20000.00;

select nome, cargo, salario
from funcionarios
where salario > 4000
order by salario desc;

select * from departamentos order by nome;
select * from funcionarios where data_admissao > '2022-01-01';

update funcionarios set salario = 4000.00 where id = 3;
update departamentos set nome = 'Desenvolvimento' where id = 2;
update departamentos set nome = 'Suporte' where id = 3;
select * from departamentos;
select * from tarefa;
select * from equipe;
select* from cliente;
select * from contrato;