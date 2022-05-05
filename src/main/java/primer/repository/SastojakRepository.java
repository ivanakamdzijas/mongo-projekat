package primer.repository;



import org.springframework.data.mongodb.repository.MongoRepository;


import primer.model.Sastojak;

public interface SastojakRepository extends MongoRepository<Sastojak, String> {
	
}
