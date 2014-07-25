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
	    		<a href="#" class="dropdown-toggle" data-toggle="dropdown">SELECIONAR OPERADORA<span class="caret"></span></a>
	    		<ul class="dropdown-menu" role="menu">
	    			<li><a href="principal?operadora=claro">CLARO</a></li>
	    			<li><a href="principal?operadora=nextel">NEXTEL</a></li>
	    			<li><a href="principal?operadora=oi">OI</a></li>
	    			<li><a href="principal?operadora=tim">TIM</a></li>
	    			<li><a href="principal?operadora=vivo">VIVO</a></li>
	    		</ul>
	      	</li>
	      </ul>
	      <ul class="nav navbar-nav navbar-right">
	        <li><a class="nav-link" href="sobre.jsp">SOBRE</a></li>
	        <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown">ADMINISTRATIVO<span class="caret"></span></a>
	          <ul class="dropdown-menu" role="menu">
	            <li><a class="nav-link" href="listarERBS.jsp">Listar ERB Cadastradas</a></li>
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
		
// 		var size_claro_nextel = new OpenLayers.Size(25,25);
// 		var size_oi = new OpenLayers.Size(25,27);
// 		var size_tim = new OpenLayers.Size(40,17);
// 		var size_vivo = new OpenLayers.Size(40,19);
		
// 		var offset_claro_nextel = new OpenLayers.Pixel(-(size_claro_nextel.w/2), -size_claro_nextel.h);
// 		var offset_oi = new OpenLayers.Pixel(-(size_oi.w/2), -size_oi.h);
// 		var offset_tim = new OpenLayers.Pixel(-(size_tim.w/2), -size_tim.h);
// 		var offset_vivo = new OpenLayers.Pixel(-(size_vivo.w/2), -size_vivo.h);

// 		var icon_claro = new OpenLayers.Icon('resources/images/logo_claro25x25.png', size_claro_nextel, offset_claro_nextel);
// 		var icon_nextel = new OpenLayers.Icon('resources/images/logo_nextel25x25.png', size_claro_nextel, offset_claro_nextel);
// 		var icon_oi = new OpenLayers.Icon('resources/images/logo_oi25x27.png', size_oi, offset_oi);
// 		var icon_tim = new OpenLayers.Icon('resources/images/logo_tim40x17.png', size_tim, offset_tim);
// 		var icon_vivo = new OpenLayers.Icon('resources/images/logo_vivo40x19.png', size_vivo, offset_vivo);
		
		
// 		Configuracao Inicial do Mapa, centralizando ele no Maranhao
		var inicial = new OpenLayers.LonLat(-44, -6)
		      .transform(
		        new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
		        map.getProjectionObject() // to Spherical Mercator Projection
		      );
		map.setCenter(inicial);
		map.zoomTo(6);
		
		var markers = new OpenLayers.Layer.Markers( "Torres de Telefonia Móvel" );
		map.addLayer(markers);
		
// 		Marcando o Palacio dos Leoes como referencia
		var lonLat = new OpenLayers.LonLat(-44.294806,-2.534888)
		      .transform(
		        new OpenLayers.Projection("EPSG:4326"),
		        map.getProjectionObject()
		      );
		markers.addMarker(new OpenLayers.Marker(lonLat));	
	</script>
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
	%>
</body>
</html>