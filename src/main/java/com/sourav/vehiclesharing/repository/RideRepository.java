package com.sourav.vehiclesharing.repository;
import com.sourav.vehiclesharing.model.Ride; import org.springframework.data.jpa.repository.JpaRepository; import java.time.LocalDate; import java.util.List;
public interface RideRepository extends JpaRepository<Ride,Long>{ List<Ride> findByStartPointIgnoreCaseAndFinalStopIgnoreCaseAndDate(String startPoint,String finalStop,LocalDate date); }
