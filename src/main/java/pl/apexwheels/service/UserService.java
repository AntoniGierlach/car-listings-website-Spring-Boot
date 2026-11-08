package pl.apexwheels.service;

import pl.apexwheels.model.User;
import pl.apexwheels.model.dto.RegisterDto;

import java.util.List;
import java.util.Set;

public interface UserService {

    User save(User u);

    User saveAdmin(User u);

    List<User> findAll();
    User update(User user);
    void delete(User user);

    User findByUsername(String username);

    User registerUser(RegisterDto dto);

    Set<pl.apexwheels.model.Advertising> findFavoriteListings(String username);

    boolean toggleFavorite(String username, Long advertisingId);
}