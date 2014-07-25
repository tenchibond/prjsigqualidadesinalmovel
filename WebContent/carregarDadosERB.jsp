<h1>Carregar ERBS</h1>
<%

%>

<form method="post" action="UploadServlet" enctype="multipart/form-data">
	<fieldset>
		<label for="txArquivos">Arquivo:</label>
		<input type="file" name="arquivo" id="txArquivo" />
		<input type="submit" value="Carregar arquivos" />
	</fieldset>
</form>