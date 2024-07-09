package com.hca.car_dealership.models;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Dealership {
    private int dealershipId;
    private String name;
    private String address;
    private String phone;
    private List<Vehicle> vehicles;
}