<%@page import="daos.DaoDadosQualidade"%>
<%@page import="entidades.DadosQualidade"%>
<%@page import="entidades.ERB"%>
<%@page import="java.util.ArrayList"%>
<%@page import="daos.DaoERB"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
<script src="http://openlayers.org/api/OpenLayers.js"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?v=3.5&sensor=false"></script>

<script type="text/javascript">
	$(document).ready(function() {
		var domContent = $("#conteudo");
		$(".nav-link").click(function() {
			domContent.load($(this).attr("href"));
			return false;
		});
	});
</script>

<title>SIGmovel - Qualidade do Sinal de Telefonia Móvel</title>
</head>
<body>
<!-- 	INICIO DO CÓDIGO QUE DEFINE A NAVBAR -->
	<nav class="navbar navbar-default" role="navigation">
	  <div class="container-fluid">
	    <!-- Brand and toggle get grouped for better mobile display -->
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand" href="index.jsp">SIGmovel</a>
	    </div>
	
	    <!-- Collect the nav links, forms, and other content for toggling -->
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	      <ul class="nav navbar-nav">
	      	<li class="dropdown">
	    		<a href="#" class="dropdown-toggle" data-toggle="dropdown">TORRES DE TELEFONIA MÓVEL<span class="caret"></span></a>
	    		<ul class="dropdown-menu" role="menu">
	    			<li><a href="principal?acao=erb&operadora=todas">TODAS</a></li>
	    			<li class="divider"></li>
	    			<li><a href="principal?acao=erb&operadora=claro">CLARO</a></li>
	    			<li><a href="principal?acao=erb&operadora=nextel">NEXTEL</a></li>
	    			<li><a href="principal?acao=erb&operadora=oi">OI</a></li>
	    			<li><a href="principal?acao=erb&operadora=tim">TIM</a></li>
	    			<li><a href="principal?acao=erb&operadora=vivo">VIVO</a></li>
	    		</ul>
	      	</li>
	      	<li class="dropdown">
	    		<a href="#" class="dropdown-toggle" data-toggle="dropdown">DADOS DOS USUÁRIOS<span class="caret"></span></a>
	    		<ul class="dropdown-menu" role="menu">
	    			<li><a href="principal?acao=dadosqualidade&operadora=todas">TODOS</a></li>
	    			<li class="divider"></li>
	    			<li><a href="principal?acao=dadosqualidade&operadora=claro">USUÁRIOS CLARO</a></li>
	    			<li><a href="principal?acao=dadosqualidade&operadora=nextel">USUÁRIOS NEXTEL</a></li>
	    			<li><a href="principal?acao=dadosqualidade&operadora=oi">USUÁRIOS OI</a></li>
	    			<li><a href="principal?acao=dadosqualidade&operadora=tim">USUÁRIOS TIM</a></li>
	    			<li><a href="principal?acao=dadosqualidade&operadora=vivo">USUÁRIOS VIVO</a></li>
	    		</ul>
	      	</li>
	      </ul>
	      <ul class="nav navbar-nav navbar-right">
	        <li><a class="nav-link" href="sobre.jsp">SOBRE</a></li>
	        <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown">ADMINISTRATIVO<span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	            <li><a class="nav-link" href="listarERBS.jsp">Listar ERB Cadastradas</a></li>
	            <li><a class="nav-link" href="listarDadosQualidade.jsp">Listar Dados de Qualidade dos Usuários</a></li>
	            <li><a class="nav-link" href="carregarDadosERB.jsp">Atualizar Banco de Dados de ERB</a></li>
	            <li><a class="nav-link" href="estatisticas.jsp">Estatísticas</a></li>
	            <li class="divider"></li>
	            <li><a class="nav-link" href="#">EasterEgg</a></li>
	          </ul>
	        </li>
	      </ul>
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>
<!-- 	FIM DO CÓDIGO QUE DEFINE A NAVBAR -->
	<%
		
		String alerta = (String)session.getAttribute("alerta");
		if(alerta != null) {
			out.println(alerta);
			session.removeAttribute("alerta");
		}
	
	%>
	<div id="conteudo">
	</div>
	<div style="width:100%; height:100%" id="map">
	</div>
	<script defer="defer" type="text/javascript">
		var map = new OpenLayers.Map('map');
		map.addControl(new OpenLayers.Control.LayerSwitcher);
		
// 		Usando o OpenStreetMap
		map.addLayer(new OpenLayers.Layer.OSM());
		
