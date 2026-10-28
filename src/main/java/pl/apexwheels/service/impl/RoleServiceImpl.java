package pl.apexwheels.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pl.apexwheels.model.Role;
import pl.apexwheels.repository.RoleRepository;
import pl.apexwheels.service.RoleService;

@Service
@RequiredArgsConstructor
public class RoleServiceImpl implements RoleService {

    private final RoleRepository repository;

    @Override
    public Role findByName(String name) {
        return repository.findFirstByName(name);
    }

    @Override
    public Role save(Role role) {
        return repository.save(role);
    }
}