package com.sourav.vehiclesharing.repository;
import com.sourav.vehiclesharing.model.Booking; import org.springframework.data.jpa.repository.JpaRepository; import java.util.List;
public interface BookingRepository extends JpaRepository<Booking,Long>{ List<Booking> findByPassengerEmailIgnoreCase(String email); }
