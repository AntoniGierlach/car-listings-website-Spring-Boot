package pl.apexwheels.controller;

import org.junit.jupiter.api.Test;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.validation.BeanPropertyBindingResult;
import pl.apexwheels.dao.AdvertisingDao;
import pl.apexwheels.dao.BrandDao;
import pl.apexwheels.dao.CategoryDao;
import pl.apexwheels.model.Advertising;
import pl.apexwheels.model.Brand;
import pl.apexwheels.model.Category;
import pl.apexwheels.service.ListingImageStorageException;
import pl.apexwheels.service.ListingImageStorageService;
import pl.apexwheels.service.UserService;

import java.io.IOException;
import java.time.Year;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class UserControllerTest {

    @Test
    void showsMyListingsViewWhenUserHasNoListings() {
        UserService userService = mock(UserService.class);
        AdvertisingDao advertisingDao = mock(AdvertisingDao.class);
        CategoryDao categoryDao = mock(CategoryDao.class);
        BrandDao brandDao = mock(BrandDao.class);
        ListingImageStorageService imageStorageService = mock(ListingImageStorageService.class);
        when(advertisingDao.findAllWithUsername("owner")).thenReturn(List.of());
        when(categoryDao.findAll()).thenReturn(List.of());
        when(brandDao.findAll()).thenReturn(List.of());

        UserController controller = new UserController(userService, advertisingDao, categoryDao,
                brandDao, imageStorageService);
        ExtendedModelMap model = new ExtendedModelMap();
        UserDetails principal = User.withUsername("owner").password("not-used").roles("USER").build();

        String view = controller.index(principal, model);

        assertThat(view).isEqualTo("user/advertising-list");
        assertThat(model.getAttribute("items")).isEqualTo(List.of());
        verify(advertisingDao).findAllWithUsername("owner");
    }

    @Test
    void doesNotShowValidationSummaryWhenOpeningCreateForm() {
        UserService userService = mock(UserService.class);
        AdvertisingDao advertisingDao = mock(AdvertisingDao.class);
        CategoryDao categoryDao = mock(CategoryDao.class);
        BrandDao brandDao = mock(BrandDao.class);
        ListingImageStorageService imageStorageService = mock(ListingImageStorageService.class);
        when(categoryDao.findAll()).thenReturn(List.of());
        when(brandDao.findAll()).thenReturn(List.of());
        when(advertisingDao.findAll()).thenReturn(List.of());

        UserController controller = new UserController(userService, advertisingDao, categoryDao,
                brandDao, imageStorageService);
        ExtendedModelMap model = new ExtendedModelMap();

        String view = controller.formCreate(model);

        assertThat(view).isEqualTo("user/advertising-form");
        assertThat(model.getAttribute("hasValidationErrors")).isEqualTo(false);
        assertThat(model.getAttribute("categoryHasErrors")).isEqualTo(false);
    }

    @Test
    void legacyDeletePageRedirectsBackToListings() {
        UserController controller = new UserController(
                mock(UserService.class),
                mock(AdvertisingDao.class),
                mock(CategoryDao.class),
                mock(BrandDao.class),
                mock(ListingImageStorageService.class));

        assertThat(controller.formRemove()).isEqualTo("redirect:/user/advertising/list");
    }

    @Test
    void returnsListingFormWhenImageStorageFails() {
        UserService userService = mock(UserService.class);
        AdvertisingDao advertisingDao = mock(AdvertisingDao.class);
        CategoryDao categoryDao = mock(CategoryDao.class);
        BrandDao brandDao = mock(BrandDao.class);
        ListingImageStorageService imageStorageService = mock(ListingImageStorageService.class);
        doThrow(new ListingImageStorageException("Could not store listing image", new IOException()))
                .when(imageStorageService).store(any());
        when(categoryDao.findAll()).thenReturn(List.of());
        when(brandDao.findAll()).thenReturn(List.of());
        when(advertisingDao.findAll()).thenReturn(List.of());

        UserController controller = new UserController(userService, advertisingDao, categoryDao,
                brandDao, imageStorageService);
        Advertising advertising = new Advertising();
        BeanPropertyBindingResult result = new BeanPropertyBindingResult(advertising, "advertising");
        ExtendedModelMap model = new ExtendedModelMap();
        MockMultipartFile imageFile = new MockMultipartFile(
                "imageFile", "car.jpg", "image/jpeg", new byte[]{1, 2, 3});

        String view = controller.submitCreate(advertising, result, List.of(imageFile), null, model);

        assertThat(view).isEqualTo("user/advertising-form");
        assertThat(result.getFieldError("image"))
                .isNotNull()
                .extracting("code")
                .isEqualTo("advertising.image.storage");
        verify(advertisingDao, never()).create(any());
    }

    @Test
    void keepsSubmittedValuesAndShowsSpecificErrorsWhenValidationFails() {
        UserService userService = mock(UserService.class);
        AdvertisingDao advertisingDao = mock(AdvertisingDao.class);
        CategoryDao categoryDao = mock(CategoryDao.class);
        BrandDao brandDao = mock(BrandDao.class);
        ListingImageStorageService imageStorageService = mock(ListingImageStorageService.class);
        when(categoryDao.findAll()).thenReturn(List.of());
        when(brandDao.findAll()).thenReturn(List.of());
        when(advertisingDao.findAll()).thenReturn(List.of());

        UserController controller = new UserController(userService, advertisingDao, categoryDao,
                brandDao, imageStorageService);
        Advertising advertising = new Advertising();
        advertising.setTitle("Moje wpisane ogłoszenie");
        advertising.setDescription("Opis samochodu");
        advertising.setMileage(-1);
        advertising.setPower(120);
        advertising.setPrice(25000);
        advertising.setYear_of_production(Year.now().getValue() + 2);
        advertising.setPhone_number(123456789);
        advertising.setBrand(new Brand());
        advertising.setCategory(new Category());

        BeanPropertyBindingResult result = new BeanPropertyBindingResult(advertising, "advertising");
        LocalValidatorFactoryBean validator = new LocalValidatorFactoryBean();
        validator.afterPropertiesSet();
        try {
            validator.validate(advertising, result);
        } finally {
            validator.close();
        }
        result.rejectValue("category.id", "category.required");

        ExtendedModelMap model = new ExtendedModelMap();
        model.addAttribute("advertising", advertising);
        String view = controller.submitCreate(advertising, result, List.of(), null, model);

        assertThat(view).isEqualTo("user/advertising-form");
        assertThat(model.getAttribute("advertising")).isSameAs(advertising);
        assertThat(advertising.getTitle()).isEqualTo("Moje wpisane ogłoszenie");
        assertThat(result.getFieldError("mileage").getDefaultMessage())
                .isEqualTo("Przebieg musi być większy od 0 km.");
        assertThat(result.getFieldError("year_of_production").getDefaultMessage())
                .isEqualTo("Rok produkcji nie może być późniejszy niż " + (Year.now().getValue() + 1) + ".");
        assertThat(model.getAttribute("maxProductionYear")).isEqualTo(Year.now().getValue() + 1);
        assertThat(model.getAttribute("hasValidationErrors")).isEqualTo(true);
        assertThat(model.getAttribute("categoryHasErrors")).isEqualTo(true);
        verify(advertisingDao, never()).create(any());
    }

    @Test
    void updatesFuelConditionAndDamageFields() {
        UserService userService = mock(UserService.class);
        AdvertisingDao advertisingDao = mock(AdvertisingDao.class);
        CategoryDao categoryDao = mock(CategoryDao.class);
        BrandDao brandDao = mock(BrandDao.class);
        ListingImageStorageService imageStorageService = mock(ListingImageStorageService.class);
        UserController controller = new UserController(userService, advertisingDao, categoryDao,
                brandDao, imageStorageService);

        pl.apexwheels.model.User owner = new pl.apexwheels.model.User();
        owner.setUsername("seller");
        Advertising persisted = new Advertising();
        persisted.setId(42L);
        persisted.setUser(owner);
        persisted.setFuelType("Benzyna");
        persisted.setVehicleCondition("Nowy");
        persisted.setDamageStatus("Nieuszkodzony");
        when(advertisingDao.findById(42L)).thenReturn(persisted);

        Advertising submitted = new Advertising();
        submitted.setFuelType("Hybryda");
        submitted.setVehicleCondition("Używany");
        submitted.setDamageStatus("Uszkodzony");
        BeanPropertyBindingResult result = new BeanPropertyBindingResult(submitted, "advertising");
        ExtendedModelMap model = new ExtendedModelMap();
        User authenticatedUser = (User) User.withUsername("seller").password("password").roles("USER").build();

        String view = controller.submitUpdate(42L, submitted, result, List.of(), authenticatedUser, model);

        assertThat(view).isEqualTo("redirect:/user/advertising/list");
        assertThat(persisted.getFuelType()).isEqualTo("Hybryda");
        assertThat(persisted.getVehicleCondition()).isEqualTo("Używany");
        assertThat(persisted.getDamageStatus()).isEqualTo("Uszkodzony");
        verify(advertisingDao).update(persisted);
    }
}
