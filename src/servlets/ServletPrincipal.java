package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.xml.ws.runtime.dev.Session;

import daos.DaoDadosQualidade;
import daos.DaoERB;
import entidades.DadosQualidade;
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
		
		String acao = request.getParameter("acao");
		
		if(acao != null) {
			if(acao.equalsIgnoreCase("erb")) {
				String operadora = (String) request.getParameter("operadora");
				DaoERB daoERB = new DaoERB();
				ArrayList<ERB> lstERBS;
				
				if(operadora.equals("todas")) {
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
			if(acao.equalsIgnoreCase("registradadosqualidade")) {
				
				DaoDadosQualidade daoDadosQualidade = new DaoDadosQualidade();
				DadosQualidade dadosQualidade = new DadosQualidade();
				
				dadosQualidade.setOperadora(request.getParameter("operadoraModal"));
				dadosQualidade.setLatitude(Float.parseFloat(request.getParameter("latitudeModal")));
				dadosQualidade.setLongitude(Float.parseFloat(request.getParameter("longitudeModal")));
				dadosQualidade.setIntensidadeSinal(Integer.parseInt(request.getParameter("intensidadeModal")));
				if(request.getParameter("ruidoNaLigacao") != null)
					dadosQualidade.setLigacaoComRuido(true);
				if(request.getParameter("ligacaoNaoCompleta") != null)
					dadosQualidade.setLigacaoNaoCompleta(true);
				if(request.getParameter("ligacaoInterrompida") != null)
					dadosQualidade.setLigacaoInterrompida(true);
				if(request.getParameter("semDadosMoveis") != null)
					dadosQualidade.setSemDadosMoveis(true);
				
				String resultado = daoDadosQualidade.create(dadosQualidade);
				String alerta = "<div class='alert alert-info' role='alert'>" + resultado + "</div>";
				
				request.getSession().setAttribute("alerta", alerta);
				response.sendRedirect("index.jsp");
				
//				response.getWriter().println(request.getParameter("longitudeModal"));
//				response.getWriter().println(request.getParameter("latitudeModal"));
//				response.getWriter().println(request.getParameter("operadoraModal"));
//				response.getWriter().println(request.getParameter("intensidadeModal"));
//				response.getWriter().println(request.getParameter("ruidoNaLigacao"));
//				response.getWriter().println(request.getParameter("ligacaoNaoCompleta"));
//				response.getWriter().println(request.getParameter("ligacaoInterrompida"));
//				response.getWriter().println(request.getParameter("semDadosMoveis"));
				
				
			}
			
			if(acao.equalsIgnoreCase("dadosqualidade")) {
				String operadora = (String) request.getParameter("operadora");
				DaoDadosQualidade daoDadosQualidade = new DaoDadosQualidade();
				ArrayList<DadosQualidade> lstDadosQualidade;
				
				if(operadora.equalsIgnoreCase("todas")) {
					lstDadosQualidade = daoDadosQualidade.listarDados();
					
				} else {
					lstDadosQualidade = daoDadosQualidade.listarDadosPorOperadora(operadora);
					
				}
				
				request.getSession().setAttribute("lstDadosQualidade", lstDadosQualidade);				
				response.sendRedirect("index.jsp");

				
			}
			
		}
		
	}

}
