package com.sourav.vehiclesharing.service;
import com.sourav.vehiclesharing.model.*; import com.sourav.vehiclesharing.repository.*; import org.springframework.stereotype.Service; import org.springframework.transaction.annotation.Transactional; import java.util.*;
@Service public class BookingService { private final RideRepository rides; private final BookingRepository bookings;
 public BookingService(RideRepository rides,BookingRepository bookings){this.rides=rides;this.bookings=bookings;}
 @Transactional public Booking book(Booking b){ Ride r=rides.findById(b.getRideId()).orElseThrow(()->new IllegalArgumentException("Ride not found"));
  if(!r.getDate().equals(b.getDate())) throw new IllegalArgumentException("Booking date must match ride date");
  List<String> route=new ArrayList<>(); route.add(r.getStartPoint()); for(String s:List.of(n(r.getStop1()),n(r.getStop2()),n(r.getStop3()),n(r.getStop4()))) if(!s.isBlank()) route.add(s); route.add(r.getFinalStop());
  int from=index(route,b.getStartLocation()),to=index(route,b.getDestination()); if(from<0||to<=from) throw new IllegalArgumentException("Destination must occur after start location on the ride route");
  if(b.getSeats()>r.getSeats()) throw new IllegalArgumentException("Not enough seats available"); r.setSeats(r.getSeats()-b.getSeats()); rides.save(r); return bookings.save(b); }
 private int index(List<String> route,String x){for(int i=0;i<route.size();i++)if(route.get(i).equalsIgnoreCase(x))return i;return -1;} private String n(String x){return x==null?"":x;}
}
