package ws;

import java.util.ArrayList;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.google.gson.Gson;

import daos.DaoDadosQualidade;
import entidades.DadosQualidade;

@Path("/dadosqualidade")
public class DadosQualidadeWS {
	
	@GET
	@Path("/listarDados")
	@Produces(MediaType.APPLICATION_JSON)
	public ArrayList<DadosQualidade> listarDados() {
		DaoDadosQualidade daoDadosQualidade = new DaoDadosQualidade();
		return daoDadosQualidade.listarDados();
		
	}
	
	@GET
	@Path("/listarDadosGSON")
	@Produces(MediaType.APPLICATION_JSON)
	public String listarDadosGSON() {
		DaoDadosQualidade daoDadosQualidade = new DaoDadosQualidade();
		return new Gson().toJson(daoDadosQualidade.listarDados());
		
	}
	
	@GET
	@Path("/listarDadosPorOperadora/{operadora}")
	@Produces(MediaType.APPLICATION_JSON)
	public ArrayList<DadosQualidade> listarDadosPorOperadora(@PathParam("operadora") String operadora) {
		DaoDadosQualidade daoDadosQualidade = new DaoDadosQualidade();
		return daoDadosQualidade.listarDadosPorOperadora(operadora);
		
	}
	
	@GET
	@Path("/listarDadosPorOperadoraGSON/{operadora}")
	@Produces(MediaType.APPLICATION_JSON)
	public String listarDadosPorOperadoraGSON(@PathParam("operadora") String operadora) {
		DaoDadosQualidade daoDadosQualidade = new DaoDadosQualidade();
		return new Gson().toJson(daoDadosQualidade.listarDadosPorOperadora(operadora));
		
	}
	
	@POST
	@Path("/criarDadosQualidade")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public String create(DadosQualidade dados) {
		DaoDadosQualidade daoDadosQualidade = new DaoDadosQualidade();
		return daoDadosQualidade.create(dados);
	}

}
