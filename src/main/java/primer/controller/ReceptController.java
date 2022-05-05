package primer.controller;

import java.util.ArrayList;

import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.bson.Document;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mongodb.MongoClient;
import com.mongodb.client.MapReduceIterable;

import com.mongodb.client.MongoDatabase;

import primer.model.DnevniPlan;

import primer.model.Recept;
import primer.model.Sastojak;
import primer.repository.DnevniPlanRepository;

import primer.repository.ReceptRepository;
import primer.repository.SastojakRepository;

@Controller
@RequestMapping(value = "/recepti")
public class ReceptController {

	@Autowired
	ReceptRepository rr;

	@Autowired
	SastojakRepository sr;

	@Autowired
	DnevniPlanRepository dpr;
	
	@ExceptionHandler(value=RuntimeException.class)
	public String handleError() {
		return "Greska";
	}

	
	
	
	 @RequestMapping(value = "/saveOReceptu", method = RequestMethod.POST)
	public String saveOReceptu(String nazivRecepta, String trajanje, Integer kategorija, String kcal, String uh,
			String ma, String pr, HttpServletRequest request) {
		Recept r = new Recept();
		Integer kalorije = Integer.parseInt(kcal);
		Integer proteini = Integer.parseInt(pr);
		Integer masti = Integer.parseInt(ma);
		Integer ugljeniHidrati = Integer.parseInt(uh);
		r.setNazivRecepta(nazivRecepta);
		if(!trajanje.equals("")) {
				r.setTrajanje(trajanje);
		}
		r.setKategorija(kategorija);
		r.setKcal(kalorije);
		r.setUh(ugljeniHidrati);
		r.setPr(proteini);
		r.setMa(masti);
		rr.save(r);
		String kat;
		if (kategorija == 1) {
			kat = "doručak";
		} else if (kategorija == 2) {
			kat = "ručak";

		} else if (kategorija == 3) {
			kat = "večera";
		} else {
			kat = "dezert";
		}
		request.getSession().setAttribute("recept", r);
		request.getSession().setAttribute("kategorija", kat);
		return "UnosRecepta";
	}
	
	
	 

	@RequestMapping(value = "/unosBrojaSastojaka", method = RequestMethod.GET)
	public String unosBrojaSastojaka(String brojac, HttpServletRequest request) {
		Integer br = Integer.parseInt(brojac);
		request.getSession().setAttribute("brojac", br);
		return "UnosRecepta";
	}

	@RequestMapping(value = "/saveSastojci", method = RequestMethod.POST)
	public String saveSastojci(String nazivSastojka, String kolicina, String mj, HttpServletRequest request) {
		Integer br = (Integer) request.getSession().getAttribute("brojac");
		Recept r = (Recept) request.getSession().getAttribute("recept");
		List<Sastojak> sastojci = new ArrayList<Sastojak>();
		System.out.println(kolicina);
		String[] kol;
		String[] ns;
		String[] mjed;
		if (kolicina.contains(",")) {
			kol = kolicina.split(",");
		} else {
			kol = new String[1];
			kol[0] = kolicina;
		}
		if (nazivSastojka.contains(",")) {
			ns = nazivSastojka.split(",");
		} else {
			ns = new String[1];
			ns[0] = nazivSastojka;
		}
		if (mj.contains(",")) {
			mjed = mj.split(",");
		} else {
			mjed = new String[1];
			mjed[0] = mj;
		}

		for (int i = 0; i < br; i++) {
			Sastojak s = new Sastojak();
			
			
			if (i < kol.length && i < mjed.length ) {
				if(!kol[i].equals("")) {
					s.setKolicina(kol[i]);
				}
				if(!mjed[i].equals("")) {
				s.setMj(mjed[i]);
				}
				s.setNazivSastojka(ns[i]);
			} else if (i < kol.length && i >= mjed.length &&  !kol[i].equals("")) {
				if(!kol[i].equals("")) {
					s.setKolicina(kol[i]);
				}
				s.setNazivSastojka(ns[i]);
				
			} else if (i >= kol.length )  {
				s.setNazivSastojka(ns[i]);
			}

			r.addSastojak(s);
			sastojci.add(s);

		}

		// r.setSastojci(sastojci);
		rr.save(r);
		// ne smes cuvati u sesiji jer je vidljivo i kad izbrises recept a opet moras jer treba da se vidi na sledecoj str
		//mozda probati model
		request.getSession().setAttribute("sastojci", sastojci);

		return "UnosRecepta";
	}

