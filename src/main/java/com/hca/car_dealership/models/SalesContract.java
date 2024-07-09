package com.hca.car_dealership.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SalesContract {
    private int saleId;
    private int vehicleId;
    private int customerId;
    private double price;
    private String saleDate;
}