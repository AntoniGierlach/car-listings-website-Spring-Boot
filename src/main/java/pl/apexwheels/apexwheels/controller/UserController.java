package pl.apexwheels.apexwheels.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import pl.apexwheels.apexwheels.dao.AdvertisingDao;
import pl.apexwheels.apexwheels.dao.BrandDao;
import pl.apexwheels.apexwheels.dao.CategoryDao;
import pl.apexwheels.apexwheels.model.Advertising;
import pl.apexwheels.apexwheels.service.UserService;

import jakarta.validation.Valid;
import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/user")
public class UserController {

    private final UserService userService;
    private final AdvertisingDao advertisingDao;
    private final CategoryDao categoryDao;
    private final BrandDao brandDao;

    @RequestMapping(value = "/advertising/list", method = RequestMethod.GET)
    public String index(@AuthenticationPrincipal UserDetails customUser, Model model) {
        List<Advertising> adsList = advertisingDao.findAllWithUsername(customUser.getUsername());
        model.addAttribute("category", categoryDao.findAll());
        model.addAttribute("brand", brandDao.findAll());
        model.addAttribute("items", adsList);
        if (adsList.size() != 0) {
            return "/user/advertising-list";
        }
        return "no-results";
    }

    @RequestMapping(value = "/advertising/create", method = RequestMethod.GET)
    public String formCreate(Model model) {
        model.addAttribute("advertising", new Advertising());
        model.addAttribute("category", categoryDao.findAll());
        model.addAttribute("brand", brandDao.findAll());
        model.addAttribute("items", advertisingDao.findAll());
        return "/user/advertising-form";
    }

    @RequestMapping(value = "/advertising/create", method = RequestMethod.POST)
    public String submitCreate(@Valid @ModelAttribute Advertising advertising, BindingResult result, @AuthenticationPrincipal UserDetails user, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("category", categoryDao.findAll());
            model.addAttribute("brand", brandDao.findAll());
            model.addAttribute("items", advertisingDao.findAll());
            return "/user/advertising-form";
        }
        advertising.setUser(userService.findByUsername(user.getUsername()));
        advertisingDao.create(advertising);
        return "redirect:/user/advertising/list";
    }

    @RequestMapping(value = "/advertising/update/{id}", method = RequestMethod.GET)
    public String formUpdate(@PathVariable Long id, @AuthenticationPrincipal UserDetails user, Model model) {
        Advertising advertising = advertisingDao.findById(id);
        if (!canManage(advertising, user)) {
            return "redirect:/user/advertising/list";
        }
        model.addAttribute("advertising", advertising);
        model.addAttribute("category", categoryDao.findAll());
        model.addAttribute("brand", brandDao.findAll());
        model.addAttribute("items", advertisingDao.findAll());
        return "/user/advertising-form";
    }

    @RequestMapping(value = "/advertising/update/{id}", method = RequestMethod.POST)
    public String submitUpdate(@PathVariable Long id, @Valid @ModelAttribute Advertising advertising, BindingResult result, @AuthenticationPrincipal UserDetails user, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("category", categoryDao.findAll());
            model.addAttribute("brand", brandDao.findAll());
            model.addAttribute("items", advertisingDao.findAll());
            return "/user/advertising-form";
        }
        Advertising persistedAdvertising = advertisingDao.findById(id);
        if (!canManage(persistedAdvertising, user)) {
            return "redirect:/user/advertising/list";
        }
        persistedAdvertising.setTitle(advertising.getTitle());
        persistedAdvertising.setDescription(advertising.getDescription());
        persistedAdvertising.setMileage(advertising.getMileage());
        persistedAdvertising.setPrice(advertising.getPrice());
        persistedAdvertising.setYear_of_production(advertising.getYear_of_production());
        persistedAdvertising.setPhone_number(advertising.getPhone_number());
        persistedAdvertising.setCategory(advertising.getCategory());
        persistedAdvertising.setBrand(advertising.getBrand());
        advertisingDao.update(persistedAdvertising);
        return "redirect:/user/advertising/list";
    }

    @RequestMapping(value = "/advertising/remove/{id}", method = RequestMethod.GET)
    public String formRemove(@PathVariable Long id, @AuthenticationPrincipal UserDetails user, Model model) {
        Advertising advertising = advertisingDao.findById(id);
        if (!canManage(advertising, user)) {
            return "redirect:/user/advertising/list";
        }
        model.addAttribute("advertising", advertising);
        return "/user/advertising-remove";
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
        return "/user/change-password";
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
}