	@RequestMapping(value = "sacuvaj", method = RequestMethod.POST)
	public String sacuvaj(String nacinPripreme, Model m, HttpServletRequest request) {
		Recept r = (Recept) request.getSession().getAttribute("recept");

		r.setNacinPripreme(nacinPripreme);
		rr.save(r);
		m.addAttribute("recept", r);
		m.addAttribute("poruka", "Uspešno ste sačuvali svoj recept. Hvala Vam!");
		return "JedanRecept";
	}
 
	
	@RequestMapping(value = "/prikaziSveRecepte", method = RequestMethod.GET)
	public String prikaziSveRecepte(Model m) {
		List<Recept> recepti = rr.findAll();
		m.addAttribute("recepti", recepti);

		return "PrikazRecepata";
	}

	@RequestMapping(value = "/filtrirajKat", method = RequestMethod.GET)
	public String filtrirajKat(Model m, Integer kat, HttpServletRequest request) {
		List<Recept> recepti = new ArrayList<Recept>();
		if(kat == 1 || kat == 2 || kat == 3 || kat ==4) {
			recepti = rr.findByKategorija(kat);
		}else if(kat == 5) {
			m.addAttribute("poNaslovu", "Pretraga po naslovu:");
		}
		else {
			m.addAttribute("poSastojku", "Pretraga po sastojku:");
		}
		request.getSession().setAttribute("kat", kat);
		request.getSession().setAttribute("prikaziRecept",false);
		request.getSession().setAttribute("receptiKat", recepti);
		return "PrikazRecepata";
	}
	
	
	@RequestMapping(value = "/filtrirajNaslov", method = RequestMethod.GET)
	public String filtrirajNaslov(HttpServletRequest request, String poNaslovu) {

		List<Recept> receptiKat = rr.findByNazivReceptaIgnoreCase(poNaslovu);
		for (Recept r : receptiKat) {
			System.out.println(r.getNazivRecepta());
		}
		request.getSession().setAttribute("receptiKat", receptiKat);
		
		return "PrikazRecepata";
	}

	@RequestMapping(value = "/filtrirajSastojak", method = RequestMethod.GET)
	public String filtrirajSastojak(HttpServletRequest request, String poSastojku) {

		List<Recept> receptiKat = rr.findBySastojci(poSastojku);
		for (Recept r : receptiKat) {
			System.out.println(r.getNazivRecepta());
		}
		request.getSession().setAttribute("receptiKat", receptiKat);
		return "PrikazRecepata";
	}
	
	@RequestMapping(value = "/prikaziJedanRecept", method = RequestMethod.GET)
	public String prikaziJedanRecept(Model m,HttpServletRequest request, String idR) {

		Recept r = rr.findById(idR).get();
		
		//probacu ovde da stavim samo u req ne u sesiju
		
		request.setAttribute("recep", r);
		//System.out.println("naziv" + r.getNazivRecepta());
		request.getSession().setAttribute("idR", idR);
		//System.out.println("id: "+idR);
		String kategorija = "";
		if (r.getKategorija() == 1) {
			kategorija = "doručak";
		} else if (r.getKategorija() == 2) {
			kategorija = "ručak";

		} else if (r.getKategorija() == 3) {
			kategorija = "večera";
		} else {
			kategorija = "dezert";
		}
		request.getSession().setAttribute("kategorija", kategorija);
		List<Sastojak> sastojci = r.getSastojci();
		request.getSession().setAttribute("sastojciPrikaz", sastojci);
		request.getSession().setAttribute("prikaziRecept",true);
		return "PrikazRecepata";
	}

	@RequestMapping(value = "/odabratiCilj", method = RequestMethod.GET)
	public String odabratiCilj(Integer cilj, HttpServletRequest request) {
		request.getSession().setAttribute("cilj", cilj);
		List<Recept> dor = rr.findByKategorija(1);
		request.getSession().setAttribute("dor", dor);
		List<Recept> ruckovi = rr.findByKategorija(2);
		request.getSession().setAttribute("ruckovi", ruckovi);
		List<Recept> vecere = rr.findByKategorija(3);
		request.getSession().setAttribute("vecere", vecere);
		List<Recept> dezerti = rr.findByKategorija(4);
		request.getSession().setAttribute("dezerti", dezerti);
		return "PlanIshrane";
	}

