package pl.apexwheels.service;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.authentication.DisabledException;
import pl.apexwheels.model.Role;
import pl.apexwheels.model.User;
import pl.apexwheels.repository.UserRepository;

import java.util.HashSet;
import java.util.Set;


public class SpringDataUserDetailsService implements UserDetailsService {

    private final UserRepository repository;

    public SpringDataUserDetailsService(UserRepository repository) {
        this.repository = repository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = repository.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException(username);
        }
        Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
        for (Role role : user.getRoles()) {
            grantedAuthorities.add(new SimpleGrantedAuthority(role.getName()));
        }

        boolean enabled = user.getEnabled() == 1;
        if (!enabled) {
            throw new DisabledException("Konto użytkownika zostało zablokowane.");
        }
        return new org.springframework.security.core.userdetails.User(
                user.getUsername(),
                user.getPassword(),
                enabled,
                true,
                true,
                true,
                grantedAuthorities);
    }
}