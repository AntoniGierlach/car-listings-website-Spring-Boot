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
import pl.apexwheels.service.RoleService;
import pl.apexwheels.service.UserService;

@SpringBootApplication
public class ApexWheelsApplication {

    @Value("${app.demo-data.enabled:false}")
    private boolean demoDataEnabled;

    public static void main(String[] args) {
        SpringApplication.run(ApexWheelsApplication.class, args);
    }

    @Bean
    CommandLineRunner init(UserService userService, RoleService roleService,
                           BrandDao brandDao, CategoryDao categoryDao, AdvertisingDao advertisingDao) {
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
                user.setUsername("admin");
                user.setPassword("admin");
                userService.saveAdmin(user);
            }

            if (demoDataEnabled && advertisingDao.findAll().isEmpty()) {
                seedDemoListings(userService.findByUsername("admin"), brandDao, categoryDao, advertisingDao);
            }
        };
    }

    private void seedDemoListings(User seller, BrandDao brandDao, CategoryDao categoryDao,
                                  AdvertisingDao advertisingDao) {
        Category sedan = category(categoryDao, "Sedan");
        Category suv = category(categoryDao, "SUV");
        Category coupe = category(categoryDao, "Coupe");
        Category wagon = category(categoryDao, "Kombi");

        Brand bmw = brand(brandDao, "BMW");
        Brand audi = brand(brandDao, "Audi");
        Brand mercedes = brand(brandDao, "Mercedes-Benz");
        Brand volvo = brand(brandDao, "Volvo");
        Brand porsche = brand(brandDao, "Porsche");

        listing(advertisingDao, seller, "M340i xDrive", bmw, sedan, 2022, 34_500, 269_900,
                "bmw-m340i.svg", "Sportowy sedan z napędem xDrive, pakietem M Sport i pełną historią serwisową.");
        listing(advertisingDao, seller, "Q5 45 TFSI quattro", audi, suv, 2021, 48_200, 184_500,
                "audi-q5.svg", "Komfortowy SUV premium z automatyczną skrzynią, panoramą i kamerą 360°.");
        listing(advertisingDao, seller, "C 220 d AMG Line", mercedes, sedan, 2023, 18_900, 239_000,
                "mercedes-c220.svg", "Elegancka limuzyna w wersji AMG Line. Samochód krajowy, bezwypadkowy.");
        listing(advertisingDao, seller, "XC60 B5 Ultimate", volvo, suv, 2022, 27_800, 219_900,
                "volvo-xc60.svg", "Bezpieczny i świetnie wyposażony SUV z jasnym wnętrzem oraz napędem AWD.");
        listing(advertisingDao, seller, "911 Carrera 4S", porsche, coupe, 2020, 12_600, 589_000,
                "porsche-911.svg", "Ikoniczne coupe w wyjątkowej konfiguracji. Dealer Porsche, gwarancja do 2027 roku.");
        listing(advertisingDao, seller, "A6 Avant 40 TDI", audi, wagon, 2021, 61_400, 159_900,
                "audi-a6.svg", "Przestronne kombi na co dzień — świetny balans osiągów, komfortu i ekonomii.");
        listing(advertisingDao, seller, "X3 xDrive30i", bmw, suv, 2020, 72_100, 149_900,
                "bmw-x3.svg", "Zadbany, dynamiczny SUV z bogatym wyposażeniem i udokumentowanym przebiegiem.");
        listing(advertisingDao, seller, "E-Class E 200", mercedes, sedan, 2019, 84_700, 139_900,
                "mercedes-e200.svg", "Klasyczna elegancja Mercedesa, komfortowe wnętrze i wzorowy stan techniczny.");
    }

    private Category category(CategoryDao dao, String name) {
        Category item = new Category();
        item.setName(name);
        dao.create(item);
        return item;
    }

    private Brand brand(BrandDao dao, String name) {
        Brand item = new Brand();
        item.setName(name);
        dao.create(item);
        return item;
    }

    private void listing(AdvertisingDao dao, User seller, String title, Brand brand,
                         Category category, int year, int mileage, int price, String image, String description) {
        Advertising item = new Advertising();
        item.setTitle(title);
        item.setDescription(description);
        item.setImage(image);
        item.setMileage(mileage);
        item.setPrice(price);
        item.setYear_of_production(year);
        item.setPhone_number(501_234_567);
        item.setBrand(brand);
        item.setCategory(category);
        item.setUser(seller);
        dao.create(item);
    }
}