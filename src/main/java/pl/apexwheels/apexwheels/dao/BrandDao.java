package pl.apexwheels.apexwheels.dao;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import pl.apexwheels.apexwheels.model.Brand;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import java.util.List;

@Repository
@Transactional
public class BrandDao {

    @PersistenceContext
    private EntityManager entityManager;

    public List<Brand> findAll() {
        Query query = entityManager.createQuery("SELECT b FROM Brand b");
        return query.getResultList();
    }

    public Brand findById(Long id) {
        return entityManager.find(Brand.class, id);
    }

    public void create(Brand item) {
        entityManager.persist(item);
    }

    public Brand update(Brand item) {
        return entityManager.merge(item);
    }

    public void remove(Brand item) {
        entityManager.remove(entityManager.contains(item) ? item : entityManager.merge(item));
    }
}