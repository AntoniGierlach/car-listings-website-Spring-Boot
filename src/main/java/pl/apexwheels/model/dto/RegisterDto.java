package pl.apexwheels.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import pl.apexwheels.model.Role;
import pl.apexwheels.model.User;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import java.util.HashSet;
import java.util.List;

@Data
@NoArgsConstructor
public class RegisterDto {

    @NotBlank(message = "Imię jest wymagane.")
    private String name;
    @NotBlank(message = "Nazwisko jest wymagane.")
    private String lastName;
    @NotBlank(message = "Nazwa użytkownika jest wymagana.")
    private String username;
    @Size(min = 6, message = "Hasło musi mieć co najmniej 6 znaków.")
    private String password;
    @Size(min = 6, message = "Hasło musi mieć co najmniej 6 znaków.")
    private String confirm_password;

    @jakarta.validation.constraints.AssertTrue(message = "Hasła muszą być identyczne.")
    public boolean isPasswordConfirmed() {
        return password != null && password.equals(confirm_password);
    }

    public User map(Role role) {
        if (!this.password.equals(this.confirm_password)) {
            return null;
        }
        User user = new User();
        user.setName(this.name);
        user.setLastName(this.lastName);
        user.setUsername(this.username);
        user.setPassword(this.password);
        user.setEnabled(1);
        user.setRoles(new HashSet<>(List.of(role)));
        return user;
    }
}