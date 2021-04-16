-- Stored Procedures -> Diferente das Views que encapsulam somente instruções SELECT, as procerues podem incluir
-- uma gama mais ampla de instruções SQL como UPDATE, INSERT e DELETE.
-- Também pode ser usadas instruções de lógica de processamento, controle de fluxos, testes condicionais, variáveis
-- e instruções para tratamentos de erros na execuçao da procedure.

USE AdventureWorks2019
GO

-- Procedure sem Parâmetros
CREATE PROCEDURE SP_Clientes_Australia AS
BEGIN
	SELECT CustomerID, AccountNumber
	FROM Sales.Customer
	WHERE TerritoryID IN(
							SELECT TerritoryID
							FROM Sales.SalesTerritory
							WHERE Name = 'Australia'
						)
	ORDER BY CustomerID DESC
END;
GO

-- Chamando a Procedure
EXEC SP_Clientes_Australia;
GO

-- Procedure com parâmetros
CREATE PROCEDURE SP_Insere_Departamento
-- Parâmetros de entrada e seus tipos de dados
	-- @DepartmentID SMALLINT -> Não é necessário pois a coluna é do tipo IDENTITY
	@Name NVARCHAR (50),
	@GroupName NVARCHAR (50)
	-- @ModifiedDate DATETIME -> Possui um default que recupera GETDATE()
AS
BEGIN
	-- Exibindo no output os valores que serão inseridos
	PRINT @Name + ' ' + @GroupName;

	-- Inserindo os valores dos parâmetros de entrada na tabela
	INSERT INTO HumanResources.Department
	VALUES (@Name, @GroupName, DEFAULT);
END;
GO

EXEC SP_Insere_Departamento @Name = 'Faxina', @GroupName = 'Servicos Gerais'
GO

-- Verificando a inserção
SELECT *
FROM HumanResources.Department
GO

-- IF/ELSE 
IF 1 = 1
	PRINT 'Verdadeiro'
ELSE
	PRINT 'Falso'
GO

-- IF com SELECT para encontrar determinado registro
IF EXISTS (SELECT *
		   FROM HumanResources.Department
		   WHERE Name = 'EAD')
	PRINT 'Registro Encontrado'
ELSE
	PRINT 'Registro Não Encontrado'
GO


-- IF com comandos DDL
-- Realizando o DROP na Procedure criada anteriormente
IF OBJECT_ID ('SP_CLientes_Australia', 'P') IS NOT NULL
	DROP PROCEDURE SP_Clientes_Australia
ELSE
	PRINT 'Objeto Inexistente'
GO

-- Declaração de Variável
DECLARE @VariavelNome VARCHAR(100)
SET @VariavelNome = 'BootCamp IGTI - Analista de Banco de Dados'
PRINT @VariavelNome
GO

-- WHILE
DECLARE @Variavel1 INT
SET @Variavel1 = 1

While 1 = 1 OR 1 > 0
BEGIN
	PRINT @Variavel1
	SET @Variavel1 = @Variavel1 + 1
END
GO

-- TRY / CATCH com Procedures
-- Erro de resolução de nome não tratado no TRY / CATCH
BEGIN TRY
	SELECT * FROM TabelaInexistente
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_NUMBER() AS ErrorMessage
END CATCH
GO

-- Erro de resolução de nome não tratado no TRY / CATCH
-- Erro ocorre em nível diferente do TRY / CATCH
CREATE PROCEDURE usp_procteste AS
	SELECT *
	FROM TabelaInexistente;
GO

BEGIN TRY
	EXECUTE usp_procteste
END TRY
BEGIN CATCH
	SELECT 
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage
END CATCH
GO