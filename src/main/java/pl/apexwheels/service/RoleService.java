package pl.apexwheels.service;

import pl.apexwheels.model.Role;

public interface RoleService {
    Role findByName(String name);

    Role save(Role role);
}