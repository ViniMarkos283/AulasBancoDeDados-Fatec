# questao 75
CREATE FUNCTION dbo.f_MesExtenso(@mes INT)
RETURNS VARCHAR(20)
AS
BEGIN 
    DECLARE @mes_extenso VARCHAR(20)
    IF (@mes) = 1 SET @mes_extenso = 'Janeiro'
    ELSE IF (@mes) = 2 SET @mes_extenso = 'Fevereiro'
    ELSE IF (@mes) = 3 SET @mes_extenso = 'Março'
    ELSE IF (@mes) = 4 SET @mes_extenso = 'Abril'
    ELSE IF (@mes) = 5 SET @mes_extenso = 'Maio'
    ELSE IF (@mes) = 6 SET @mes_extenso = 'Junho'
    ELSE IF (@mes) = 7 SET @mes_extenso = 'Julho'
    ELSE IF (@mes) = 8 SET @mes_extenso = 'Agosto'
    ELSE IF (@mes) = 9 SET @mes_extenso = 'Setembro'
    ELSE IF (@mes) = 10 SET @mes_extenso = 'Outubro'
    ELSE IF (@mes) = 11 SET @mes_extenso = 'Novembro'
    ELSE IF (@mes) = 12 SET @mes_extenso = 'Dezembro'
    ELSE SET @mes_extenso = 'Mês Inválido'
    RETURN @mes_extenso
END

# questao 76
create function dbo.f_DiaSemanaExtenso (@dia int)
returns varchar(20)
AS
BEGIN
declare @diaExtenso varchar(20)
if(@dia) = 1 set @diaExtenso = 'Domingo'
ELSE if(@dia) = 2 set @diaExtenso = 'Segunda'
ELSE if(@dia) = 3 set @diaExtenso = 'Terça'
ELSE if(@dia) = 4 set @diaExtenso = 'Quarta'
ELSE if(@dia) = 5 set @diaExtenso = 'Quinta'
ELSE if(@dia) = 6 set @diaExtenso = 'Sexta'
ELSE if(@dia) = 7 set @diaExtenso = 'Sabado'
else set @diaExtenso = 'dia inválido'
RETURN @diaExtenso
END

select dbo.f_DiaSemanaExtenso(6)

# questao 77
create function dbo.f_ParOuImpar(@numero int)
returns varchar(10)
AS
BEGIN
DECLARE @resultado varchar(10)
IF @numero % 2 = 0 set @resultado = 'Par'
ELSE set @resultado = 'Impar'
RETURN @resultado
END

select dbo.f_ParOuImpar(90)

# questao 78
CREATE FUNCTION dbo.f_Percentual (@valor decimal(10,2), @perc decimal(5,2)) 
RETURNS decimal(10,2)
AS
BEGIN
DECLARE @retorno decimal(10,2)
set @retorno = (@valor * @perc)/100
return @retorno
END

select dbo.f_Percentual(500, 25)

# questão 79
CREATE FUNCTION dbo.f_UltimoNome (@nome varchar(200))
RETURNS varchar(200)
AS
BEGIN
DECLARE @ultNome varchar(20)
DECLARE @ultSpace int
set @ultNome = REVERSE(@nome)
set @ultSpace = CHARINDEX(' ', @ultNome)
SET @ultNome = REVERSE(SUBSTRING(@ultNome, 1, @ultSpace - 1))
return @ultNome
END

select dbo.f_UltimoNome('Monkey D. Luffy')