USE IgrejaBD
GO

-- DÚVIDA
CREATE PROCEDURE AdicionarUsuario_Validacao
	@Procedure_nome VARCHAR(200) NULL,
	@Procedure_DtaNasc DATETIME NULL,
	@Procedure_CPF NUMERIC(11,0) NULL,
	@Procedure_MsgRetorno VARCHAR(MAX) = ' ' OUTPUT
AS
BEGIN

-- DÚVIDA
DECLARE @Retorno INT = 0,
	@MsgError VARCHAR(MAX) = ''

-- VERIFICAR SE A QUANDIDADE DE CARACTERES É MAIOR QUE 0 
IF(LEN(ISNULL(@Procedure_nome, '')) = 0)BEGIN
	SET @MsgError = @MsgError + ' Nome deve possuir entre 1 e 15 caracteres!'
	SET @Retorno = @Retorno + 1 
END
-- VERIFICAR  SE A QUANTIDADE DE CARACTERES É MENOR QUE 15
ELSE IF(LEN(@Procedure_nome) <= 15) BEGIN
	SET @MsgError = @MsgError + ' Nome deve possuir entre 1 e 15 caracteres!'
	SET @Retorno = @Retorno + 1
END

SET @Procedure_MsgRetorno = @MsgError
RETURN @Retorno

END
GO