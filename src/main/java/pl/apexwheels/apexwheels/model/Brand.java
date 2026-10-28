package pl.apexwheels.apexwheels.model;

import lombok.Data;

import jakarta.persistence.*;

@Entity
@Table(name = "brand")
@Data
public class Brand {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
}