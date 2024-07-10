package com.hca.car_dealership.repositories;

import com.hca.car_dealership.models.Vehicle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Repository
public class VehicleRepository {
    @Autowired
    private DataSource dataSource;

    //get all vehicles
    public List<Vehicle> getAllVehicles() {
        //write your sql query
        //open a connection to database
        //we are going to prepare the query to be sent to SQL
        //we will execute the query and get back a result set
        //grab data column by column and put it into a new java object
        //put it in a list
        //at the end of the loop return the list
        String query = "SELECT * FROM vehicles";
        List<Vehicle> vehicles = new ArrayList<>();

        //try-with
        try(Connection conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery()){
            while (rs.next()) {
                // grab the data from the columns
                Vehicle vehicle = mapRowToVehicle(rs);
                vehicles.add(vehicle);
            }
        }
        catch(SQLException ex) {
            ex.printStackTrace();
        }
        return vehicles;

    }


    public List<Vehicle> getVehicleByPriceRange(double priceLow, double priceHigh) {
        String query = "SELECT * FROM vehicles WHERE price >= ? AND price <= ?";
        List<Vehicle> vehicles = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            // replace question mark with value
            ps.setDouble(1, priceLow);
            ps.setDouble(2, priceHigh);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Vehicle vehicle = mapRowToVehicle(rs);
                    vehicles.add(vehicle);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return vehicles;
    }

    public List<Vehicle> getVehicleByMakeModel(String make, String model) {
        String query = "SELECT * FROM vehicles WHERE make = ? AND model = ?";
        List<Vehicle> vehicles = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            // replace question mark with value
            ps.setString(1, make);
            ps.setString(2, model);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Vehicle vehicle = mapRowToVehicle(rs);
                    vehicles.add(vehicle);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return vehicles;
    }


    public void deleteVehicle(int id) throws SQLException {
        String query = "DELETE FROM vehicles WHERE vehicle_id = ?";
        try(Connection conn = dataSource.getConnection();
        PreparedStatement ps = conn.prepareStatement(query)){
            ps.setInt(1,id);
            ps.executeUpdate();

        }
        catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public int createVehicle(Vehicle vehicle) {
        String query = "INSERT INTO vehicles(vin, price, odometer, sold, make, model, year, color) VALUES (?, ?, ?, ?, ?, ?, ?, ?) RETURNING vehicle_id";
        int generatedId = -1;

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, vehicle.getVIN());
            ps.setDouble(2, vehicle.getPrice());
            ps.setInt(3, vehicle.getOdometer());
            ps.setBoolean(4, vehicle.isSold());
            ps.setString(5, vehicle.getMake());
            ps.setString(6, vehicle.getModel());
            ps.setInt(7, vehicle.getYear());
            ps.setString(8, vehicle.getColor());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    generatedId = rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return generatedId;
    }

    public void updateVehicle(Vehicle vehicle) {
        String query = "UPDATE vehicles SET vin = ?, price = ?, odometer = ?, sold = ?, make = ?, model = ?, year = ?, color = ? WHERE vehicle_id = ?";

        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, vehicle.getVIN());
            ps.setDouble(2, vehicle.getPrice());
            ps.setInt(3, vehicle.getOdometer());
            ps.setBoolean(4, vehicle.isSold());
            ps.setString(5, vehicle.getMake());
            ps.setString(6, vehicle.getModel());
            ps.setInt(7, vehicle.getYear());
            ps.setString(8, vehicle.getColor());
            ps.setInt(9, vehicle.getVehicleId());
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }


    public int getVehicleIdByVIN(String VIN) {
        String query = "SELECT * FROM vehicles WHERE VIN = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            // replace question mark with value
            ps.setString(1, VIN);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int categoryId = rs.getInt("vehicle_id");
                    System.out.println(rs);
                    return categoryId;
                }
                else {
                    // Handle the case where no result is found
                    System.out.println("No vehicle found with VIN: " + VIN);
                    return -1; // or any other value that indicates "not found"
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
    public Optional<Vehicle> getVehicleById(int id) {
        String query = "SELECT * FROM vehicles WHERE vehicle_id = ?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            // replace question mark with value
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapRowToVehicle(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return Optional.empty();
    }
    private static Vehicle mapRowToVehicle(ResultSet rs) throws SQLException {
        int vehicleId = rs.getInt("vehicle_id");
        String vin = rs.getString("vin");
        double price = rs.getDouble("price");
        int odometer = rs.getInt("odometer");
        boolean sold = rs.getBoolean("sold");
        String make = rs.getString("make");
        String model = rs.getString("model");
        int year = rs.getInt("year");
        String color = rs.getString("color");

        return new Vehicle(vehicleId, vin, price, odometer, sold, make, model, year, color);
    }


}