	@RequestMapping(value = "/izracunati", method = RequestMethod.GET)
	public String izracunati(Model m, HttpServletRequest request, String dorucak, String rucak, String vecera,
			String dezert) {
		Integer ciljK = (Integer) (request.getSession().getAttribute("cilj"));
		double prepPr = 0.0;
		double prepUh = 0.0;
		double prepMa = 0.0;
		if (ciljK == 1500) {
			prepPr = 112;
			prepMa = 50;
			prepUh = 150;

		} else if (ciljK == 1600) {
			prepPr = 120;
			prepMa = 53.3;
			prepUh = 160;

		} else if (ciljK == 1700) {
			prepPr = 127.5;
			prepMa = 56.7;
			prepUh = 170;
		} else {
			prepPr = 150;
			prepMa = 66;
			prepUh = 200;
		}
		m.addAttribute("prepPr", prepPr);
		m.addAttribute("prepUh", prepUh);
		m.addAttribute("prepMa", prepMa);
		DnevniPlan dp = new DnevniPlan();
		Optional<Recept> dor = rr.findById(dorucak);
		Optional<Recept> r = rr.findById(rucak);
		Optional<Recept> v = rr.findById(vecera);
		Optional<Recept> dez = rr.findById(dezert);
		dp.setDorucak(dor.get());
		dp.setRucak(r.get());
		dp.setVecera(v.get());
		dp.setDezert(dez.get());
		dpr.insert(dp);
		String nazivDor = dor.get().getNazivRecepta();
		String nazivR = r.get().getNazivRecepta();
		String nazivV = v.get().getNazivRecepta();
		String nazivDez = dez.get().getNazivRecepta();
		m.addAttribute("nazivDor", nazivDor);
		m.addAttribute("nazivR", nazivR);
		m.addAttribute("nazivV", nazivV);
		m.addAttribute("nazivDez", nazivDez);
		
		MongoClient mc = new MongoClient("nastava.is.pmf.uns.ac.rs", 27017);
		MongoDatabase db = mc.getDatabase("ishrana");
		MapReduceIterable<Document> result = db.getCollection("dnevni").
				mapReduce(
						"function(){var ksum = this.dorucak.kcal + this.rucak.kcal/2 + this.vecera.kcal +this.dezert.kcal;"
								+ "				var psum = this.dorucak.pr + this.rucak.pr/2 + this.vecera.pr +this.dezert.pr;"
								+ "				var usum = this.dorucak.uh + this.rucak.uh/2 + this.vecera.uh +this.dezert.uh;"
								+ "				var msum = this.dorucak.ma + this.rucak.ma/2 + this.vecera.ma +this.dezert.ma;"
								+ " var val={kcal:ksum, pr:psum, uh:usum, ma:msum};emit(this._id, val)}",

						"function(key, vals){return Array.sum(vals);} ");
		
		Double ukupno = 0.0;
		for (Document d : result) {
			System.out.println(d.get("value"));
			Document n = (Document) d.get("value");
			ukupno =n.getDouble("kcal");
			m.addAttribute("ukupnoKcal", n.get("kcal"));
			m.addAttribute("ukupnoPr", n.get("pr"));
			m.addAttribute("ukupnoUh", n.get("uh"));
			m.addAttribute("ukupnoMa", n.get("ma"));
		}
		
		String napomena;
		if(ciljK.doubleValue() >= ukupno ) {
			napomena ="Vaš izbor obroka se uklapa u cilj!";
		}else {
			napomena = "Vaš izbor obroka se ne uklapa u cilj! Pokušajte da ga korigujete za " + (ukupno - ciljK) + "kcal.";
		}
		request.setAttribute("napomena", napomena);
		request.setAttribute("ciljK", ciljK);
		request.getSession().setAttribute("cilj", null);
		mc.close();
		return "PlanIshrane";
	}

