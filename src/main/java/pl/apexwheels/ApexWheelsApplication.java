package pl.apexwheels;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.beans.factory.annotation.Value;
import pl.apexwheels.dao.AdvertisingDao;
import pl.apexwheels.dao.BrandDao;
import pl.apexwheels.dao.CategoryDao;
import pl.apexwheels.model.Advertising;
import pl.apexwheels.model.Brand;
import pl.apexwheels.model.Category;
import pl.apexwheels.model.Role;
import pl.apexwheels.model.User;
import pl.apexwheels.service.CarApiMakesSeeder;
import pl.apexwheels.service.RoleService;
import pl.apexwheels.service.UserService;

import java.util.HashSet;
import java.util.Set;

@SpringBootApplication
public class ApexWheelsApplication {

    @Value("${app.demo-data.enabled:false}")
    private boolean demoDataEnabled;

    @Value("${app.carapi.makes-seeding-enabled:true}")
    private boolean carApiMakesSeedingEnabled;

    public static void main(String[] args) {
        SpringApplication.run(ApexWheelsApplication.class, args);
    }

    @Bean
    CommandLineRunner init(UserService userService, RoleService roleService,
                           BrandDao brandDao, CategoryDao categoryDao, AdvertisingDao advertisingDao,
                           CarApiMakesSeeder carApiMakesSeeder) {
        return (args) -> {

            if (roleService.findByName("ROLE_ADMIN") == null) {
                Role r = new Role();
                r.setName("ROLE_ADMIN");
                roleService.save(r);
            }
            if (roleService.findByName("ROLE_USER") == null) {
                Role r = new Role();
                r.setName("ROLE_USER");
                roleService.save(r);
            }
            if (userService.findByUsername("admin") == null) {

                User user = new User();
                user.setName("Super user");
                user.setLastName("Administrator");
                user.setUsername("admin");
                user.setPassword("admin");
                userService.saveAdmin(user);
            }

            if (carApiMakesSeedingEnabled) {
                carApiMakesSeeder.seed(brandDao);
            }

            if (demoDataEnabled) {
                removeListingsWithoutImages(advertisingDao);
                seedDemoListings(userService.findByUsername("admin"), brandDao, categoryDao, advertisingDao);
            }
        };
    }

    private void removeListingsWithoutImages(AdvertisingDao advertisingDao) {
        advertisingDao.findAll().stream()
                .filter(item -> item.getImage() == null || item.getImage().isBlank())
                .forEach(advertisingDao::remove);
    }

