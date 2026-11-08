package pl.apexwheels.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClientException;
import pl.apexwheels.dao.BrandDao;
import pl.apexwheels.model.Brand;

import java.util.HashSet;
import java.util.Locale;
import java.util.Set;

@Component
public class CarApiMakesSeeder {

    private static final Logger log = LoggerFactory.getLogger(CarApiMakesSeeder.class);

    private final CarApiMakesClient carApiMakesClient;

    public CarApiMakesSeeder(CarApiMakesClient carApiMakesClient) {
        this.carApiMakesClient = carApiMakesClient;
    }

    public void seed(BrandDao brandDao) {
        final var makeNames = fetchMakeNamesOrKeepExisting();
        if (makeNames == null) {
            return;
        }

        Set<String> existingNames = new HashSet<>();
        brandDao.findAll().forEach(brand -> existingNames.add(normalize(brand.getName())));

        int addedCount = 0;
        for (String name : makeNames) {
            if (existingNames.add(normalize(name))) {
                Brand brand = new Brand();
                brand.setName(name);
                brandDao.create(brand);
                addedCount++;
            }
        }
        log.info("Seeded {} car makes from CarAPI ({} already existed)", addedCount,
                makeNames.size() - addedCount);
    }

    private java.util.List<String> fetchMakeNamesOrKeepExisting() {
        try {
            return carApiMakesClient.fetchMakeNames();
        } catch (RestClientException | IllegalStateException exception) {
            log.warn("Could not load car makes from CarAPI; keeping existing brands", exception);
            return null;
        }
    }

    private String normalize(String name) {
        return name == null ? "" : name.trim().toLowerCase(Locale.ROOT);
    }
}
