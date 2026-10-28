package pl.apexwheels.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import pl.apexwheels.model.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    @Query("select u from User u where u.username=:username")
    User findByUsername(@Param("username") String username);
}