<h1>Carregar ERBS</h1>
<%
	out.println("Carrega dentro do banco de dados da aplica��o as informa��es sobre esta��es r�dio-base alocadas no estado do Maranh�o");

%>

<form method="post" action="UploadServlet" enctype="multipart/form-data">
	<fieldset>
		<label for="txArquivos">Arquivo:</label>
		<input type="file" name="arquivo" id="txArquivo" />
		<input type="submit" value="Carregar arquivos" />
	</fieldset>
</form>