--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;



SET default_tablespace = '';

SET default_with_oids = false;


---
--- drop tables
---


DROP TABLE IF EXISTS financing CASCADE;
DROP TABLE IF EXISTS sales_contracts CASCADE;
DROP TABLE IF EXISTS lease_contracts CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS inventory CASCADE;
DROP TABLE IF EXISTS vehicles CASCADE;
DROP TABLE IF EXISTS dealerships CASCADE;

--


--

CREATE TABLE dealerships (
    dealership_id serial PRIMARY KEY,
    name varchar(50) NOT NULL,
    address varchar(50) NOT NULL,
    phone varchar(12) NOT NULL
);


--
--

CREATE TABLE vehicles (
    vehicle_id serial PRIMARY KEY,
    vin varchar(17) NOT NULL,
    price float NOT NULL,
    odometer int NOT NULL,
    sold boolean NOT NULL DEFAULT false,
    make varchar(50) NOT NULL,
    model varchar(50) NOT NULL,
    year int NOT NULL,
    color varchar(20)
);


--
--

CREATE TABLE inventory (
    dealership_id int NOT NULL,
    vehicle_id int NOT NULL,
    PRIMARY KEY (dealership_id, vehicle_id),
    FOREIGN KEY (dealership_id) REFERENCES dealerships(dealership_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);



--
--

CREATE TABLE customers (
    customer_id serial PRIMARY KEY,
    name varchar(50) NOT NULL,
    address varchar(100) NOT NULL,
    phone varchar(15) NOT NULL,
    email varchar(50)
);



--
--

CREATE TABLE sales_contracts (
    sale_id serial PRIMARY KEY,
    vehicle_id int NOT NULL,
    customer_id int NOT NULL,
    price numeric(10, 2) NOT NULL,
    sale_date date NOT NULL,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE lease_contracts (
                                 lease_id serial PRIMARY KEY,
                                 vehicle_id int NOT NULL,
                                 customer_id int NOT NULL,
                                 monthly_price numeric(10, 2) NOT NULL,
                                 end_date date NOT NULL,
                                 start_date date NOT NULL,
                                 FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
                                 FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

--
--

CREATE TABLE financing (
    sale_id int PRIMARY KEY,
    rate numeric(5, 2) NOT NULL,
    term_length int NOT NULL,
    monthly_payment numeric(10, 2) NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES sales_contracts(sale_id)
);


--
-- Insert fake data for dealerships
INSERT INTO dealerships (name, address, phone) VALUES
                                                   ('Wormwood Motors', '123 Trunchbull St, Crunchem Hall', '555-1234'),
                                                   ('Trunchbull Auto', '456 Honey Ln, Crunchem Hall', '555-5678');

-- Insert fake data for vehicles
INSERT INTO vehicles (vin, price, odometer, sold, make, model, year, color) VALUES
                                                                                ('1HGCM82633A123456', 5000.00, 120000, false, 'Ford', 'Fiesta', 1997, 'Red'),
                                                                                ('1HGCM82633A654321', 3000.00, 150000, true, 'Chevrolet', 'Impala', 1998, 'Blue'),
                                                                                ('1HGCM82633A789012', 7000.00, 90000, false, 'Toyota', 'Corolla', 1999, 'Green'),
                                                                                ('1HGCM82633A345678', 4500.00, 110000, true, 'Honda', 'Civic', 2000, 'Black');

-- Insert fake data for inventory
INSERT INTO inventory (dealership_id, vehicle_id) VALUES
                                                      (1, 1),
                                                      (1, 2),
                                                      (2, 3),
                                                      (2, 4);

-- Insert fake data for customers
INSERT INTO customers (name, address, phone, email) VALUES
                                                        ('Matilda Wormwood', '123 Crunchem Hall', '555-9876', 'matilda@library.com'),
                                                        ('Harry Wormwood', '123 Crunchem Hall', '555-4321', 'harry@wormwoodmotors.com'),
                                                        ('Miss Honey', '456 Sweet Ln', '555-8765', 'misshoney@school.edu'),
('Miss Trunchbull', '666 Dark Ln', '555-4365', 'misstrunchbull@school.edu');

-- Insert fake data for sales_contracts
INSERT INTO sales_contracts (vehicle_id, customer_id, price, sale_date) VALUES
                                                                            (2, 2, 1500.00, '2023-06-01'),
                                                                            (4, 4, 2000.00, '2023-06-15');
INSERT INTO lease_contracts (vehicle_id, customer_id, monthly_price, end_date, start_date)
VALUES (1, 1, 1200.00, '2024-12-31', '2024-07-09');


-- Insert fake data for financing
INSERT INTO financing (sale_id, rate, term_length, monthly_payment) VALUES
                                                                        (1, 5.5, 36, 45.00),
                                                                        (2, 4.5, 48, 50.00);
