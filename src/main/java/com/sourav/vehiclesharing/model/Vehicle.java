package com.sourav.vehiclesharing.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;

@Entity
@Table(name = "vehicles")
public class Vehicle {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotBlank @Column(unique = true) private String vehicleNo;
    @Min(1) private int seats;
    @NotBlank private String startPoint;
    @NotBlank private String finalStop;
    @NotNull @DecimalMin("0.0") private BigDecimal cost;
    @DecimalMin("0.0") private BigDecimal discount = BigDecimal.ZERO;

    public Long getId(){return id;} public void setId(Long id){this.id=id;}
    public String getVehicleNo(){return vehicleNo;} public void setVehicleNo(String v){vehicleNo=v;}
    public int getSeats(){return seats;} public void setSeats(int v){seats=v;}
    public String getStartPoint(){return startPoint;} public void setStartPoint(String v){startPoint=v;}
    public String getFinalStop(){return finalStop;} public void setFinalStop(String v){finalStop=v;}
    public BigDecimal getCost(){return cost;} public void setCost(BigDecimal v){cost=v;}
    public BigDecimal getDiscount(){return discount;} public void setDiscount(BigDecimal v){discount=v;}
}
