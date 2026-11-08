package pl.apexwheels.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.http.ResponseEntity;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import pl.apexwheels.service.UserService;
import java.security.Principal;
import java.util.List;
import java.util.Map;
import pl.apexwheels.model.Advertising;
import pl.apexwheels.dao.AdvertisingDao;
import pl.apexwheels.dao.BrandDao;
import pl.apexwheels.dao.CategoryDao;

@Controller
@RequiredArgsConstructor
public class SavedListingsController {

    private final AdvertisingDao advertisingDao;
    private final CategoryDao categoryDao;
    private final BrandDao brandDao;
    private final UserService userService;

    @GetMapping("/favorites")
    public String favorites(Model model, Principal principal) {
        addListingData(model);
        model.addAttribute("favoriteItems", userService.findFavoriteListings(principal.getName()));
        return "favorites";
    }

    @PostMapping("/user/favorites/{id}")
    public Object toggleFavorite(@PathVariable Long id,
                                 Principal principal,
                                 @RequestHeader(value = "X-Requested-With", required = false) String requestedWith,
                                 RedirectAttributes redirectAttributes) {
        if (!userService.toggleFavorite(principal.getName(), id)) {
            if ("XMLHttpRequest".equalsIgnoreCase(requestedWith)) {
                return ResponseEntity.badRequest().body(Map.of("message", "Nie udało się zmienić zapisanych ofert."));
            }
            redirectAttributes.addFlashAttribute("favoriteError", "Nie udało się zmienić zapisanych ofert.");
        } else if ("XMLHttpRequest".equalsIgnoreCase(requestedWith)) {
            List<Long> favoriteListingIds = userService.findFavoriteListings(principal.getName()).stream()
                    .map(Advertising::getId)
                    .toList();
            return ResponseEntity.ok(Map.of("favoriteListingIds", favoriteListingIds));
        }
        return "redirect:/favorites";
    }

    @GetMapping("/compare")
    public String compare(Model model) {
        addListingData(model);
        return "compare";
    }

    private void addListingData(Model model) {
        model.addAttribute("items", advertisingDao.findAllSortByDateDesc());
        model.addAttribute("category", categoryDao.findAll());
        model.addAttribute("brand", brandDao.findAll());
    }
}
