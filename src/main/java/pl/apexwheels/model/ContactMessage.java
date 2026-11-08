package pl.apexwheels.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Data
public class ContactMessage {

    private static final DateTimeFormatter DISPLAY_DATE_FORMAT =
            DateTimeFormatter.ofPattern("dd.MM.yyyy, HH:mm");

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    private String name;

    @NotBlank
    @Email
    private String email;

    @NotBlank
    @Column(columnDefinition = "LONGTEXT")
    private String message;

    private LocalDateTime createdAt;

    @PrePersist
    public void setCreatedAt() {
        if (createdAt == null) {
            createdAt = LocalDateTime.now();
        }
    }

    public String getFormattedCreatedAt() {
        return createdAt == null ? "" : createdAt.format(DISPLAY_DATE_FORMAT);
    }
}
