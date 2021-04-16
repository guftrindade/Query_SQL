DECLARE @MensagemRetorno VARCHAR(MAX)
, @Retorno INT

-- @Retorno criado lá na EstudosProcedures?
EXECUTE @Retorno = IgrejaBD.dbo.AdicionarUsuario_Controle
	@Procedure_nome = 'Alonso',
	@Procedure_DtaNasc = '20190919',
	@Procedure_CPF = 12345678912,
	@Procedure_MsgRetorno = @MensagemRetorno OUTPUT

	SELECT Retorno = @Retorno, Mensagem = @MensagemRetorno

	--Transformando o formato de data
	SELECT CONVERT(VARCHAR(10), GETDATE(),112)
