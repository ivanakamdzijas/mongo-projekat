package primer.model;

import java.util.List;
import java.util.ArrayList;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection="recepti")
public class Recept {

	@Id
    private String idR;
	
	private String nazivRecepta;
	private String trajanje;
	private String nacinPripreme;

	private int kategorija;
	
	private List<Sastojak> sastojci = new ArrayList<Sastojak>();
	private int pr;
	private int uh;
	private int ma;
	private int kcal;
	
	public String getIdR() {
		return idR;
	}
	public void setIdR(String idR) {
		this.idR = idR;
	}
	public String getNazivRecepta() {
		return nazivRecepta;
	}
	public void setNazivRecepta(String nazivRecepta) {
		this.nazivRecepta = nazivRecepta;
	}
	public String getTrajanje() {
		return trajanje;
	}
	public void setTrajanje(String trajanje) {
		this.trajanje = trajanje;
	}
	public String getNacinPripreme() {
		return nacinPripreme;
	}
	public void setNacinPripreme(String nacinPripreme) {
		this.nacinPripreme = nacinPripreme;
	}
	
	public List<Sastojak> getSastojci() {
		return sastojci;
	}
	public void setSastojci(List<Sastojak> sastojci) {
		this.sastojci = sastojci;
	}
	public int getPr() {
		return pr;
	}
	public void setPr(int pr) {
		this.pr = pr;
	}
	public int getUh() {
		return uh;
	}
	public void setUh(int uh) {
		this.uh = uh;
	}
	public int getMa() {
		return ma;
	}
	public void setMa(int ma) {
		this.ma = ma;
	}
	public int getKcal() {
		return kcal;
	}
	public void setKcal(int kcal) {
		this.kcal = kcal;
	}
	
	public void addSastojak(Sastojak sastojak) {
		this.sastojci.add(sastojak);
	}
		
	public int getKategorija() {
		return kategorija;
	}
	public void setKategorija(int kategorija) {
		this.kategorija = kategorija;
	}


	
}
