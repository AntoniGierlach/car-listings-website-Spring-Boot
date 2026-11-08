package pl.apexwheels.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.test.util.ReflectionTestUtils;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class AdvertisingDaoTest {

    private EntityManager entityManager;
    private Query query;
    private AdvertisingDao advertisingDao;

    @BeforeEach
    void setUp() {
        entityManager = mock(EntityManager.class);
        query = mock(Query.class);
        advertisingDao = new AdvertisingDao();
        ReflectionTestUtils.setField(advertisingDao, "entityManager", entityManager);
        when(entityManager.createQuery(anyString())).thenReturn(query);
        when(query.getResultList()).thenReturn(List.of());
    }

    @Test
    void bindsUntrustedSearchValuesAndUsesOnlyAllowlistedSortExpressions() {
        String injectionPayload = "' OR 1=1 --";
        String maliciousSort = "price-asc; DELETE FROM Advertising";

        advertisingDao.search(1L, 2L, 1000, 50000, 0, 100000,
                injectionPayload, injectionPayload, injectionPayload, injectionPayload, maliciousSort);

        org.mockito.ArgumentCaptor<String> queryCaptor =
                org.mockito.ArgumentCaptor.forClass(String.class);
        verify(entityManager).createQuery(queryCaptor.capture());
        String jpql = queryCaptor.getValue();

        assertThat(jpql)
                .contains("a.brand.id = :brandId")
                .contains("a.category.id = :categoryId")
                .contains("a.fuelType = :fuelType")
                .contains("a.vehicleCondition = :vehicleCondition")
                .contains("a.damageStatus = :damageStatus")
                .contains("LOWER(a.title) LIKE :searchText")
                .contains("ORDER BY a.updatedAt DESC")
                .doesNotContain(injectionPayload)
                .doesNotContain(maliciousSort);

        verify(query).setParameter("brandId", 1L);
        verify(query).setParameter("categoryId", 2L);
        verify(query).setParameter("fuelType", injectionPayload);
        verify(query).setParameter("vehicleCondition", injectionPayload);
        verify(query).setParameter("damageStatus", injectionPayload);
        verify(query).setParameter("searchText", "%" + injectionPayload.toLowerCase(java.util.Locale.ROOT) + "%");
    }
}
