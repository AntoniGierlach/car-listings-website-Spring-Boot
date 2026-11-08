package pl.apexwheels.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import pl.apexwheels.model.Advertising;
import pl.apexwheels.service.UserService;

import java.security.Principal;
import java.util.List;

@ControllerAdvice
@RequiredArgsConstructor
public class GlobalNavigationAdvice {

    private final UserService userService;

    @ModelAttribute
    public void addNavigationData(Principal principal, org.springframework.ui.Model model) {
        if (principal == null) {
            model.addAttribute("favoriteListingIds", List.of());
            return;
        }

        List<Long> favoriteListingIds = userService.findFavoriteListings(principal.getName()).stream()
                .map(Advertising::getId)
                .toList();
        model.addAttribute("favoriteListingIds", favoriteListingIds);
    }
}
