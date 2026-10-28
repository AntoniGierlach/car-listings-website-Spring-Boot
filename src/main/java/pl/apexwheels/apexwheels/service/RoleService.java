package pl.apexwheels.apexwheels.service;

import pl.apexwheels.apexwheels.model.Role;

public interface RoleService {
    Role findByName(String name);

    Role save(Role role);
}