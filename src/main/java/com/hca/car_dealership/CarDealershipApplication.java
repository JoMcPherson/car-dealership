package com.hca.car_dealership;

import com.hca.car_dealership.models.Vehicle;
import com.hca.car_dealership.repositories.VehicleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.List;
import java.util.Optional;
import java.util.Scanner;

@SpringBootApplication
public class CarDealershipApplication implements CommandLineRunner {

	@Autowired
	private VehicleRepository vehicleRepository;

	public static void main(String[] args) {
		SpringApplication.run(CarDealershipApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		Scanner scanner = new Scanner(System.in);
		System.out.print("Enter lowest price of vehicle you are looking for: ");
		Double priceLow = scanner.nextDouble();
		System.out.print("Enter highest price of vehicle you are looking for: ");
		Double priceHigh = scanner.nextDouble();
		List<Vehicle> vehicles = vehicleRepository.getVehicleByPriceRange(priceLow, priceHigh);
//		List<Vehicle> vehicleList = vehicleRepository.getAllVehicles();
//		vehicleList.forEach(System.out::println);
//		List<Vehicle> vehicleMakeModelList = vehicleRepository.getVehicleByMakeModel("Ford","Fiesta");
//		vehicleMakeModelList.forEach(System.out::println);
		vehicles.forEach(System.out::println);
		scanner.close();
	}
}
