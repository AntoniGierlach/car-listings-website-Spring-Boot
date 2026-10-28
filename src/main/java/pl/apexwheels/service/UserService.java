package pl.apexwheels.service;

import pl.apexwheels.model.User;
import pl.apexwheels.model.dto.RegisterDto;

import java.util.List;

public interface UserService {

    User save(User u);

    User saveAdmin(User u);

    List<User> findAll();

    User findByUsername(String username);

    User registerUser(RegisterDto dto);
}