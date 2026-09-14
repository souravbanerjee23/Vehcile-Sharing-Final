package com.sourav.vehiclesharing.model;
import jakarta.persistence.*; import jakarta.validation.constraints.*; import java.time.LocalDate;
@Entity @Table(name="bookings") public class Booking {
 @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id; @NotNull private Long rideId; @NotBlank private String passengerEmail;
 @NotBlank private String startLocation; @NotBlank private String destination; @Min(1) private int seats; @NotNull @FutureOrPresent private LocalDate date;
 @Enumerated(EnumType.STRING) private Status status=Status.CONFIRMED; public enum Status{CONFIRMED,CANCELLED}
 public Long getId(){return id;} public void setId(Long v){id=v;} public Long getRideId(){return rideId;} public void setRideId(Long v){rideId=v;}
 public String getPassengerEmail(){return passengerEmail;} public void setPassengerEmail(String v){passengerEmail=v;} public String getStartLocation(){return startLocation;} public void setStartLocation(String v){startLocation=v;}
 public String getDestination(){return destination;} public void setDestination(String v){destination=v;} public int getSeats(){return seats;} public void setSeats(int v){seats=v;}
 public LocalDate getDate(){return date;} public void setDate(LocalDate v){date=v;} public Status getStatus(){return status;} public void setStatus(Status v){status=v;}
}
