-- Check for invalid order dates
SELECT * FROM bronze_reservations where check_out < check_in;

-- Create & insert transformed data into silver_reservations
CREATE TABLE silver_reservations(
reservation_id INT PRIMARY KEY,
customer_id INT,
room_id INT,
check_in DATE,
check_out DATE,
payment INT,
total_amount INT,
reservation_status VARCHAR(30)
);

INSERT INTO silver_reservations
SELECT * FROM bronze_reservations;
