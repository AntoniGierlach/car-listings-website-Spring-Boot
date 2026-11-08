package pl.apexwheels.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

import jakarta.persistence.*;
import java.util.Set;

@Entity
@Data
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String lastName;
    private String username;
    private String password;
    private int enabled;
    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.MERGE)
    @EqualsAndHashCode.Exclude
    private Set<Role> roles;

    @ManyToMany(fetch = FetchType.EAGER)
    @EqualsAndHashCode.Exclude
    @JoinTable(name = "user_favorite_advertising",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "advertising_id"))
    private Set<Advertising> favoriteListings = new java.util.HashSet<>();
}