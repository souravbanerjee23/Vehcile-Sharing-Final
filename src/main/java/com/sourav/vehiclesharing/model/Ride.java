package com.sourav.vehiclesharing.model;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "rides")
public class Ride {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    private String ownerEmail;

    @NotBlank
    private String vehicleNo;

    @Min(1)
    private int seats;

    @NotBlank
    private String startPoint;

    private String stop1;
    private String stop2;
    private String stop3;
    private String stop4;

    @NotBlank
    private String finalStop;

    @NotNull
    @DecimalMin("0.0")
    private BigDecimal cost;

    @DecimalMin("0.0")
    private BigDecimal discount = BigDecimal.ZERO;

    @NotNull
    @FutureOrPresent
    private LocalDate date;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getOwnerEmail() { return ownerEmail; }
    public void setOwnerEmail(String ownerEmail) { this.ownerEmail = ownerEmail; }
    public String getVehicleNo() { return vehicleNo; }
    public void setVehicleNo(String vehicleNo) { this.vehicleNo = vehicleNo; }
    public int getSeats() { return seats; }
    public void setSeats(int seats) { this.seats = seats; }
    public String getStartPoint() { return startPoint; }
    public void setStartPoint(String startPoint) { this.startPoint = startPoint; }
    public String getStop1() { return stop1; }
    public void setStop1(String stop1) { this.stop1 = stop1; }
    public String getStop2() { return stop2; }
    public void setStop2(String stop2) { this.stop2 = stop2; }
    public String getStop3() { return stop3; }
    public void setStop3(String stop3) { this.stop3 = stop3; }
    public String getStop4() { return stop4; }
    public void setStop4(String stop4) { this.stop4 = stop4; }
    public String getFinalStop() { return finalStop; }
    public void setFinalStop(String finalStop) { this.finalStop = finalStop; }
    public BigDecimal getCost() { return cost; }
    public void setCost(BigDecimal cost) { this.cost = cost; }
    public BigDecimal getDiscount() { return discount; }
    public void setDiscount(BigDecimal discount) { this.discount = discount; }
    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }
}
