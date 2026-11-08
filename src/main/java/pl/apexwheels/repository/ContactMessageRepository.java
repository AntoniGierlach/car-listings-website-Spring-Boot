package pl.apexwheels.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.apexwheels.model.ContactMessage;

public interface ContactMessageRepository extends JpaRepository<ContactMessage, Long> {
    java.util.List<ContactMessage> findAllByOrderByCreatedAtDesc();
}
