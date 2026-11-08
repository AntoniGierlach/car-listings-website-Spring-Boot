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

    public List<Advertising> search(Long brandId, Long categoryId, Integer minPrice, Integer maxPrice,
                                    Integer minMileage, Integer maxMileage, String fuelType,
                                    String vehicleCondition, String damageStatus, String searchText, String sort) {
        StringBuilder jpql = new StringBuilder("SELECT a FROM Advertising a WHERE 1 = 1");
        if (brandId != null) {
            jpql.append(" AND a.brand.id = :brandId");
        }
        if (categoryId != null) {
            jpql.append(" AND a.category.id = :categoryId");
        }
        if (minPrice != null) {
            jpql.append(" AND a.price >= :minPrice");
        }
        if (maxPrice != null) {
            jpql.append(" AND a.price <= :maxPrice");
        }
        if (minMileage != null) {
            jpql.append(" AND a.mileage >= :minMileage");
        }
        if (maxMileage != null) {
            jpql.append(" AND a.mileage <= :maxMileage");
        }
        if (fuelType != null && !fuelType.isBlank()) {
            jpql.append(" AND a.fuelType = :fuelType");
        }
        if (vehicleCondition != null && !vehicleCondition.isBlank()) {
            jpql.append(" AND a.vehicleCondition = :vehicleCondition");
        }
        if (damageStatus != null && !damageStatus.isBlank()) {
            jpql.append(" AND a.damageStatus = :damageStatus");
        }
        if (searchText != null && !searchText.isBlank()) {
            jpql.append(" AND (");
            jpql.append("""
                        LOWER(a.title) LIKE :searchText
                        OR LOWER(a.description) LIKE :searchText
                        OR LOWER(a.fuelType) LIKE :searchText
                        OR LOWER(a.vehicleCondition) LIKE :searchText
                        OR LOWER(a.damageStatus) LIKE :searchText
                        OR LOWER(a.image) LIKE :searchText
                        OR LOWER(a.brand.name) LIKE :searchText
                        OR LOWER(a.category.name) LIKE :searchText
                        OR str(a.year_of_production) LIKE :searchText
                        OR str(a.mileage) LIKE :searchText
                        OR str(a.power) LIKE :searchText
                        OR str(a.price) LIKE :searchText
                    )
                    """);
        }

        jpql.append(" ORDER BY ");
        jpql.append(switch (sort == null ? "" : sort) {
            case "price-asc" -> "a.price ASC";
            case "price-desc" -> "a.price DESC";
            case "mileage-asc" -> "a.mileage ASC";
            case "mileage-desc" -> "a.mileage DESC";
            default -> "a.updatedAt DESC";
        });

        Query query = entityManager.createQuery(jpql.toString());
        if (brandId != null) {
            query.setParameter("brandId", brandId);
        }
        if (categoryId != null) {
            query.setParameter("categoryId", categoryId);
        }
        if (minPrice != null) {
            query.setParameter("minPrice", minPrice);
        }
        if (maxPrice != null) {
            query.setParameter("maxPrice", maxPrice);
        }
        if (minMileage != null) {
            query.setParameter("minMileage", minMileage);
        }
        if (maxMileage != null) {
            query.setParameter("maxMileage", maxMileage);
        }
        if (fuelType != null && !fuelType.isBlank()) {
            query.setParameter("fuelType", fuelType);
        }
        if (vehicleCondition != null && !vehicleCondition.isBlank()) {
            query.setParameter("vehicleCondition", vehicleCondition);
        }
        if (damageStatus != null && !damageStatus.isBlank()) {
            query.setParameter("damageStatus", damageStatus);
        }
        if (searchText != null && !searchText.isBlank()) {
            query.setParameter("searchText", "%" + searchText.trim().toLowerCase(java.util.Locale.ROOT) + "%");
        }
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