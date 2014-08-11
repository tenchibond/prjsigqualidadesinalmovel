package ws;

import java.util.ArrayList;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.google.gson.Gson;

import daos.DaoERB;
import entidades.ERB;

@Path("/erb")
public class ERBWS {
	
	@GET
	@Path("/getTodasERBS")
	@Produces(MediaType.APPLICATION_JSON)
	public ArrayList<ERB> getTodasERBS() {
		DaoERB daoERB = new DaoERB();
		return daoERB.listarERBS();
		
	}
	
	@GET
	@Path("/getTodasERBSGSON")
	@Produces(MediaType.APPLICATION_JSON)
	public String getTodasERBSGSON() {
		DaoERB daoERB = new DaoERB();
		return new Gson().toJson(daoERB.listarERBS());
		
	}
	
	@GET
	@Path("/getERBSPorOperadora/{operadora}")
	@Produces(MediaType.APPLICATION_JSON)
	public ArrayList<ERB> getERBSPorOperadora(@PathParam("operadora") String operadora) {
		DaoERB daoERB = new DaoERB();
		return daoERB.listarERBSPorOperadora(operadora);
		
	}
	
	@GET
	@Path("/getERBSPorOperadoraGSON/{operadora}")
	@Produces(MediaType.APPLICATION_JSON)
	public String getERBSPorOperadoraGSON(@PathParam("operadora") String operadora) {
		DaoERB daoERB = new DaoERB();
		return new Gson().toJson(daoERB.listarERBSPorOperadora(operadora));
		
	}

}
