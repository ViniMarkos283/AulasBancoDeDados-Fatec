/* script da atv 10 */
create table departamento (
 idDepto integer not null primary key ,
 nomeDepto varchar(15) not null,
 gerente integer not null,
 divisao varchar(10) not null,
 local varchar(15) not null)
insert departamento (iddepto, nomedepto, gerente, divisao, local)
 values(1,'RH', 1, 'Adm', 'Diadema')
 insert departamento (iddepto, nomedepto, gerente, divisao, local)
 values(2,'C.Rec.', 3, 'Adm', 'Diadema')
 insert departamento (iddepto, nomedepto, gerente, divisao, local)
 values(3,'CP', 2, 'Adm', 'Diadema')
create table Empregado
(
 IdEmpregado integer NOT NULL,
 NomeEmpregado varchar(20) NOT NULL,
 IdDepto integer NOT NULL,
 Cargo varchar(6) NOT NULL,
 Tempo_Emp integer NULL,
 Salario decimal(10,2) NULL,
 Comissao decimal(10,2) NULL
 PRIMARY KEY (IdEmpregado)
)
insert into empregado (idempregado, nomeempregado, iddepto, cargo, tempo_emp,
salario, comissao)
values (1, 'Marcos', 1, 'Prof', 10, 1800.00, 10)
insert into empregado (idempregado, nomeempregado, iddepto, cargo, tempo_emp,
salario, comissao)
values (2, 'Maria', 1, 'Aux.', 1, 1500.00, 10)
insert into empregado (idempregado, nomeempregado, iddepto, cargo, tempo_emp,
salario, comissao)
values (3, 'Juliana', 2, 'Aux.', 1, 1500.00, 10)


/* exe 82 */
CREATE procedure p_DepartamentoUpdate(
@iddepto int,
@nomedepto varchar(15),
@gerente int,
@divisao varchar(10),
@local varchar(15)
)AS
update departamento set
iddepto = @iddepto,
 nomedepto = @nomedepto,
 gerente = @gerente,
 divisao = @divisao ,
 local = @local
where iddepto = @iddepto

execute p_DepartamentoUpdate 1, 'RH', 3, 'ADM', 'Mauá'

/* exe 83 */
create procedure p_DepartamentoDelete (
  @iddepto int
)
AS
declare @totaldepartamentos as int
delete from departamento WHERE iddepto = @iddepto
SELECT @totaldepartamentos = count(*) from departamento
select @totaldepartamentos

execute p_DepartamentoDelete 2

select * from departamento

/* exe 84 */
create procedure p_empregadoInsert(
@idempregado int,
@nomeempregado varchar(20),
@iddepto int,
@cargo varchar(5),
@tempo_emp int,
@salario decimal(10,2),
@comissao decimal(10,2)
)
as
declare @totalempregados as int
insert into Empregado 
(idempregado, nomeempregado, iddepto, cargo, tempo_emp, salario, comissao)
values(@idempregado, @nomeempregado, @iddepto, @cargo, @tempo_emp, @salario, @comissao)
SELECT @totalempregados = count(*) from Empregado
select @totalempregados

execute p_empregadoInsert 4, 'Junin', 3, 'Pedreiro', 6, 2200.00, 50.00

select * from Empregado

/* exe 85 */
create procedure p_empregadoUpdate(
@idempregado int,
@nomeempregado varchar(20),
@iddepto int,
@cargo varchar(5),
@tempo_emp int,
@salario decimal(10,2),
@comissao decimal(10,2)
)
as
update Empregado set
idempregado = @idempregado,
 nomeempregado = @nomeempregado,
 iddepto = @iddepto,
 cargo = @cargo,
 tempo_emp = @tempo_emp,
 salario = @salario,
 comissao = @comissao
where idempregado = @idempregado

/* exe 86 */
create procedure p_empregadoDelete (
  @idempregado int
)
AS
declare @totalempregados as int
delete from Empregado WHERE idempregado = @idempregado
SELECT @totalempregados = count(*) from Empregado
select @totalempregados

execute p_empregadoDelete 2


/* exe 87 */
create procedure p_empregadoSelect
as
SELECT * from Empregado

execute P_empregadoSelect