    private void seedDemoListings(User seller, BrandDao brandDao, CategoryDao categoryDao,
                                  AdvertisingDao advertisingDao) {
        Category sedan = category(categoryDao, "Sedan");
        Category suv = category(categoryDao, "SUV");
        Category coupe = category(categoryDao, "Coupe");
        Category hatchback = category(categoryDao, "Hatchback");
        Category kombi = category(categoryDao, "Kombi");
        Category roadster = category(categoryDao, "Roadster");
        Category van = category(categoryDao, "Van");
        Category pickup = category(categoryDao, "Pickup");

        Brand acura = brand(brandDao, "Acura");
        Brand audi = brand(brandDao, "Audi");
        Brand bmw = brand(brandDao, "BMW");
        Brand delorean = brand(brandDao, "DeLorean");
        Brand ferrari = brand(brandDao, "Ferrari");
        Brand honda = brand(brandDao, "Honda");
        Brand jeep = brand(brandDao, "Jeep");
        Brand lamborghini = brand(brandDao, "Lamborghini");
        Brand mercedes = brand(brandDao, "Mercedes-Benz");
        Brand nissan = brand(brandDao, "Nissan");
        Brand opel = brand(brandDao, "Opel");
        Brand tesla = brand(brandDao, "Tesla");
        Brand toyota = brand(brandDao, "Toyota");
        Brand volkswagen = brand(brandDao, "Volkswagen");

        Set<String> existingImages = new HashSet<>();
        advertisingDao.findAll().forEach(item -> {
            if (item.getImage() != null) {
                existingImages.add(item.getImage());
            }
        });
        backfillDemoPower(advertisingDao);

        listing(advertisingDao, existingImages, seller, "NSX 3.5 V6", acura, coupe, "Benzyna", "Używany", "Nieuszkodzony", 573,
                2019, 18_400, 449_900, "acura-nsx.jpg",
                "Dwumiejscowe coupe z napędem hybrydowym i centralnie umieszczonym silnikiem. Samochód dla entuzjasty.");
        listing(advertisingDao, existingImages, seller, "TLX Type S", acura, sedan, "Benzyna", "Używany", "Nieuszkodzony", 355,
                2022, 24_800, 219_900, "acura-tlx.jpg",
                "Dynamiczny sedan klasy premium z mocnym silnikiem, automatyczną skrzynią i kompletnym wyposażeniem.");
        listing(advertisingDao, existingImages, seller, "A4 40 TFSI S line", audi, sedan, "Benzyna", "Używany", "Nieuszkodzony", 204,
                2021, 42_600, 139_900, "audi-a4.jpg",
                "Zadbany sedan z pakietem S line, reflektorami LED i historią przeglądów.");
        listing(advertisingDao, existingImages, seller, "e-tron 50 quattro", audi, suv, "Elektryczny", "Nowy", "Nieuszkodzony", 408,
                2023, 9, 249_900, "audi-e-tron.jpg",
                "Cichy i praktyczny SUV elektryczny z napędem quattro oraz szybkim ładowaniem.");
        listing(advertisingDao, existingImages, seller, "M3 Competition", bmw, sedan, "Benzyna", "Używany", "Nieuszkodzony", 510,
                2022, 29_700, 389_900, "bmw-m3.jpg",
                "Sportowy sedan z sześciocylindrowym silnikiem, napędem na cztery koła i pakietem torowym.");
        listing(advertisingDao, existingImages, seller, "DMC-12", delorean, coupe, "Benzyna", "Używany", "Nieuszkodzony", 132,
                1982, 76_500, 299_000, "delorean-dmc-12.jpg",
                "Klasyczny samochód kolekcjonerski z charakterystycznym nadwoziem ze stali nierdzewnej.");
        listing(advertisingDao, existingImages, seller, "LaFerrari", ferrari, coupe, "Hybryda", "Używany", "Nieuszkodzony", 963,
                2015, 6_800, 12_900_000, "ferrari-laferrari.jpg",
                "Wyjątkowy hipersamochód w kolekcjonerskim stanie, z pełną dokumentacją pochodzenia.");
        listing(advertisingDao, existingImages, seller, "Civic Si", honda, hatchback, "Benzyna", "Używany", "Nieuszkodzony", 205,
                2020, 38_900, 119_900, "honda-civic-si.jpg",
                "Lekki i angażujący hatchback z manualną skrzynią, idealny do codziennej jazdy.");
        listing(advertisingDao, existingImages, seller, "Wrangler Rubicon", jeep, suv, "Benzyna", "Używany", "Nieuszkodzony", 270,
                2021, 47_200, 189_900, "jeep-wrangler.jpg",
                "Terenowy SUV z reduktorem, blokadami mostów i zdejmowanym dachem.");
        listing(advertisingDao, existingImages, seller, "Aventador LP 780-4", lamborghini, coupe, "Benzyna", "Używany", "Nieuszkodzony", 780,
                2022, 3_900, 2_490_000, "lamborghini-aventador.jpg",
                "Limitowana wersja z wolnossącym silnikiem V12 i włoskim charakterem.");
        listing(advertisingDao, existingImages, seller, "AMG GT 63 S", mercedes, coupe, "Benzyna", "Używany", "Nieuszkodzony", 585,
                2021, 22_100, 699_000, "mercedes-gtr.jpg",
                "Gran turismo AMG z czterema miejscami, napędem 4MATIC+ i luksusowym wnętrzem.");
        listing(advertisingDao, existingImages, seller, "GT-R Nismo", nissan, coupe, "Benzyna", "Używany", "Nieuszkodzony", 600,
                2020, 15_700, 699_900, "nissan-r35-gtr.jpg",
                "Japońskie coupe o wyczynowych osiągach, z pakietem Nismo i pełną historią serwisową.");
        listing(advertisingDao, existingImages, seller, "Astra GTC", opel, hatchback, "Benzyna", "Używany", "Uszkodzony", 150,
                2018, 63_400, 64_900, "opel-astra-gtc.jpg",
                "Zwinne coupe do codziennej jazdy, z wygodnym wnętrzem i niskimi kosztami utrzymania.");
        listing(advertisingDao, existingImages, seller, "Model X Long Range", tesla, suv, "Elektryczny", "Nowy", "Nieuszkodzony", 503,
                2022, 35, 289_900, "tesla-model-x.jpg",
                "Przestronny SUV elektryczny z napędem na cztery koła, dużym zasięgiem i siedmioma miejscami.");
        listing(advertisingDao, existingImages, seller, "Corolla Hybrid", toyota, hatchback, "Hybryda", "Używany", "Nieuszkodzony", 184,
                2021, 51_800, 94_900, "toyota-corolla.jpg",
                "Ekonomiczny hatchback z bezproblemowym napędem hybrydowym i niskim zużyciem paliwa.");
        listing(advertisingDao, existingImages, seller, "Beetle 1.2 TSI", volkswagen, hatchback, "Benzyna", "Używany", "Uszkodzony", 105,
                2017, 69_300, 59_900, "volkswagen-bettle.jpg",
                "Nieszablonowy miejski hatchback z panoramicznym dachem i zadbanym wnętrzem.");
    }

