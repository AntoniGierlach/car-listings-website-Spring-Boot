package pl.apexwheels.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import pl.apexwheels.dao.AdvertisingDao;
import pl.apexwheels.dao.BrandDao;
import pl.apexwheels.dao.CategoryDao;
import pl.apexwheels.model.Advertising;
import pl.apexwheels.service.InvalidListingImageException;
import pl.apexwheels.service.ListingImageStorageException;
import pl.apexwheels.service.ListingImageStorageService;
import pl.apexwheels.service.UserService;
import org.springframework.web.multipart.MultipartFile;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import jakarta.validation.Valid;
import java.time.Year;
import java.util.List;
import java.util.Objects;

@RequiredArgsConstructor
@Controller
@RequestMapping("/user")
public class UserController {

    private static final Logger log = LoggerFactory.getLogger(UserController.class);

    private final UserService userService;
    private final AdvertisingDao advertisingDao;
    private final CategoryDao categoryDao;
    private final BrandDao brandDao;
    private final ListingImageStorageService imageStorageService;

    @RequestMapping(value = "/advertising/list", method = RequestMethod.GET)
    public String index(@AuthenticationPrincipal UserDetails customUser, Model model) {
        List<Advertising> adsList = advertisingDao.findAllWithUsername(customUser.getUsername());
        model.addAttribute("category", categoryDao.findAll());
        model.addAttribute("brand", brandDao.findAll());
        model.addAttribute("items", adsList);
        return "user/advertising-list";
    }

    @RequestMapping(value = "/advertising/create", method = RequestMethod.GET)
    public String formCreate(Model model) {
        model.addAttribute("advertising", new Advertising());
        populateFormOptions(model);
        return "user/advertising-form";
    }

    @RequestMapping(value = "/advertising/create", method = RequestMethod.POST)
    public String submitCreate(@Valid @ModelAttribute Advertising advertising, BindingResult result,
                               @RequestParam(value = "imageFile", required = false) List<MultipartFile> imageFiles,
                               @AuthenticationPrincipal UserDetails user, Model model) {
        advertising.setImage(null);
        validateProductionYear(advertising, result);
        if (result.hasErrors() || !attachImage(imageFiles, advertising, result)) {
            populateFormOptions(model);
            addFormValidationState(model, result);
            return "user/advertising-form";
        }
        advertising.setId(null);
        advertising.setUser(userService.findByUsername(user.getUsername()));
        try {
            advertisingDao.create(advertising);
        } catch (RuntimeException exception) {
            cleanupAfterFailedPersistence(advertising.getImage(), exception);
            throw exception;
        }
        return "redirect:/user/advertising/list";
    }

    @RequestMapping(value = "/advertising/update/{id}", method = RequestMethod.GET)
    public String formUpdate(@PathVariable Long id, @AuthenticationPrincipal UserDetails user, Model model) {
        Advertising advertising = advertisingDao.findById(id);
        if (!canManage(advertising, user)) {
            return "redirect:/user/advertising/list";
        }
        model.addAttribute("advertising", advertising);
        populateFormOptions(model);
        return "user/advertising-form";
    }

    @RequestMapping(value = "/advertising/update/{id}", method = RequestMethod.POST)
    public String submitUpdate(@PathVariable Long id, @Valid @ModelAttribute Advertising advertising,
                               BindingResult result,
                               @RequestParam(value = "imageFile", required = false) List<MultipartFile> imageFiles,
                               @AuthenticationPrincipal UserDetails user, Model model) {
        Advertising persistedAdvertising = advertisingDao.findById(id);
        if (!canManage(persistedAdvertising, user)) {
            return "redirect:/user/advertising/list";
        }
        advertising.setImage(persistedAdvertising.getImage());
        validateProductionYear(advertising, result);
        if (result.hasErrors() || !attachImage(imageFiles, advertising, result)) {
            populateFormOptions(model);
            addFormValidationState(model, result);
            return "user/advertising-form";
        }
        String previousImage = persistedAdvertising.getImage();
        persistedAdvertising.setTitle(advertising.getTitle());
        persistedAdvertising.setDescription(advertising.getDescription());
        persistedAdvertising.setMileage(advertising.getMileage());
        persistedAdvertising.setPower(advertising.getPower());
        persistedAdvertising.setPrice(advertising.getPrice());
        persistedAdvertising.setYear_of_production(advertising.getYear_of_production());
        persistedAdvertising.setPhone_number(advertising.getPhone_number());
        persistedAdvertising.setFuelType(advertising.getFuelType());
        persistedAdvertising.setVehicleCondition(advertising.getVehicleCondition());
        persistedAdvertising.setDamageStatus(advertising.getDamageStatus());
        persistedAdvertising.setImage(advertising.getImage());
        persistedAdvertising.setCategory(advertising.getCategory());
        persistedAdvertising.setBrand(advertising.getBrand());
        try {
            advertisingDao.update(persistedAdvertising);
        } catch (RuntimeException exception) {
            if (!Objects.equals(previousImage, advertising.getImage())) {
                cleanupAfterFailedPersistence(advertising.getImage(), exception);
            }
            throw exception;
        }
        if (!Objects.equals(previousImage, persistedAdvertising.getImage())) {
            deleteReplacedImage(previousImage);
        }
        return "redirect:/user/advertising/list";
    }

