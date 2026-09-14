package com.sourav.vehiclesharing.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity @Table(name="rides")
public class Ride {
 @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;
 @NotBlank private String ownerEmail; @NotBlank private String vehicleNo; @Min(1) private int seats;
 @NotBlank private String startPoint; private String stop1; private String stop2; private String stop3; private String stop4;
 @NotBlank private String finalStop; @NotNull @DecimalMin("0.0") private BigDecimal cost;
 @DecimalMin("0.0") private BigDecimal discount=BigDecimal.ZERO; @NotNull @FutureOrPresent private LocalDate date;
 public Long getId(){return id;} public void setId(Long v){id=v;} public String getOwnerEmail(){return ownerEmail;} public void setOwnerEmail(String v){ownerEmail=v;}
 public String getVehicleNo(){return vehicleNo;} public void setVehicleNo(String v){vehicleNo=v;} public int getSeats(){return seats;} public void setSeats(int v){seats=v;}
 public String getStartPoint(){return startPoint;} public void setStartPoint(String v){startPoint=v;} public String getStop1(){return stop1;} public void setStop1(String v){stop1=v;}
 public String getStop2(){return stop2;} public void setStop2(String v){stop2=v;} public String getStop3(){return stop3;} public void setStop3(String v){stop3=v;}
 public String getStop4(){return stop4;} public void setStop4(String v){stop4=v;} public String getFinalStop(){return finalStop;} public void setFinalStop(String v){finalStop=v;}
 public BigDecimal getCost(){return cost;} public void setCost(BigDecimal v){cost=v;} public BigDecimal getDiscount(){return discount;} public void setDiscount(BigDecimal v){discount=v;}
 public LocalDate getDate(){return date;} public void setDate(LocalDate v){date=v;}
}
