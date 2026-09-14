package com.sourav.vehiclesharing.controller;
import com.sourav.vehiclesharing.model.Booking; import com.sourav.vehiclesharing.repository.BookingRepository; import com.sourav.vehiclesharing.service.BookingService; import jakarta.validation.Valid; import org.springframework.http.*; import org.springframework.web.bind.annotation.*; import java.util.*;
@RestController @RequestMapping("/api/bookings") public class BookingController { private final BookingService service; private final BookingRepository repo; public BookingController(BookingService s,BookingRepository r){service=s;repo=r;}
 @PostMapping public ResponseEntity<Booking> create(@Valid @RequestBody Booking b){return ResponseEntity.status(HttpStatus.CREATED).body(service.book(b));}
 @GetMapping public List<Booking> byPassenger(@RequestParam(required=false) String passengerEmail){return passengerEmail==null?repo.findAll():repo.findByPassengerEmailIgnoreCase(passengerEmail);}
}
