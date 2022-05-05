package primer.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import primer.model.DnevniPlan;

public interface DnevniPlanRepository extends MongoRepository<DnevniPlan, String> {

}
