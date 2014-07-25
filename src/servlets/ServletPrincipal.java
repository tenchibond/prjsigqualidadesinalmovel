package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.xml.ws.runtime.dev.Session;

import daos.DaoERB;
import entidades.ERB;

/**
 * Servlet implementation class ServletPrincipal
 */
@WebServlet(
		description = "Servlet principal da aplicacao", 
		urlPatterns = { 
				"/ServletPrincipal", 
				"/servletprincipal", 
				"/principal"
		})
public class ServletPrincipal extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletPrincipal() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		gerenciaAcoes(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		gerenciaAcoes(request, response);
		
	}
	
	private void gerenciaAcoes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		String operadora = (String) request.getParameter("operadora");
		DaoERB daoERB = new DaoERB();
		ArrayList<ERB> lstERBS;
		
		if(operadora.equals("todos")) {
			lstERBS = daoERB.listarERBS();
			
		} else {
			if(operadora.equals("vivo"))
				operadora = "telefonica";
			if(operadora.equals("oi"))
				operadora = "tnl";
			
			lstERBS = daoERB.listarERBSPorOperadora(operadora);
			
		}
		
		request.getSession().setAttribute("lstERBS", lstERBS);
		
		response.sendRedirect("index.jsp");
		
	}

}
