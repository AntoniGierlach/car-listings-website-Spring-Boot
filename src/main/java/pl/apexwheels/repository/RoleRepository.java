
package pl.apexwheels.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.apexwheels.model.Role;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {

    Role findFirstByName(String name);
}