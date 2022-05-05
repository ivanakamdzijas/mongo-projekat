package primer.repository;

import java.util.List;


import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;


import primer.model.Recept;


public interface ReceptRepository extends MongoRepository<Recept, String> {
	
	
	List<Recept> findByKategorija(int kategorija);
	
	
	List<Recept> findByNazivReceptaIgnoreCase(String nazivRecepta);
	
	@Query("{'sastojci.nazivSastojka':?0 } ")
	List<Recept> findBySastojci(String nazivS);
	
	
}
