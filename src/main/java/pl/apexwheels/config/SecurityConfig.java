package pl.apexwheels.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.authentication.DisabledException;
import pl.apexwheels.service.SpringDataUserDetailsService;
import pl.apexwheels.repository.UserRepository;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/").permitAll()
                        .requestMatchers("/favorites").hasAnyRole("USER", "ADMIN")
                        .requestMatchers("/user/favorites/**").hasAnyRole("USER", "ADMIN")
                        .requestMatchers("/user/**").hasAnyRole("USER", "ADMIN")
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        .anyRequest().permitAll())
                .formLogin(form -> form
                        .loginPage("/login")
                        .defaultSuccessUrl("/", true)
                        .failureHandler((request, response, exception) -> {
                            if (exception instanceof DisabledException) {
                                response.sendRedirect(request.getContextPath() + "/login?error=blocked");
                            } else {
                                response.sendRedirect(request.getContextPath() + "/login?error=invalid");
                            }
                        })
                        .permitAll())
                .logout(logout -> logout
                        .logoutUrl("/user/logout")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                        .logoutSuccessUrl("/"));
        return http.build();
    }

    @Bean
    public SpringDataUserDetailsService customUserDetailsService(UserRepository userRepository) {
        return new SpringDataUserDetailsService(userRepository);
    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}