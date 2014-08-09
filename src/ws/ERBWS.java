package ws;

import java.util.ArrayList;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

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
	@Path("/getERBSPorOperadora/{operadora}")
	@Produces(MediaType.APPLICATION_JSON)
	public ArrayList<ERB> getERBSPorOperadora(@PathParam("operadora") String operadora) {
		DaoERB daoERB = new DaoERB();
		return daoERB.listarERBSPorOperadora(operadora);
		
	}

}
