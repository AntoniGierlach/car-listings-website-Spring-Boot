package pl.apexwheels.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.apexwheels.model.ContactMessage;

@Repository
public interface ContactMessageRepository extends JpaRepository<ContactMessage, Long> {
    java.util.List<ContactMessage> findAllByOrderByCreatedAtDesc();
}
