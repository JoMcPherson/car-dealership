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


DROP TABLE IF EXISTS dealerships;
DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS sales_contracts;
DROP TABLE IF EXISTS financing;

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
