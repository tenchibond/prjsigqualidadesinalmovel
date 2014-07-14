package servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import daos.DaoERB;
import entidades.ERB;

@WebServlet({ "/UploadServlet", "/uploadservlet", "/upload" })
public class UploadServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if(isMultipart) {
			try{
				FileItemFactory factory = new DiskFileItemFactory();
				ServletFileUpload upload = new ServletFileUpload(factory);
				List<FileItem> items = (List<FileItem>) upload.parseRequest(request);
				for(FileItem item : items) {
					if(item.isFormField()) {
						response.getWriter().println("Erro! Não se trata de um arquivo de dados!");
						
					} else {
						File uploadedFile = new File(item.getName());
						item.write(uploadedFile);
						response.getWriter().println(processaArquivoXLS(uploadedFile));
					}
					
				}
				
			} catch(Exception e) {
				response.getWriter().println("Ocorreu um erro ao fazer upload: " + e.getMessage());
				e.printStackTrace();
				
			}
			
		}
		
	}
	
	private String processaArquivoXLS(File uploadedFile) {
		ArrayList<ERB> lstERBS = new ArrayList<>();
		
//		LEITURA DO ARQUIVO XLS
		try {
			HSSFWorkbook pasta = new HSSFWorkbook(new FileInputStream(uploadedFile));
			int qntPlanilhas = pasta.getNumberOfSheets();
			for(int i = 0; i < qntPlanilhas; i++) {
				String operadora = pasta.getSheetName(i).toUpperCase();
				HSSFSheet planilha = pasta.getSheetAt(i);
				int qtdLinhas = planilha.getPhysicalNumberOfRows();
				for(int j = 1; j < qtdLinhas; j++) {
					HSSFRow linha = planilha.getRow(j);
					if(linha == null) {
						break;
					}
					ERB erb = new ERB();
					erb.setEstacao((int) linha.getCell(0).getNumericCellValue());
					erb.setNome(linha.getCell(1).getStringCellValue());
					erb.setUf(linha.getCell(2).getStringCellValue());
					erb.setMunicipio(linha.getCell(3).getStringCellValue());
					erb.setBairro(linha.getCell(4).getStringCellValue());
					erb.setLogradouro(linha.getCell(5).getStringCellValue());
					String latitudeArquivo = linha.getCell(6).getStringCellValue();
					String longitudeArquivo = linha.getCell(7).getStringCellValue(); 
					erb.setLatitude(converteCoordenadaToUTM(latitudeArquivo));
					erb.setLongitude(converteCoordenadaToUTM(longitudeArquivo));
//					erb.setDataCadastro(linha.getCell(8).getDateCellValue());
//					erb.setDataPrimeiroLicenciamento(linha.getCell(9).getDateCellValue());
//					erb.setDataUltimoLicenciamento(linha.getCell(10).getDateCellValue());
					erb.setOperadora(operadora);
					lstERBS.add(erb);
					
				}
				
			}
			
			DaoERB daoERB = new DaoERB();
			return daoERB.carregarDadosNoBanco(lstERBS);
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "Erro ao salvar dados no banco";
			
	}

	private float converteCoordenadaToUTM(String coordenada) {
		float novaCoordenadaUTM = 0f;
		
		float graus = Float.valueOf(coordenada.substring(0, 2));
		float minutos = Float.valueOf(coordenada.substring(3, 5));
		float segundos = Float.valueOf(coordenada.substring(5, 7));
		
		novaCoordenadaUTM = graus + (minutos/60) + (segundos/3600);
		
		if(coordenada.contains("S") || coordenada.contains("W"))
			novaCoordenadaUTM *= -1;
		
		return novaCoordenadaUTM;
	}

}
