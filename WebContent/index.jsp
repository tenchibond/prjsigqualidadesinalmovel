<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="resources/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
<script src="http://openlayers.org/api/OpenLayers.js"></script>

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
	      </ul>
	      <form class="navbar-form navbar-left" role="search">
	        <div class="form-group">
	          <input type="text" class="form-control" placeholder="Buscar Localização">
	        </div>
	        <button type="submit" class="btn btn-default">Buscar</button>
	      </form>
	      <ul class="nav navbar-nav navbar-right">
	        <li><a class="nav-link" href="sobre.jsp">Sobre</a></li>
	        <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown">Administrativo <span class="caret"></span></a>
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
	<div style="width:100%; height:100%" id="map"></div>
      <script defer="defer" type="text/javascript">
        var map = new OpenLayers.Map('map');
        var wms = new OpenLayers.Layer.WMS( "OpenLayers WMS",
            "http://vmap0.tiles.osgeo.org/wms/vmap0", {layers: 'basic'} );
        map.addLayer(wms);
        map.zoomToMaxExtent();
      </script>
</body>
</html>