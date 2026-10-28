package pl.apexwheels.controller;


import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pl.apexwheels.dao.AdvertisingDao;
import pl.apexwheels.model.Advertising;
import pl.apexwheels.service.UserService;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin")
public class AdminController {

    private final UserService userService;
    private final AdvertisingDao advertisingDao;

    @RequestMapping(value = "/users/list", method = RequestMethod.GET)
    public String usersList(@AuthenticationPrincipal UserDetails customUser, Model model) {
        model.addAttribute("users", userService.findAll());
        return "/admin/users-list";
    }

    @RequestMapping(value = "/advertising/remove/{id}", method = RequestMethod.GET)
    public String formRemove(@PathVariable Long id, Model model) {
        model.addAttribute("advertising", advertisingDao.findById(id));
        return "/user/advertising-remove";
    }

    @RequestMapping(value = "/advertising/remove/{id}", method = RequestMethod.POST)
    public String submitRemove(@PathVariable Long id, @ModelAttribute Advertising advertising, @RequestParam String remove) {
        if (remove.equals("Tak")) {
            advertisingDao.remove(advertising);
        }
        return "redirect:/";
    }
}