	@RequestMapping(value = "/prikazatiTabelu", method = RequestMethod.GET)
	public String prikazatiTabelu(Model m) {
		MongoClient mc = new MongoClient("nastava.is.pmf.uns.ac.rs", 27017);
		MongoDatabase db = mc.getDatabase("ishrana");
		MapReduceIterable<Document> result = db.getCollection("recepti").
				mapReduce(
						"function(){ var value = {kcal:this.kcal, pr:this.pr, ma:this.ma, uh:this.uh};emit(this.kategorija,value);};",
						"function(key, vals){" + " var sumPr = 0.0; var sumKcal = 0.0; var sumMa =0.0; var sumUh =0.0; "
								+ "for(var i = 0; i < vals.length; i++){ "
								+ "sumPr += vals[i].pr; sumKcal += vals[i].kcal;"
								+ "sumUh +=vals[i].uh; sumMa += vals[i].ma;}"

								+ "return  {kcal:sumKcal/vals.length, pr:sumPr/vals.length, ma:sumMa/vals.length,uh:sumUh/vals.length};} ");
		for (Document d : result) {
			// System.out.println(d.get("value"));
			Document doc1 = (Document) d.get("value");
			// System.out.println(doc1.get("kcal"));
			if ((Double) d.get("_id") == 1.0) {
				m.addAttribute("prosecnoKcalD", String.format("%.2f", doc1.get("kcal")));
				m.addAttribute("prosecnoPrD", String.format("%.2f", doc1.get("pr")));
				m.addAttribute("prosecnoUhD", String.format("%.2f", doc1.get("uh")));
				m.addAttribute("prosecnoMaD", String.format("%.2f", doc1.get("ma")));
			} else if ((Double) d.get("_id") == 2.0) {
				m.addAttribute("prosecnoKcalR", String.format("%.2f", doc1.get("kcal")));
				m.addAttribute("prosecnoPrR", String.format("%.2f", doc1.get("pr")));
				m.addAttribute("prosecnoUhR", String.format("%.2f", doc1.get("uh")));
				m.addAttribute("prosecnoMaR", String.format("%.2f", doc1.get("ma")));
			} else if ((Double) d.get("_id") == 3.0) {
				m.addAttribute("prosecnoKcalV", String.format("%.2f", doc1.get("kcal")));
				m.addAttribute("prosecnoPrV", String.format("%.2f", doc1.get("pr")));
				m.addAttribute("prosecnoUhV", String.format("%.2f", doc1.get("uh")));
				m.addAttribute("prosecnoMaV", String.format("%.2f", doc1.get("ma")));
			} else {
				m.addAttribute("prosecnoKcalDez", String.format("%.2f", doc1.get("kcal")));
				m.addAttribute("prosecnoPrDez", String.format("%.2f", doc1.get("pr")));
				m.addAttribute("prosecnoUhDez", String.format("%.2f", doc1.get("uh")));
				m.addAttribute("prosecnoMaDez", String.format("%.2f", doc1.get("ma")));
			}
		}
		mc.close();
		return "OReceptima";
	}

	

	

	@RequestMapping(value = "/obrisiRecept", method = RequestMethod.GET)
	public String obrisiRecept(String idR, HttpServletRequest request) {
		rr.delete(rr.findById(idR).get());
		request.setAttribute("porukaBrisanje", "Recept je uspešno obrisan.");
		
		//ovo sam dodala da probam
		request.getSession().setAttribute("recept", null);
		request.getSession().setAttribute("sastojci", null);
		request.getSession().setAttribute("brojac", null);
		return "PrikazRecepata";
	}

	@RequestMapping(value = "/izmeniNazivDa", method = RequestMethod.GET)
	public String izmeniNazivDa(HttpServletRequest request) {

		request.getSession().setAttribute("porukaDaNaziv", true);
		return "JedanRecept";
	}

	@RequestMapping(value = "/izmeniNaziv", method = RequestMethod.GET)
	public String izmeniNaziv(String noviNaziv, HttpServletRequest request) {
		Recept r = (Recept) request.getSession().getAttribute("recept");
		r.setNazivRecepta(noviNaziv);
		rr.save(r);
		request.getSession().setAttribute("porukaDaNaziv", false);
		return "JedanRecept";
	}

	@RequestMapping(value = "/izmeniTrajanjeDa", method = RequestMethod.GET)
	public String izmeniTrajanjeDa(HttpServletRequest request) {

		request.getSession().setAttribute("porukaDaTrajanje", true);
		return "JedanRecept";
	}

	@RequestMapping(value = "/izmeniTrajanje", method = RequestMethod.GET)
	public String izmeniTrajanje(String novoTr, HttpServletRequest request) {
		Recept r = (Recept) request.getSession().getAttribute("recept");
		r.setTrajanje(novoTr);
		;
		rr.save(r);
		request.getSession().setAttribute("porukaDaTrajanje", false);
		return "JedanRecept";
	}

	@RequestMapping(value = "/izmeniKatDa", method = RequestMethod.GET)
	public String izmeniKatDa(HttpServletRequest request) {

		request.getSession().setAttribute("porukaDaKat", true);
		return "JedanRecept";
	}

	@RequestMapping(value = "/izmeniKat", method = RequestMethod.GET)
	public String izmeniKat(Integer kat, HttpServletRequest request) {
		Recept r = (Recept) request.getSession().getAttribute("recept");
		r.setKategorija(kat);
		rr.save(r);
		String kategorija = "";
		if (r.getKategorija() == 1) {
			kategorija = "doručak";
		} else if (r.getKategorija() == 2) {
			kategorija = "ručak";

		} else if (r.getKategorija() == 3) {
			kategorija = "večera";
		} else {
			kategorija = "dezert";
		}
		request.getSession().setAttribute("kategorija", kategorija);
		request.getSession().setAttribute("porukaDaKat", false);
		return "JedanRecept";
	}