    private Category category(CategoryDao dao, String name) {
        Category existing = dao.findAll().stream()
                .filter(item -> name.equals(item.getName()))
                .findFirst()
                .orElse(null);
        if (existing != null) {
            return existing;
        }
        Category item = new Category();
        item.setName(name);
        dao.create(item);
        return item;
    }

    private Brand brand(BrandDao dao, String name) {
        Brand existing = dao.findAll().stream()
                .filter(item -> name.equals(item.getName()))
                .findFirst()
                .orElse(null);
        if (existing != null) {
            return existing;
        }
        Brand item = new Brand();
        item.setName(name);
        dao.create(item);
        return item;
    }

    private void listing(AdvertisingDao dao, Set<String> existingImages, User seller, String title, Brand brand,
                         Category category, String fuelType, String vehicleCondition, String damageStatus, int power,
                         int year, int mileage, int price, String image, String description) {
        if (existingImages.contains(image)) {
            return;
        }
        Advertising item = new Advertising();
        item.setTitle(title);
        item.setDescription(description);
        item.setImage(image);
        item.setMileage(mileage);
        item.setPower(power);
        item.setPrice(price);
        item.setYear_of_production(year);
        item.setPhone_number(501_234_567);
        item.setFuelType(fuelType);
        item.setVehicleCondition(vehicleCondition);
        item.setDamageStatus(damageStatus);
        item.setBrand(brand);
        item.setCategory(category);
        item.setUser(seller);
        dao.create(item);
        existingImages.add(image);
    }

    private void backfillDemoPower(AdvertisingDao advertisingDao) {
        advertisingDao.findAll().forEach(item -> {
            if (item.getPower() != null || item.getImage() == null) {
                return;
            }
            Integer power = switch (item.getImage()) {
                case "acura-nsx.jpg" -> 573;
                case "acura-tlx.jpg" -> 355;
                case "audi-a4.jpg" -> 204;
                case "audi-e-tron.jpg" -> 408;
                case "bmw-m3.jpg" -> 510;
                case "delorean-dmc-12.jpg" -> 132;
                case "ferrari-laferrari.jpg" -> 963;
                case "honda-civic-si.jpg" -> 205;
                case "jeep-wrangler.jpg" -> 270;
                case "lamborghini-aventador.jpg" -> 780;
                case "mercedes-gtr.jpg" -> 585;
                case "nissan-r35-gtr.jpg" -> 600;
                case "opel-astra-gtc.jpg" -> 150;
                case "tesla-model-x.jpg" -> 503;
                case "toyota-corolla.jpg" -> 184;
                case "volkswagen-bettle.jpg" -> 105;
                default -> null;
            };
            if (power != null) {
                item.setPower(power);
                advertisingDao.update(item);
            }
        });
    }
}