package com.sourav.vehiclesharing.controller;
import com.sourav.vehiclesharing.model.Ride; import com.sourav.vehiclesharing.repository.RideRepository; import jakarta.validation.Valid; import org.springframework.http.*; import org.springframework.web.bind.annotation.*; import java.time.LocalDate; import java.util.*;
@RestController @RequestMapping("/api/rides") public class RideController { private final RideRepository repo; public RideController(RideRepository r){repo=r;}
 @GetMapping public List<Ride> all(){return repo.findAll();} @GetMapping("/{id}") public Ride one(@PathVariable Long id){return repo.findById(id).orElseThrow();}
 @GetMapping("/search") public List<Ride> search(@RequestParam String from,@RequestParam String to,@RequestParam LocalDate date){return repo.findByStartPointIgnoreCaseAndFinalStopIgnoreCaseAndDate(from,to,date);}
 @PostMapping public ResponseEntity<Ride> create(@Valid @RequestBody Ride ride){return ResponseEntity.status(HttpStatus.CREATED).body(repo.save(ride));}
 @DeleteMapping("/{id}") @ResponseStatus(HttpStatus.NO_CONTENT) public void delete(@PathVariable Long id){repo.deleteById(id);}
}
