package pl.apexwheels.service;

import org.junit.jupiter.api.Test;
import org.springframework.web.client.ResourceAccessException;
import pl.apexwheels.dao.BrandDao;
import pl.apexwheels.model.Brand;

import java.util.List;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class CarApiMakesSeederTest {

    @Test
    void addsOnlyMakesThatAreNotAlreadyPresent() {
        CarApiMakesClient client = mock(CarApiMakesClient.class);
        BrandDao brandDao = mock(BrandDao.class);
        Brand existingBrand = new Brand();
        existingBrand.setName("Acura");
        when(client.fetchMakeNames()).thenReturn(List.of("Acura", "BMW"));
        when(brandDao.findAll()).thenReturn(List.of(existingBrand));

        new CarApiMakesSeeder(client).seed(brandDao);

        verify(brandDao, never()).create(existingBrand);
        org.mockito.ArgumentCaptor<Brand> insertedBrand = org.mockito.ArgumentCaptor.forClass(Brand.class);
        verify(brandDao).create(insertedBrand.capture());
        org.assertj.core.api.Assertions.assertThat(insertedBrand.getValue().getName()).isEqualTo("BMW");
    }

    @Test
    void keepsCurrentCatalogWhenCarApiIsUnavailable() {
        CarApiMakesClient client = mock(CarApiMakesClient.class);
        BrandDao brandDao = mock(BrandDao.class);
        when(client.fetchMakeNames()).thenThrow(new ResourceAccessException("offline"));

        new CarApiMakesSeeder(client).seed(brandDao);

        verify(brandDao, never()).create(org.mockito.ArgumentMatchers.any(Brand.class));
        verify(brandDao, never()).findAll();
    }
}
