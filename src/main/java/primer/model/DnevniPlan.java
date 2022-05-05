package primer.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "dnevni")
public class DnevniPlan {
	@Id
    private String id;
	
	Recept dorucak;
	Recept rucak;
	Recept vecera;
	Recept dezert;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Recept getDorucak() {
		return dorucak;
	}
	public void setDorucak(Recept dorucak) {
		this.dorucak = dorucak;
	}
	public Recept getRucak() {
		return rucak;
	}
	public void setRucak(Recept rucak) {
		this.rucak = rucak;
	}
	public Recept getVecera() {
		return vecera;
	}
	public void setVecera(Recept vecera) {
		this.vecera = vecera;
	}
	public Recept getDezert() {
		return dezert;
	}
	public void setDezert(Recept dezert) {
		this.dezert = dezert;
	}
	
	
	}
