package pl.apexwheels.controller;

import lombok.RequiredArgsConstructor;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pl.apexwheels.dao.AdvertisingDao;
import pl.apexwheels.dao.BrandDao;
import pl.apexwheels.dao.CategoryDao;
import pl.apexwheels.model.Advertising;
import pl.apexwheels.model.Brand;
import pl.apexwheels.model.Category;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/advertising")
public class AdvertisingController {

    private final AdvertisingDao advertisingDao;
    private final CategoryDao categoryDao;
    private final BrandDao brandDao;

    @ModelAttribute("category")
    public List<Category> category() {
        return categoryDao.findAll();
    }

    @ModelAttribute("brand")
    public List<Brand> brand() {
        return brandDao.findAll();
    }

    @GetMapping("/details/{id}")
    public String details(@PathVariable("id") Long advertisingId, Model model,
                          HttpServletResponse response) {
        Advertising item = advertisingDao.findById(advertisingId);
        if (item == null) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            model.addAttribute("status", HttpServletResponse.SC_NOT_FOUND);
            return "error";
        }
        model.addAttribute("item", item);
        return "advertising-details";
    }

    @GetMapping({"", "/"})
    public String all(Model model) {
        model.addAttribute("items", advertisingDao.findAllSortByDateDesc());
        model.addAttribute("showSearchSidebar", true);
        return "index";
    }

    @GetMapping("/search")
    public String search(@RequestParam(required = false) Long brandId,
                         @RequestParam(required = false) Long categoryId,
                         @RequestParam(required = false) Integer minPrice,
                         @RequestParam(required = false) Integer maxPrice,
                         @RequestParam(required = false) Integer minMileage,
                         @RequestParam(required = false) Integer maxMileage,
                         @RequestParam(required = false) String fuelType,
                         @RequestParam(required = false) String vehicleCondition,
                         @RequestParam(required = false) String damageStatus,
                         @RequestParam(required = false) String searchText,
                         @RequestParam(required = false, defaultValue = "date") String sort,
                         Model model) {
        addSearchSelections(model, brandId, categoryId);
        boolean invalidBrand = brandId != null && brandDao.findById(brandId) == null;
        boolean invalidCategory = categoryId != null && categoryDao.findById(categoryId) == null;
        boolean invalidPriceRange = isInvalidRange(minPrice, maxPrice);
        boolean invalidMileageRange = isInvalidRange(minMileage, maxMileage);
        boolean invalidMinPrice = hasNegativeValue(minPrice);
        boolean invalidMaxPrice = hasNegativeValue(maxPrice);
        boolean invalidMinMileage = hasNegativeValue(minMileage);
        boolean invalidMaxMileage = hasNegativeValue(maxMileage);

        if (invalidBrand || invalidCategory || invalidPriceRange || invalidMileageRange
                || invalidMinPrice || invalidMaxPrice || invalidMinMileage || invalidMaxMileage) {
            model.addAttribute("searchError", "Popraw zaznaczone pola i spróbuj ponownie.");
            model.addAttribute("invalidBrand", invalidBrand);
            model.addAttribute("invalidCategory", invalidCategory);
            model.addAttribute("invalidMinPrice", invalidMinPrice || invalidPriceRange);
            model.addAttribute("invalidMaxPrice", invalidMaxPrice || invalidPriceRange);
            model.addAttribute("invalidMinMileage", invalidMinMileage || invalidMileageRange);
            model.addAttribute("invalidMaxMileage", invalidMaxMileage || invalidMileageRange);
            model.addAttribute("items", List.of());
            model.addAttribute("showSearchSidebar", true);
            return "index";
        }

        model.addAttribute("items", advertisingDao.search(brandId, categoryId, minPrice, maxPrice,
                minMileage, maxMileage, fuelType, vehicleCondition, damageStatus, searchText, sort));
        model.addAttribute("showSearchSidebar", true);
        return "index";
    }

    private void addSearchSelections(Model model, Long brandId, Long categoryId) {
        if (brandId != null) {
            model.addAttribute("selectedBrand", brandDao.findById(brandId));
        }
        if (categoryId != null) {
            model.addAttribute("selectedCategory", categoryDao.findById(categoryId));
        }
    }

    @RequestMapping("/category/{id}")
    public String findAllByCategoryId(@PathVariable Long id, Model model) {
        List<Advertising> list = advertisingDao.findAllWithCategory(categoryDao.findById(id));
        model.addAttribute("items", list);
        model.addAttribute("showSearchSidebar", true);
        return "index";
    }

    @RequestMapping("/brand/{id}")
    public String findAllByBrandId(@PathVariable Long id, Model model) {
        List<Advertising> list = advertisingDao.findAllWithBrand(brandDao.findById(id));
        model.addAttribute("items", list);
        model.addAttribute("showSearchSidebar", true);
        return "index";
    }

    @RequestMapping(value = "/mileage")
    public String findAllByRatingBetween(@RequestParam(name = "min") Integer min, @RequestParam(name = "max") Integer max, Model model) {
        return search(null, null, null, null, min, max, null, null, null, null, "date", model);
    }

    @RequestMapping(value = "/price")
    public String findAllByPriceBetween(@RequestParam(name = "min") Integer min, @RequestParam(name = "max") Integer max, Model model) {
        return search(null, null, min, max, null, null, null, null, null, null, "date", model);
    }

    @RequestMapping(value = "/sort/mileageMin")
    public String findAllSortByMileageAsc(Model model) {
        model.addAttribute("items", advertisingDao.findAllSortByMileageAsc());
        model.addAttribute("showSearchSidebar", true);
        return "index";
    }

    @RequestMapping(value = "/sort/mileageMax")
    public String findAllSortByMileageDesc(Model model) {
        model.addAttribute("items", advertisingDao.findAllSortByMileageDesc());
        model.addAttribute("showSearchSidebar", true);
        return "index";
    }

    @RequestMapping(value = "/sort/priceMin")
    public String findAllSortByPriceAsc(Model model) {
        model.addAttribute("items", advertisingDao.findAllSortByPriceAsc());
        model.addAttribute("showSearchSidebar", true);
        return "index";
    }

    @RequestMapping(value = "/sort/priceMax")
    public String findAllSortByPriceDesc(Model model) {
        model.addAttribute("items", advertisingDao.findAllSortByPriceDesc());
        model.addAttribute("showSearchSidebar", true);
        return "index";
    }

    @RequestMapping(value = "/sort/date")
    public String findAllSortByDateDesc(Model model) {
        model.addAttribute("items", advertisingDao.findAllSortByDateDesc());
        model.addAttribute("showSearchSidebar", true);
        return "index";
    }

    private boolean isInvalidRange(Integer min, Integer max) {
        return min != null && max != null && min > max;
    }

    private boolean hasNegativeValue(Integer value) {
        return value != null && value < 0;
    }
}