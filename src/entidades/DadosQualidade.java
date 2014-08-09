package entidades;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class DadosQualidade {
	private int id;
	private float latitude;
	private float longitude;
	private String operadora;
	private int intensidadeSinal;
	private boolean ligacaoInterrompida;
	private boolean ligacaoNaoCompleta;
	private boolean ligacaoComRuido;
	private boolean semDadosMoveis;
	
	public DadosQualidade() {
		intensidadeSinal = 0;
		ligacaoInterrompida = false;
		ligacaoNaoCompleta = false;
		ligacaoComRuido = false;
		semDadosMoveis = false;
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getOperadora() {
		return operadora;
	}

	public void setOperadora(String operadora) {
		this.operadora = operadora;
	}

	public int getIntensidadeSinal() {
		return intensidadeSinal;
	}

	public void setIntensidadeSinal(int intensidadeSinal) {
		this.intensidadeSinal = intensidadeSinal;
	}

	public boolean isLigacaoInterrompida() {
		return ligacaoInterrompida;
	}

	public void setLigacaoInterrompida(boolean ligacaoInterrompida) {
		this.ligacaoInterrompida = ligacaoInterrompida;
	}

	public boolean isLigacaoNaoCompleta() {
		return ligacaoNaoCompleta;
	}

	public void setLigacaoNaoCompleta(boolean ligacaoNaoCompleta) {
		this.ligacaoNaoCompleta = ligacaoNaoCompleta;
	}

	public boolean isLigacaoComRuido() {
		return ligacaoComRuido;
	}

	public void setLigacaoComRuido(boolean ligacaoComRuido) {
		this.ligacaoComRuido = ligacaoComRuido;
	}

	public boolean isSemDadosMoveis() {
		return semDadosMoveis;
	}

	public void setSemDadosMoveis(boolean semDadosMoveis) {
		this.semDadosMoveis = semDadosMoveis;
	}
	
}