    @RequestMapping(value = "/advertising/remove/{id}", method = RequestMethod.GET)
    public String formRemove() {
        return "redirect:/user/advertising/list";
    }

    @RequestMapping(value = "/advertising/remove/{id}", method = RequestMethod.POST)
    public String submitRemove(@PathVariable Long id, @AuthenticationPrincipal UserDetails user,
                               @RequestParam String remove) {
        Advertising advertising = advertisingDao.findById(id);
        if ("Tak".equals(remove) && canManage(advertising, user)) {
            advertisingDao.remove(advertising);
        }
        return "redirect:/user/advertising/list";
    }

    @RequestMapping(value = "/changePassword", method = RequestMethod.GET)
    public String changePassword() {
        return "user/change-password";
    }

    private boolean canManage(Advertising advertising, UserDetails user) {
        if (advertising == null || user == null) {
            return false;
        }
        return user.getAuthorities().stream()
                .anyMatch(authority -> authority.getAuthority().equals("ROLE_ADMIN"))
                || (advertising.getUser() != null
                && advertising.getUser().getUsername().equals(user.getUsername()));
    }

    private boolean attachImage(List<MultipartFile> imageFiles, Advertising advertising, BindingResult result) {
        if (imageFiles == null || imageFiles.isEmpty()) {
            return true;
        }
        if (imageFiles.size() > 1) {
            result.rejectValue("image", "advertising.image.multiple");
            return false;
        }

        MultipartFile imageFile = imageFiles.get(0);
        if (imageFile.isEmpty()) {
            return true;
        }
        try {
            advertising.setImage(imageStorageService.store(imageFile));
            return true;
        } catch (InvalidListingImageException exception) {
            result.rejectValue("image", exception.getMessageKey());
            return false;
        } catch (ListingImageStorageException exception) {
            log.error("Could not store listing image", exception);
            result.rejectValue("image", "advertising.image.storage");
            return false;
        }
    }

    private void populateFormOptions(Model model) {
        model.addAttribute("category", categoryDao.findAll());
        model.addAttribute("brand", brandDao.findAll());
        model.addAttribute("items", advertisingDao.findAll());
        model.addAttribute("maxProductionYear", Year.now().getValue() + 1);
        model.addAttribute("hasValidationErrors", false);
        model.addAttribute("brandHasErrors", false);
        model.addAttribute("categoryHasErrors", false);
        model.addAttribute("fuelTypeHasErrors", false);
        model.addAttribute("vehicleConditionHasErrors", false);
        model.addAttribute("damageStatusHasErrors", false);
    }

    private void addFormValidationState(Model model, BindingResult result) {
        model.addAttribute("hasValidationErrors", result.hasErrors());
        model.addAttribute("brandHasErrors", hasFieldErrors(result, "brand"));
        model.addAttribute("categoryHasErrors", hasFieldErrors(result, "category"));
        model.addAttribute("fuelTypeHasErrors", hasFieldErrors(result, "fuelType"));
        model.addAttribute("vehicleConditionHasErrors", hasFieldErrors(result, "vehicleCondition"));
        model.addAttribute("damageStatusHasErrors", hasFieldErrors(result, "damageStatus"));
    }

    private boolean hasFieldErrors(BindingResult result, String field) {
        return result.hasFieldErrors(field) || result.hasFieldErrors(field + ".id");
    }

    private void validateProductionYear(Advertising advertising, BindingResult result) {
        int maxProductionYear = Year.now().getValue() + 1;
        if (advertising.getYear_of_production() != null
                && advertising.getYear_of_production() > maxProductionYear) {
            result.rejectValue("year_of_production", "advertising.year.future",
                    "Rok produkcji nie może być późniejszy niż " + maxProductionYear + ".");
        }
    }

    private void cleanupAfterFailedPersistence(String filename, RuntimeException originalFailure) {
        try {
            imageStorageService.deleteUploadedImage(filename);
        } catch (ListingImageStorageException cleanupFailure) {
            originalFailure.addSuppressed(cleanupFailure);
        }
    }

    private void deleteReplacedImage(String filename) {
        try {
            imageStorageService.deleteUploadedImage(filename);
        } catch (ListingImageStorageException cleanupFailure) {
            log.warn("Could not remove replaced listing image {}", filename, cleanupFailure);
        }
    }
}