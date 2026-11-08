package pl.apexwheels.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import java.time.LocalDate;

@Entity
@Table(name = "advertising")
@Data
public class Advertising {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Podaj tytuł ogłoszenia.")
    @Size(min = 5, max = 120, message = "Tytuł musi mieć od 5 do 120 znaków.")
    @Column(length = 500)
    private String title;

    @NotBlank(message = "Dodaj opis samochodu.")
    @Size(max = 1000, message = "Opis może mieć maksymalnie 1000 znaków.")
    @Column(columnDefinition = "LONGTEXT")
    private String description;

    @Size(max = 255)
    @Pattern(regexp = "[A-Za-z0-9._-]*")
    private String image;

    @NotNull(message = "Podaj przebieg samochodu.")
    @Min(value = 1, message = "Przebieg musi być większy od 0 km.")
    @Max(value = 2_000_000, message = "Podaj przebieg nie większy niż 2 000 000 km.")
    private Integer mileage;

    @NotNull(message = "Podaj moc silnika.")
    @Min(value = 1, message = "Moc silnika musi być większa od 0 KM.")
    @Max(value = 2_000, message = "Podaj moc nie większą niż 2 000 KM.")
    @Column(name = "engine_power")
    private Integer power;

    @NotNull(message = "Podaj cenę samochodu.")
    @Min(value = 1, message = "Cena musi być większa od 0 zł.")
    @Max(value = 100_000_000, message = "Podaj cenę nie większą niż 100 000 000 zł.")
    private Integer price;

    @NotNull(message = "Podaj rok produkcji.")
    @Min(value = 1900, message = "Rok produkcji nie może być wcześniejszy niż 1900.")
    private Integer year_of_production;

    @NotNull(message = "Podaj 9-cyfrowy numer telefonu.")
    @Min(value = 100_000_000, message = "Numer telefonu powinien zawierać 9 cyfr.")
    @Max(value = 999_999_999, message = "Numer telefonu powinien zawierać 9 cyfr.")
    private Integer phone_number;

    @Column(length = 30)
    private String fuelType;

    @Column(length = 20)
    private String vehicleCondition;

    @Column(length = 20)
    private String damageStatus;

    @NotNull(message = "Wybierz kategorię samochodu.")
    @ManyToOne
    private Category category;

    @NotNull(message = "Wybierz markę samochodu.")
    @ManyToOne
    private Brand brand;

    @ManyToOne
    @EqualsAndHashCode.Exclude
    private User user;

    private LocalDate updatedAt;

    @PrePersist
    @PreUpdate
    public void update() {
        LocalDate date = LocalDate.now();
        this.setUpdatedAt(date);
    }
}