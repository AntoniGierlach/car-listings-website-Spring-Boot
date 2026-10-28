package pl.apexwheels.dao;

import org.hibernate.Hibernate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import pl.apexwheels.model.Advertising;
import pl.apexwheels.model.Brand;
import pl.apexwheels.model.Category;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import java.util.List;


@Repository
@Transactional
public class AdvertisingDao {

    @PersistenceContext
    private EntityManager entityManager;

    public List<Advertising> findAll() {
        Query query = entityManager.createQuery("SELECT a FROM Advertising a");
        return query.getResultList();
    }

    public List<Advertising> findAllSortByMileageAsc() {
        Query query = entityManager.createQuery("SELECT a FROM Advertising a ORDER BY a.mileage ASC");
        return query.getResultList();
    }

    public List<Advertising> findAllSortByMileageDesc() {
        Query query = entityManager.createQuery("SELECT a FROM Advertising a ORDER BY a.mileage DESC");
        return query.getResultList();
    }

    public List<Advertising> findAllSortByPriceAsc() {
        Query query = entityManager.createQuery("SELECT a FROM Advertising a ORDER BY a.price ASC");
        return query.getResultList();
    }

    public List<Advertising> findAllSortByPriceDesc() {
        Query query = entityManager.createQuery("SELECT a FROM Advertising a ORDER BY a.price DESC");
        return query.getResultList();
    }

    public List<Advertising> findAllSortByDateDesc() {
        Query query = entityManager.createQuery("SELECT a FROM Advertising a ORDER BY a.updatedAt DESC");
        return query.getResultList();
    }

    public Advertising findById(Long id) {
        Advertising advertising = entityManager.find(Advertising.class, id);
        if (advertising != null) {
            Hibernate.initialize(advertising.getCategory());
            Hibernate.initialize(advertising.getBrand());
            return advertising;
        }
        return null;
    }

    public List<Advertising> findAllWithCategory(Category category) {
        Query query = entityManager.createQuery("SELECT a FROM Advertising a join a.category where a.category=:category");
        query.setParameter("category", category);
        return query.getResultList();
    }

    public List<Advertising> findAllWithBrand(Brand brand) {
        Query query = entityManager.createQuery("SELECT a FROM Advertising a join a.brand where a.brand=:brand");
        query.setParameter("brand", brand);
        return query.getResultList();
    }

    public List<Advertising> findAllWithUsername(String username) {
        Query query = entityManager.createQuery("SELECT a FROM Advertising a join a.user where a.user.username=:username");
        query.setParameter("username", username);
        return query.getResultList();
    }

    public void create(Advertising advertising) {
        entityManager.persist(advertising);
    }

    public Advertising update(Advertising advertising) {
        return entityManager.merge(advertising);
    }

    public void remove(Advertising advertising) {
        entityManager.remove(entityManager.contains(advertising) ? advertising : entityManager.merge(advertising));
    }
}