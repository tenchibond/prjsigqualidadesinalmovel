package daos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionSingleton {
    private Connection conexao;
    private final String url = "jdbc:mysql://localhost/qualidadesinalmovel";
    private final String user = "root";
    private final String password = "";
    private static ConnectionSingleton instancy;
    
    private ConnectionSingleton() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            
        } catch (ClassNotFoundException e) {
            System.err.println(e.getMessage());
            
        }
        
        try {
            this.conexao = DriverManager.getConnection(this.url, this.user, this.password);
            
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            
        }
        
    }
    
    public static ConnectionSingleton getInstancy() {
        if(instancy == null) {
            instancy = new ConnectionSingleton();
            
        } 
        
        return instancy;
        
    }
    
    public Connection getConexao() {
        return this.conexao;
        
    }
    
    
}