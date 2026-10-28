package pl.apexwheels.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import pl.apexwheels.model.Advertising;

import java.util.List;

@Repository
public interface AdvertisingRepository extends JpaRepository<Advertising, Long> {

    @Query("SELECT a FROM Advertising a WHERE a.mileage BETWEEN :min and :max")
    List<Advertising> findQueryAllByMileageBetween(@Param("min") Integer min, @Param("max") Integer max);

    @Query("SELECT a FROM Advertising a WHERE a.price BETWEEN :min and :max")
    List<Advertising> findQueryAllByPriceBetween(@Param("min") Integer min, @Param("max") Integer max);
}