<%@page import="entidades.ERB"%>
<%@page import="java.util.ArrayList"%>
<%@page import="daos.DaoERB"%>
<%
	DaoERB daoERB = new DaoERB();
	ArrayList<ERB> lstERBS = daoERB.listarERBS();
%>

<div class="panel panel-default">
	<div class="panel-heading">LISTAGEM DAS ERBS CADASTRADAS NO SISTEMA</div>
	<div class="panel-body">	
		<p>Nesta seção se encontram todas as estações rádio-base cadastradas no sistema.</p>
	</div>
	<table class="table table-striped">
		<tr>
			<th><span class="glyphicon glyphicon-asterisk"></span></th>
			<th><small>OPERADORA</small></th>
			<th><small>NÚMERO ESTAÇÃO</small></th>
			<th><small>NOME</small></th>
			<th><small>UF</small></th>
			<th><small>MUNICÍPIO</small></th>
			<th><small>BAIRRO</small></th>
			<th><small>LOGRADOURO</small></th>
			<th><small>LATITUDE</small></th>
			<th><small>LONGITUDE</small></th>
		</tr>
		<%
			for(ERB erb : lstERBS) {
				%>
				<tr>
					<td><%= erb.getId() %></td>
					<td><small>
						<%
							if(erb.getOperadora().equalsIgnoreCase("tnl")) {
								out.println("OI");
							} else {
								out.println(erb.getOperadora().toUpperCase());
							}
						%>
					</small></td>
					<td><small><%= erb.getEstacao() %></small></td>
					<td><small><%= erb.getNome().toUpperCase() %></small></td>
					<td><small><%= erb.getUf().toUpperCase() %></small></td>
					<td><small><%= erb.getMunicipio().toUpperCase() %></small></td>
					<td><small><%= erb.getBairro().toUpperCase() %></small></td>
					<td><small><%= erb.getLogradouro().toUpperCase() %></small></td>
					<td><small><%= erb.getLatitude() %></small></td>
					<td><small><%= erb.getLongitude() %></small></td>
				</tr>
				<%
			}
		%>
	</table>
</div>