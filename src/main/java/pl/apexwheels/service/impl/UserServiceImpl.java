package pl.apexwheels.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import pl.apexwheels.model.Role;
import pl.apexwheels.model.User;
import pl.apexwheels.model.Advertising;
import pl.apexwheels.model.dto.RegisterDto;
import pl.apexwheels.repository.RoleRepository;
import pl.apexwheels.repository.UserRepository;
import pl.apexwheels.repository.AdvertisingRepository;
import pl.apexwheels.service.UserService;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@RequiredArgsConstructor
@Service
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final AdvertisingRepository advertisingRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public User save(User u) {
        u.setPassword(passwordEncoder.encode(u.getPassword()));
        u.setEnabled(1);
        Role userRole = roleRepository.findFirstByName("ROLE_USER");
        u.setRoles(new HashSet<Role>(List.of(userRole)));
        return userRepository.save(u);
    }

    @Override
    public User saveAdmin(User u) {
        u.setPassword(passwordEncoder.encode(u.getPassword()));
        u.setEnabled(1);
        Role userRole = roleRepository.findFirstByName("ROLE_USER");
        Role adminRole = roleRepository.findFirstByName("ROLE_ADMIN");
        u.setRoles(new HashSet<Role>(Arrays.asList(userRole, adminRole)));
        return userRepository.save(u);
    }

    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    public User update(User user) {
        return userRepository.save(user);
    }

    @Override
    public void delete(User user) {
        userRepository.delete(user);
    }

    @Override
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    public User registerUser(RegisterDto dto) {
        if (userRepository.findByUsername(dto.getUsername()) != null) {
            return null;
        }
        User user = dto.map(roleRepository.findFirstByName("ROLE_USER"));
        if (user == null) {
            return null;
        }
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userRepository.save(user);
    }

    @Override
    public Set<Advertising> findFavoriteListings(String username) {
        User user = userRepository.findByUsername(username);
        return user == null ? Set.of() : user.getFavoriteListings();
    }

    @Override
    public boolean toggleFavorite(String username, Long advertisingId) {
        User user = userRepository.findByUsername(username);
        if (user == null) {
            return false;
        }
        Advertising listing = advertisingRepository.findById(advertisingId).orElse(null);
        if (listing == null) {
            return false;
        }
        if (!user.getFavoriteListings().remove(listing)) {
            user.getFavoriteListings().add(listing);
        }
        userRepository.save(user);
        return true;
    }
}