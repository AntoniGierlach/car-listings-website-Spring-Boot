package pl.apexwheels.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pl.apexwheels.dao.BrandDao;
import pl.apexwheels.dao.CategoryDao;
import pl.apexwheels.model.Brand;
import pl.apexwheels.model.Category;
import pl.apexwheels.model.ContactMessage;
import pl.apexwheels.repository.ContactMessageRepository;

import java.util.List;

@Controller
public class InformationController {

    private final CategoryDao categoryDao;
    private final BrandDao brandDao;
    private final ContactMessageRepository contactMessageRepository;

    public InformationController(CategoryDao categoryDao, BrandDao brandDao,
                                 ContactMessageRepository contactMessageRepository) {
        this.categoryDao = categoryDao;
        this.brandDao = brandDao;
        this.contactMessageRepository = contactMessageRepository;
    }

    @org.springframework.web.bind.annotation.ModelAttribute("category")
    public List<Category> categories() {
        return categoryDao.findAll();
    }

    @org.springframework.web.bind.annotation.ModelAttribute("brand")
    public List<Brand> brands() {
        return brandDao.findAll();
    }

    @GetMapping({"/about", "/o-nas"})
    public String about() {
        return "about";
    }

    @GetMapping("/faq")
    public String faq() {
        return "faq";
    }

    @GetMapping({"/help", "/centrum-pomocy"})
    public String help() {
        return "help";
    }

    @GetMapping("/safety")
    public String safety() {
        return "safety";
    }

    @GetMapping("/contact")
    public String contact(Model model) {
        return "contact";
    }

    @PostMapping("/contact")
    public String submitContact(@RequestParam String name,
                                @RequestParam String email,
                                @RequestParam String message,
                                Model model) {
        if (name.isBlank() || email.isBlank() || message.isBlank()) {
            model.addAttribute("error", "Uzupełnij imię, adres e-mail i treść wiadomości.");
            return "contact";
        }
        ContactMessage contactMessage = new ContactMessage();
        contactMessage.setName(name.trim());
        contactMessage.setEmail(email.trim());
        contactMessage.setMessage(message.trim());
        contactMessageRepository.save(contactMessage);
        model.addAttribute("sent", true);
        return "contact";
    }
}
