-- Check for invalid order dates
SELECT * FROM bronze_reservations where check_out < check_in;

-- Check for any date greater than the current date
SELECT * FROM bronze_reservations where check_out > current_date() AND check_in > current_date();

-- Create & insert transformed data into silver_reservations

CREATE TABLE IF NOT EXISTS silver_reservations(
reservation_id INT PRIMARY KEY,
customer_id INT,
room_id INT,
check_in DATE,
check_out DATE,
reservation_status VARCHAR(30)
);

INSERT INTO silver_reservations
SELECT * FROM bronze_reservations;
