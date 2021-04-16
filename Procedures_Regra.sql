USE IgrejaBD
GO

CREATE PROCEDURE InserirUsuario
	@Procedure_UsuarioID INT = NULL OUTPUT,
	@Procedure_nome VARCHAR(200),
	@Procedure_DtaNasc DATETIME,
	@Procedure_CPF NUMERIC(11,0)
AS
BEGIN

DECLARE @Retorno INT = 0

INSERT INTO IgrejaBD.dbo.usuario (nome, dtanascimento, cpf) VALUES (@Procedure_nome, @Procedure_DtaNasc, @Procedure_CPF)
SET @Procedure_UsuarioID = @@IDENTITY

SET @Retorno = @@ERROR

RETURN @Retorno
END
GO