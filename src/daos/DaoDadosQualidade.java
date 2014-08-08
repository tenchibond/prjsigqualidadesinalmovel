package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import entidades.DadosQualidade;

public class DaoDadosQualidade {
	
	public DaoDadosQualidade() {
		
	}
	
	public String create(DadosQualidade dados) {
		String retorno = "Dados nao inseridos no banco";
		
		String sql = "insert into dados_qualidade(longitude, latitude, operadora, intensidade_sinal, ligacao_interrompida, ligacao_nao_completa, ruido_ligacao, sem_dados) values (?,?,?,?,?,?,?,?)";
		Connection conn = ConnectionSingleton.getInstancy().getConexao();
		
		try {
			PreparedStatement pstm = conn.prepareStatement(sql);
			pstm.setFloat(1, dados.getLongitude());
			pstm.setFloat(2, dados.getLatitude());
			pstm.setString(3, dados.getOperadora());
			pstm.setInt(4, dados.getIntensidadeSinal());
			pstm.setBoolean(5, dados.isLigacaoInterrompida());
			pstm.setBoolean(6, dados.isLigacaoNaoCompleta());
			pstm.setBoolean(7, dados.isLigacaoComRuido());
			pstm.setBoolean(8, dados.isSemDadosMoveis());
			pstm.execute();
			retorno = "Dados inseridos com sucesso";
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return retorno;
	}
	
	public ArrayList<DadosQualidade> listarDados() {
		ArrayList<DadosQualidade> lstDados = new ArrayList<>();
		String sql = "select *from dados_qualidade";
		Connection conn = ConnectionSingleton.getInstancy().getConexao();
		try {
			Statement stm = conn.createStatement();
			ResultSet res = stm.executeQuery(sql);
			
			while(res.next()) {
				DadosQualidade dados = new DadosQualidade();
				dados.setId(res.getInt("id"));
				dados.setLongitude(res.getFloat("longitude"));
				dados.setLatitude(res.getFloat("latitude"));
				dados.setOperadora(res.getString("operadora"));
				dados.setIntensidadeSinal(res.getInt("intensidade_sinal"));
				dados.setLigacaoInterrompida(res.getBoolean("ligacao_interrompida"));
				dados.setLigacaoNaoCompleta(res.getBoolean("ligacao_nao_completa"));
				dados.setLigacaoComRuido(res.getBoolean("ruido_ligacao"));
				dados.setSemDadosMoveis(res.getBoolean("sem_dados"));
				lstDados.add(dados);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return lstDados;
		
	}
	
	public ArrayList<DadosQualidade> listarDadosPorOperadora(String operadora) {
		ArrayList<DadosQualidade> lstDados = new ArrayList<>();
		String sql = "select *from dados_qualidade where operadora = ?";
		Connection conn = ConnectionSingleton.getInstancy().getConexao();
		try {
			PreparedStatement pstm = conn.prepareStatement(sql);
			pstm.setString(1, operadora.toUpperCase());
			ResultSet res = pstm.executeQuery();
			
			while(res.next()) {
				DadosQualidade dados = new DadosQualidade();
				dados.setId(res.getInt("id"));
				dados.setLongitude(res.getFloat("longitude"));
				dados.setLatitude(res.getFloat("latitude"));
				dados.setOperadora(res.getString("operadora"));
				dados.setIntensidadeSinal(res.getInt("intensidade_sinal"));
				dados.setLigacaoInterrompida(res.getBoolean("ligacao_interrompida"));
				dados.setLigacaoNaoCompleta(res.getBoolean("ligacao_nao_completa"));
				dados.setLigacaoComRuido(res.getBoolean("ruido_ligacao"));
				dados.setSemDadosMoveis(res.getBoolean("sem_dados"));
				lstDados.add(dados);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return lstDados;
		
	}

}
