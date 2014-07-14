package entidades;

import java.util.Date;

public class ERB {
	private int id;
	private String operadora;
	private int estacao;
	private String nome;
	private String uf;
	private String municipio;
	private String bairro;
	private String logradouro;
	private float latitude;
	private float longitude;
	private Date dataCadastro;
	private Date dataPrimeiroLicenciamento;
	private Date dataUltimoLicenciamento;
	
	public ERB() {
		id = 0;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getOperadora() {
		return operadora;
	}

	public void setOperadora(String operadora) {
		this.operadora = operadora;
	}

	public int getEstacao() {
		return estacao;
	}
	public void setEstacao(int estacao) {
		this.estacao = estacao;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getUf() {
		return uf;
	}
	public void setUf(String uf) {
		this.uf = uf;
	}
	public String getMunicipio() {
		return municipio;
	}
	public void setMunicipio(String municipio) {
		this.municipio = municipio;
	}
	public String getBairro() {
		return bairro;
	}
	public void setBairro(String bairro) {
		this.bairro = bairro;
	}
	public String getLogradouro() {
		return logradouro;
	}
	public void setLogradouro(String logradouro) {
		this.logradouro = logradouro;
	}
	public float getLatitude() {
		return latitude;
	}
	public void setLatitude(float latitude) {
		this.latitude = latitude;
	}
	public float getLongitude() {
		return longitude;
	}
	public void setLongitude(float longitude) {
		this.longitude = longitude;
	}
	public Date getDataCadastro() {
		return dataCadastro;
	}
	public void setDataCadastro(Date dataCadastro) {
		this.dataCadastro = dataCadastro;
	}
	public Date getDataPrimeiroLicenciamento() {
		return dataPrimeiroLicenciamento;
	}
	public void setDataPrimeiroLicenciamento(Date dataPrimeiroLicenciamento) {
		this.dataPrimeiroLicenciamento = dataPrimeiroLicenciamento;
	}
	public Date getDataUltimoLicenciamento() {
		return dataUltimoLicenciamento;
	}
	public void setDataUltimoLicenciamento(Date dataUltimoLicenciamento) {
		this.dataUltimoLicenciamento = dataUltimoLicenciamento;
	}

}
