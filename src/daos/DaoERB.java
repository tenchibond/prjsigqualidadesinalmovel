package daos;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import entidades.ERB;

public class DaoERB {
	
	public DaoERB() {
		
	}
	
	public String carregarDadosNoBanco(ArrayList<ERB> lstERBS) {
		String retorno = "Registros nao carregados";
		
		String sqlDeletaDadosTabelaERBS = "truncate table erbs";
		Connection conn = ConnectionSingleton.getInstancy().getConexao();
		try {
			Statement stm = conn.createStatement();
			stm.execute(sqlDeletaDadosTabelaERBS);
			stm.close();
			
			String sqlInsereDadosTabelaERBS = "insert into erbs(operadora, estacao, nome, uf, municipio, bairro, logradouro, latitude, longitude, data_cadastro, data_prim_licenc, data_ult_licenc) values (?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement pstm = conn.prepareStatement(sqlInsereDadosTabelaERBS);
			for (ERB erb : lstERBS) {
				pstm.setString(1, erb.getOperadora());
				pstm.setInt(2, erb.getEstacao());
				pstm.setString(3, erb.getNome());
				pstm.setString(4, erb.getUf());
				pstm.setString(5, erb.getMunicipio());
				pstm.setString(6, erb.getBairro());
				pstm.setString(7, erb.getLogradouro());
				pstm.setFloat(8, erb.getLatitude());
				pstm.setFloat(9, erb.getLongitude());
				pstm.setDate(10, new Date(System.currentTimeMillis()));
				pstm.setDate(11, new Date(System.currentTimeMillis()));
				pstm.setDate(12, new Date(System.currentTimeMillis()));
				pstm.addBatch();
				
			}
			
			retorno = "Registros inseridos: " + pstm.executeBatch().length;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return retorno;
	}
	
	public ArrayList<ERB> listarERBS() {
		ArrayList<ERB> lstERBS = new ArrayList<>();
		String sql_listar = "select *from erbs";
		Connection conn = ConnectionSingleton.getInstancy().getConexao();
		try {
			Statement stm = conn.createStatement();
			ResultSet res = stm.executeQuery(sql_listar);
			while(res.next()) {
				ERB erb = new ERB();
				erb.setId(res.getInt("id"));
				erb.setOperadora(res.getString("operadora"));
				erb.setEstacao(res.getInt("estacao"));
				erb.setNome(res.getString("nome"));
				erb.setUf(res.getString("uf"));
				erb.setMunicipio(res.getString("municipio"));
				erb.setBairro(res.getString("bairro"));
				erb.setLogradouro(res.getString("logradouro"));
				erb.setLatitude(res.getFloat("latitude"));
				erb.setLongitude(res.getFloat("longitude"));
//				erb.setDataCadastro(new Date(System.currentTimeMillis()));
//				erb.setDataPrimeiroLicenciamento(new Date(System.currentTimeMillis()));
//				erb.setDataUltimoLicenciamento(new Date(System.currentTimeMillis()));
				lstERBS.add(erb);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return lstERBS;
		
	}

}
