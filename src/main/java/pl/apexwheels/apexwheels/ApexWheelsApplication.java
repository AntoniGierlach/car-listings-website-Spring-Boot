package pl.apexwheels.apexwheels;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import pl.apexwheels.apexwheels.model.Role;
import pl.apexwheels.apexwheels.model.User;
import pl.apexwheels.apexwheels.service.RoleService;
import pl.apexwheels.apexwheels.service.UserService;

@SpringBootApplication
public class ApexWheelsApplication {

    public static void main(String[] args) {
        SpringApplication.run(ApexWheelsApplication.class, args);
    }

    @Bean
    CommandLineRunner init(UserService userService, RoleService roleService) {
        return (args) -> {

            if (roleService.findByName("ROLE_ADMIN") == null) {
                Role r = new Role();
                r.setName("ROLE_ADMIN");
                roleService.save(r);
            }
            if (roleService.findByName("ROLE_USER") == null) {
                Role r = new Role();
                r.setName("ROLE_USER");
                roleService.save(r);
            }
            if (userService.findByUsername("admin") == null) {

                User user = new User();
                user.setName("Super user");
                user.setUsername("admin");
                user.setPassword("admin");
                userService.saveAdmin(user);
            }
        };
    }
}