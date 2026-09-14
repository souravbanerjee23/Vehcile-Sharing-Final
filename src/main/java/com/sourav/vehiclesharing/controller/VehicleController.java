package com.sourav.vehiclesharing.controller;
import com.sourav.vehiclesharing.model.Vehicle; import com.sourav.vehiclesharing.repository.VehicleRepository; import jakarta.validation.Valid; import org.springframework.http.*; import org.springframework.web.bind.annotation.*; import java.util.*;
@RestController @RequestMapping("/api/vehicles") public class VehicleController { private final VehicleRepository repo; public VehicleController(VehicleRepository r){repo=r;}
 @GetMapping public List<Vehicle> all(){return repo.findAll();} @PostMapping public ResponseEntity<Vehicle> create(@Valid @RequestBody Vehicle v){return ResponseEntity.status(HttpStatus.CREATED).body(repo.save(v));}
}
