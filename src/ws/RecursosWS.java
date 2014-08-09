package ws;

import javax.ws.rs.ApplicationPath;

import org.glassfish.jersey.server.ResourceConfig;

@ApplicationPath("recursos")
public class RecursosWS extends ResourceConfig {
	
	public RecursosWS() {
		packages("daos; entidades");
		
	}
	
}