	@RequestMapping(value = "/izmeniNacinDa", method = RequestMethod.GET)
	public String izmeniNacinDa(HttpServletRequest request) {

		request.getSession().setAttribute("porukaDaNacin", true);
		return "JedanRecept";
	}

	@RequestMapping(value = "/izmeniNacin", method = RequestMethod.GET)
	public String izmeniNacin(String noviNacin, HttpServletRequest request) {
		Recept r = (Recept) request.getSession().getAttribute("recept");
		r.setNacinPripreme(noviNacin);
		rr.save(r);
		request.getSession().setAttribute("porukaDaNacin", false);
		return "JedanRecept";
	}

	@RequestMapping(value = "/izmeniTabDa", method = RequestMethod.GET)
	public String izmeniTabDa(HttpServletRequest request) {

		request.getSession().setAttribute("porukaDaTab", true);
		return "JedanRecept";
	}

	@RequestMapping(value = "/izmeniTab", method = RequestMethod.GET)
	public String izmeniTab(String novoKcal, String novoMa, String novoPr, String novoUh, HttpServletRequest request) {
		Recept r = (Recept) request.getSession().getAttribute("recept");
		Integer kcal = Integer.parseInt(novoKcal);
		Integer pr = Integer.parseInt(novoPr);
		Integer ma = Integer.parseInt(novoMa);
		Integer uh = Integer.parseInt(novoUh);
		r.setKcal(kcal);
		r.setMa(ma);
		r.setUh(uh);
		r.setPr(pr);
		rr.save(r);
		request.getSession().setAttribute("porukaDaTab", false);
		return "JedanRecept";
	}

	@RequestMapping(value = "/izmeniSastojkeDa", method = RequestMethod.GET)
	public String izmeniSastojkeDa(HttpServletRequest request) {

		request.getSession().setAttribute("porukaDaSastojci", true);
		return "JedanRecept";
	}

	@RequestMapping(value = "/izmeniSastojkeBr", method = RequestMethod.GET)
	public String izmeniSastojkeBr(String noviBrojac, HttpServletRequest request) {
		Integer noviBr = Integer.parseInt(noviBrojac);
		request.getSession().setAttribute("porukaDaSastojci", true);
		request.getSession().setAttribute("noviBrojac", noviBr);
		return "JedanRecept";
	}

	@RequestMapping(value = "/izmeniSastojke", method = RequestMethod.GET)
	public String izmeniSastojke(String novoNazivSastojka, String novoKolicina, String novoMj,
			HttpServletRequest request) {
		Recept r = (Recept) request.getSession().getAttribute("recept");
		Integer brojac = (Integer) request.getSession().getAttribute("noviBrojac");
		List<Sastojak> sastojci = new ArrayList<Sastojak>();
		System.out.println(novoKolicina);
		String[] kol;
		String[] ns;
		String[] mjed;
		if (novoKolicina.contains(",")) {
			kol = novoKolicina.split(",");
		} else {
			kol = new String[1];
			kol[0] = novoKolicina;
		}
		if (novoNazivSastojka.contains(",")) {
			ns = novoNazivSastojka.split(",");
		} else {
			ns = new String[1];
			ns[0] = novoNazivSastojka;
		}
		if (novoMj.contains(",")) {
			mjed = novoMj.split(",");
		} else {
			mjed = new String[1];
			mjed[0] = novoMj;
		}

		for (int i = 0; i < brojac; i++) {
			Sastojak s = new Sastojak();

			if (i < kol.length && i < mjed.length ) {
				if(!kol[i].equals("")) {
					s.setKolicina(kol[i]);
				}
				if(!mjed[i].equals("")) {
				s.setMj(mjed[i]);
				}
				s.setNazivSastojka(ns[i]);
			} else if (i < kol.length && i >= mjed.length &&  !kol[i].equals("")) {
				if(!kol[i].equals("")) {
					s.setKolicina(kol[i]);
				}
				s.setNazivSastojka(ns[i]);
				
			} else if (i >= kol.length )  {
				s.setNazivSastojka(ns[i]);
			}
			
			r.addSastojak(s);
			sastojci.add(s);

		}

		rr.save(r);
		request.getSession().setAttribute("sastojci", sastojci);
		request.getSession().setAttribute("porukaDaSastojci", false);

		return "JedanRecept";
	}

}