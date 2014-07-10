package prjSIGQualidadeSinalMovel;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

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
						response.getWriter().println("Form field");
						response.getWriter().println("Name: " + item.getFieldName());
						response.getWriter().println("Value: " + item.getString());
						
					} else {
						response.getWriter().println("NOT Form field");
						response.getWriter().println("Name: " + item.getFieldName());
						response.getWriter().println("Filename: " + item.getName());
						response.getWriter().println("Size: " + item.getSize());
						response.getWriter().println("ContentType: " + item.getContentType());
						File uploadeFile = new File(System.getProperty("user.dir") + item.getName());
						item.write(uploadeFile);
						
					}
					
				}
				
			} catch(Exception e) {
				response.getWriter().println("Ocorreu um erro ao fazer upload: " + e.getMessage());
				
			}
			
		}
		
	}

}
