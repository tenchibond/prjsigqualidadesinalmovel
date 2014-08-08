<%@page import="entidades.DadosQualidade"%>
<%@page import="daos.DaoDadosQualidade"%>
<%@page import="entidades.ERB"%>
<%@page import="java.util.ArrayList"%>
<%@page import="daos.DaoERB"%>
<%
	DaoDadosQualidade daoDadosQualidade = new DaoDadosQualidade();
	ArrayList<DadosQualidade> lstDados = daoDadosQualidade.listarDados();
	
%>

<div class="panel panel-default">
	<div class="panel-heading">LISTAGEM DOS DADOS DE QUALIDADE CADASTRADAS NO SISTEMA</div>
	<div class="panel-body">	
		<p>Nesta seção se encontram todas os dados de qualidade inseridos no sistema pelos usuários.</p>
	</div>
	<table class="table table-striped">
		<tr>
			<th><span class="glyphicon glyphicon-asterisk"></span></th>
			<th><small>OPERADORA</small></th>
			<th><small>LATITUDE</small></th>
			<th><small>LONGITUDE</small></th>
			<th><small>INTENSIDADE DO SINAL</small></th>
			<th><small>LIGAÇÃO INTERROMPIDA?</small></th>
			<th><small>LIGAÇÃO NAO COMPLETA?</small></th>
			<th><small>LIGAÇÃO COM RUÍDO?</small></th>
			<th><small>SEM DADOS MÓVEIS?</small></th>
		</tr>
		<%
			for(DadosQualidade dados : lstDados) {
				%>
				<tr>
					<td><small><%= dados.getId() %></small></td>
					<td><small><%= dados.getOperadora().toUpperCase() %></small></td>
					<td><small><%= dados.getLatitude() %></small></td>
					<td><small><%= dados.getLongitude() %></small></td>
					<td><small><%= dados.getIntensidadeSinal() %></small></td>
					<td><small><%= dados.isLigacaoInterrompida() ? "SIM" : "NAO" %></small></td>
					<td><small><%= dados.isLigacaoNaoCompleta() ? "SIM" : "NAO" %></small></td>
					<td><small><%= dados.isLigacaoComRuido() ? "SIM" : "NAO" %></small></td>
					<td><small><%= dados.isSemDadosMoveis() ? "SIM" : "NAO" %></small></td>
				</tr>
				<%
			}
		%>
	</table>
</div>