package com.sourav.vehiclesharing.repository;
import com.sourav.vehiclesharing.model.Vehicle; import org.springframework.data.jpa.repository.JpaRepository; import java.util.Optional;
public interface VehicleRepository extends JpaRepository<Vehicle,Long>{ Optional<Vehicle> findByVehicleNo(String vehicleNo); }