// 		Usando o Google
		var streets = new OpenLayers.Layer.Google("Google Streets", {numZoomLevels: 20});
		var satellite = new OpenLayers.Layer.Google("Google Satellite", {type: google.maps.MapTypeId.SATELLITE, numZoomLevels: 22});
		map.addLayers([streets, satellite]);
		
// 		Criando os marcadores personalizados

		var tamanho_icones_operadora = new OpenLayers.Size(25,25);
		var offset_icones_operadora = new OpenLayers.Pixel(-(tamanho_icones_operadora.w/2), -tamanho_icones_operadora.h);
		var icon_claro = new OpenLayers.Icon('resources/images/marker_claro.png', tamanho_icones_operadora, offset_icones_operadora);
		var icon_nextel = new OpenLayers.Icon('resources/images/marker_nextel.png', tamanho_icones_operadora, offset_icones_operadora);
		var icon_oi = new OpenLayers.Icon('resources/images/marker_oi.png', tamanho_icones_operadora, offset_icones_operadora);
		var icon_tim = new OpenLayers.Icon('resources/images/marker_tim.png', tamanho_icones_operadora, offset_icones_operadora);
		var icon_vivo = new OpenLayers.Icon('resources/images/marker_vivo.png', tamanho_icones_operadora, offset_icones_operadora);
		var icon_usuario = new OpenLayers.Icon('resources/images/marker_usuario.png', tamanho_icones_operadora, offset_icones_operadora);
		
// 		Configuracao Inicial do Mapa, centralizando ele no Maranhao
		var inicial = new OpenLayers.LonLat(-44, -6)
		      .transform(
		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
		        map.getProjectionObject() // to Spherical Mercator Projection
		      );
		map.setCenter(inicial);
		map.zoomTo(6);
		
// 		Adicionando layers dos marcadores
		var markers = new OpenLayers.Layer.Markers( "Torres de Telefonia Móvel" );
		var markersDados = new OpenLayers.Layer.Markers( "Dados Usuários do Sistema" );
		map.addLayer(markers);
		map.addLayer(markersDados);
		
// 		Marcando o Palacio dos Leoes como primeira referencia
		var lonLat = new OpenLayers.LonLat(-44.306817, -2.527532)
		      .transform(
		        new OpenLayers.Projection("EPSG:4326"),
		        map.getProjectionObject()
		      );
		markers.addMarker(new OpenLayers.Marker(lonLat));
		
