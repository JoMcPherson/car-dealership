package com.hca.car_dealership.models;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Vehicle {
    private int vehicleId;
    private String VIN;
    private double price;
    private int odometer;
    private boolean sold;
    private String make;
    private String model;
    private int year;
    private String color;
}
