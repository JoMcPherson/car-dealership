SELECT * FROM dealerships;
--
SELECT * FROM vehicles
JOIN inventory ON vehicles.vehicle_id = inventory.vehicle_id
WHERE inventory.dealership_id = 1;

SELECT * FROM vehicles
WHERE vin = '1HGCM82633A123456';
--
SELECT * FROM dealerships
         JOIN inventory ON dealerships.dealership_id = inventory.dealership_id
         JOIN vehicles ON inventory.vehicle_id = vehicles.vehicle_id
WHERE vehicles.vin = '1HGCM82633A123456';

SELECT DISTINCT * FROM dealerships
         JOIN inventory ON dealerships.dealership_id = inventory.dealership_id
         JOIN vehicles ON inventory.vehicle_id = vehicles.vehicle_id
WHERE vehicles.make = 'Ford'
  AND vehicles.model = 'Fiesta'
  AND vehicles.color = 'Red';


SELECT customers.name AS customer_name, vehicles.make, vehicles.model, vehicles.vin FROM sales_contracts
         JOIN vehicles ON sales_contracts.vehicle_id = vehicles.vehicle_id
         JOIN customers ON sales_contracts.customer_id = customers.customer_id
         JOIN inventory ON vehicles.vehicle_id = inventory.vehicle_id
WHERE inventory.dealership_id = 1
  AND sales_contracts.sale_date BETWEEN '2023-01-01' AND '2023-12-31';