// 		Metodos para capturar a posicao com o clique
		map.events.register('click', map, handleMapClick);

		function handleMapClick(evt) {
			var lonlatFromMap = map.getLonLatFromViewPortPx(evt.xy);
			lonlatFromMap.transform(new OpenLayers.Projection("EPSG:900913"), new OpenLayers.Projection("EPSG:4326"));
			$("#modalUsuario").modal();
			$("#modalUsuario").on('show.bs.modal', function(e) {
				$("#longitudeModal").val(lonlatFromMap.lon);
				$("#latitudeModal").val(lonlatFromMap.lat);
			});
			
		}

	</script>

	<!-- Modal de insercao pelo usuario -->
	<div class="modal fade" id="modalUsuario" tabindex="-1" role="dialog" aria-labelledby="modalUsuarioLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="modalUsuarioLabel">Relato sobre essa posição</h4>
				</div>
				<div class="modal-body">
					<form class="form-inline" role="form" id="formDadosQualidade" method="post" action="principal">
					<input type="hidden" name="acao" value="registradadosqualidade">
						<div class="form-group">
							<label>Longitude</label>
							<input class="form-control" id="longitudeModal" name="longitudeModal" readonly>
						</div>
						<div class="form-group">
							<label>Latitude</label>
							<input class="form-control" id="latitudeModal" name="latitudeModal" readonly>
						</div>
						<br />
						<br />
						<div class="form-group">
							<label>Operadora</label>
							<select class="form-control" id="operadoraModal" name="operadoraModal">
								<option value="claro">CLARO</option>
								<option value="nextel">NEXTEL</option>
								<option value="oi">OI</option>
								<option value="tim">TIM</option>
								<option value="vivo">VIVO</option>
							</select>
						</div>
						<div class="form-group">
							<label>Intensidade do sinal</label>
							<select class="form-control" id="intensidadeModal" name="intensidadeModal">
								<option value=0>Sem sinal</option>
								<option value=1>Muito Fraco</option>
								<option value=2>Fraco</option>
								<option value=3>Regular</option>
								<option value=4>Forte</option>
							</select>
						</div>
						<br />
						<br />
						<div>
							<label>Outras informações</label>
							<br />
							<label class="checkbox-inline">
								<input type="checkbox" id="ruidoNaLigacao" name="ruidoNaLigacao" value="ruidoNaLigacao">Ruido na ligação
							</label>
							<label class="checkbox-inline">
								<input type="checkbox" id="ligacaoNaoCompleta" name="ligacaoNaoCompleta" value="ligacaoNaoCompleta">Ligação não completa
							</label>
							<br />
							<label class="checkbox-inline">
								<input type="checkbox" id="ligacaoInterrompida" name="ligacaoInterrompida" value="ligacaoInterrompida">Ligação Interrompida
							</label>
							<label class="checkbox-inline">
								<input type="checkbox" id="semDadosMoveis" name="semDadosMoveis" value="semDadosMoveis">Sem dados móveis
							</label>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
					<button type="button" class="btn btn-primary" onclick='$("#formDadosQualidade").submit()'>Salvar dados</button>
				</div>
				
				
				
			</div>
		</div>
	</div>
	
	<%
		
		ArrayList<ERB> lstERBS = (ArrayList<ERB>)session.getAttribute("lstERBS");
		if(lstERBS == null) {
			DaoERB daoERB = new DaoERB();
			lstERBS = daoERB.listarERBS();
			
		}
		for(ERB erb : lstERBS) {
			if(erb.getOperadora().equalsIgnoreCase("claro")) {
				String script = "<script>lonLat = new OpenLayers.LonLat("+ erb.getLongitude()+","+erb.getLatitude()+").transform(new OpenLayers.Projection('EPSG:4326'),map.getProjectionObject()); markers.addMarker(new OpenLayers.Marker(lonLat, icon_claro.clone()));</script>";
				out.println(script);
			}
			if(erb.getOperadora().equalsIgnoreCase("nextel")) {
				String script = "<script>lonLat = new OpenLayers.LonLat("+ erb.getLongitude()+","+erb.getLatitude()+").transform(new OpenLayers.Projection('EPSG:4326'),map.getProjectionObject()); markers.addMarker(new OpenLayers.Marker(lonLat, icon_nextel.clone()));</script>";
				out.println(script);
			}
			if(erb.getOperadora().equalsIgnoreCase("tnl")) {
				String script = "<script>lonLat = new OpenLayers.LonLat("+ erb.getLongitude()+","+erb.getLatitude()+").transform(new OpenLayers.Projection('EPSG:4326'),map.getProjectionObject()); markers.addMarker(new OpenLayers.Marker(lonLat, icon_oi.clone()));</script>";
				out.println(script);
			}
			if(erb.getOperadora().equalsIgnoreCase("tim")) {
				String script = "<script>lonLat = new OpenLayers.LonLat("+ erb.getLongitude()+","+erb.getLatitude()+").transform(new OpenLayers.Projection('EPSG:4326'),map.getProjectionObject()); markers.addMarker(new OpenLayers.Marker(lonLat, icon_tim.clone()));</script>";
				out.println(script);
			}
			if(erb.getOperadora().equalsIgnoreCase("telefonica")) {
				String script = "<script>lonLat = new OpenLayers.LonLat("+ erb.getLongitude()+","+erb.getLatitude()+").transform(new OpenLayers.Projection('EPSG:4326'),map.getProjectionObject()); markers.addMarker(new OpenLayers.Marker(lonLat, icon_vivo.clone()));</script>";
				out.println(script);
			}
	
		}
		
		ArrayList<DadosQualidade> lstDadosQualidade = (ArrayList<DadosQualidade>) session.getAttribute("lstDadosQualidade");
		if(lstDadosQualidade == null) {
			DaoDadosQualidade daoDadosQualidade = new DaoDadosQualidade();
			lstDadosQualidade = daoDadosQualidade.listarDados();
			
		}
		
		for(DadosQualidade dados : lstDadosQualidade) {
			String script = "<script>lonLat = new OpenLayers.LonLat("+ dados.getLongitude()+","+dados.getLatitude()+").transform(new OpenLayers.Projection('EPSG:4326'),map.getProjectionObject()); markers.addMarker(new OpenLayers.Marker(lonLat, icon_usuario.clone()));</script>";
			out.println(script);
		}
	%>
</body>
</html>