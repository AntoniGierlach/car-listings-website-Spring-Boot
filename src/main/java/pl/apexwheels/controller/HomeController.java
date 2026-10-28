package pl.apexwheels.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import pl.apexwheels.dao.AdvertisingDao;
import pl.apexwheels.dao.BrandDao;
import pl.apexwheels.dao.CategoryDao;
import pl.apexwheels.model.User;
import pl.apexwheels.model.dto.RegisterDto;
import pl.apexwheels.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

@RequiredArgsConstructor
@Controller
public class HomeController {

    private final UserService userService;
    private final AdvertisingDao advertisingDao;
    private final CategoryDao categoryDao;
    private final BrandDao brandDao;


    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index(Model model) {
        model.addAttribute("category", categoryDao.findAll());
        model.addAttribute("brand", brandDao.findAll());
        model.addAttribute("items", advertisingDao.findAll());
        return "index";
    }

    @RequestMapping(value = "/placeholder", method = RequestMethod.GET)
    public String placeholder(Model model) {
        model.addAttribute("category", categoryDao.findAll());
        model.addAttribute("brand", brandDao.findAll());
        model.addAttribute("items", advertisingDao.findAll());
        return "placeholder";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@Valid BindingResult result, Errors errors) {
        if (result.hasErrors()) {
            return "login";
        }
        return "redirect:/";
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String register(Model model) {
        model.addAttribute("registerDto", new RegisterDto());
        return "register";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(@Valid @ModelAttribute RegisterDto registerDto, BindingResult result, HttpServletRequest request, Errors errors) {
        User user = null;
        if (!result.hasErrors()) {
            user = userService.registerUser(registerDto);
            if (user != null) {
                return "redirect:login";
            }
        }
        return "register";
    }
}