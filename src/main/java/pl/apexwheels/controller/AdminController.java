package pl.apexwheels.controller;


import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pl.apexwheels.dao.AdvertisingDao;
import pl.apexwheels.model.Advertising;
import pl.apexwheels.model.ContactMessage;
import pl.apexwheels.model.User;
import pl.apexwheels.repository.ContactMessageRepository;
import pl.apexwheels.service.UserService;

import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin")
public class AdminController {

    private final UserService userService;
    private final AdvertisingDao advertisingDao;
    private final ContactMessageRepository contactMessageRepository;

    @RequestMapping(value = "/users/list", method = RequestMethod.GET)
    public String usersList(@AuthenticationPrincipal UserDetails customUser,
                            @RequestParam(defaultValue = "users") String tab, Model model) {
        model.addAttribute("users", userService.findAll());
        model.addAttribute("items", advertisingDao.findAllSortByDateDesc());
        model.addAttribute("messages", contactMessageRepository.findAllByOrderByCreatedAtDesc());
        model.addAttribute("activeTab", List.of("users", "advertising", "messages").contains(tab) ? tab : "users");
        return "admin/users-list";
    }

    @GetMapping("/advertising/list")
    public String advertisingList(Model model) {
        return "redirect:/admin/users/list?tab=advertising";
    }

    @RequestMapping(value = "/advertising/remove/{id}", method = RequestMethod.GET)
    public String formRemove(@PathVariable Long id, Model model) {
        Advertising advertising = advertisingDao.findById(id);
        if (advertising == null) {
            return "redirect:/admin/users/list?tab=advertising";
        }
        model.addAttribute("advertising", advertising);
        return "admin/advertising-remove";
    }

    @RequestMapping(value = "/advertising/remove/{id}", method = RequestMethod.POST)
    public String submitRemove(@PathVariable Long id, @RequestParam String remove) {
        Advertising advertising = advertisingDao.findById(id);
        if ("Tak".equals(remove) && advertising != null) {
            advertisingDao.remove(advertising);
        }
        return "redirect:/admin/users/list?tab=advertising";
    }

    @GetMapping("/users/remove/{id}")
    public String formRemoveUser(@PathVariable Long id, Model model) {
        User user = findUser(id);
        if (user == null || isAdmin(user)) {
            return "redirect:/admin/users/list";
        }
        model.addAttribute("user", user);
        return "admin/user-remove";
    }

    @PostMapping("/users/remove/{id}")
    public String submitRemoveUser(@PathVariable Long id, @RequestParam String remove) {
        User user = findUser(id);
        if ("Tak".equals(remove) && user != null && !isAdmin(user)) {
            List<Advertising> listings = advertisingDao.findAllWithUsername(user.getUsername());
            listings.forEach(advertisingDao::remove);
            user.getFavoriteListings().clear();
            userService.update(user);
            userService.delete(user);
        }
        return "redirect:/admin/users/list";
    }

    @GetMapping("/messages")
    public String messages(Model model) {
        return "redirect:/admin/users/list?tab=messages";
    }

    @PostMapping("/users/{id}/status")
    public String updateUserStatus(@PathVariable Long id, @RequestParam int enabled) {
        User user = userService.findAll().stream()
                .filter(candidate -> candidate.getId().equals(id))
                .findFirst()
                .orElse(null);
        if (user != null && (enabled == 0 || enabled == 1)) {
            user.setEnabled(enabled);
            userService.update(user);
        }
        return "redirect:/admin/users/list?tab=users";
    }

    private User findUser(Long id) {
        return userService.findAll().stream()
                .filter(candidate -> candidate.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    private boolean isAdmin(User user) {
        return user.getRoles() != null && user.getRoles().stream()
                .anyMatch(role -> "ROLE_ADMIN".equals(role.getName()));
    }
}