-- Simulate a dataware house
CREATE DATABASE hotel_data_warehouse;
-- Access the data warehouse
USE hotel_data_warehouse;

-- Create bronze_customer table
CREATE TABLE IF NOT EXISTS bronze_customers(
customer_id INT NOT NULL PRIMARY KEY,
customer_name VARCHAR(50),
email VARCHAR(50),
phone_number VARCHAR(50),
loyality_status VARCHAR(50),
nationality VARCHAR(50)
);

-- Create bronze_menu_orders table
CREATE TABLE IF NOT EXISTS bronze_menu_orders(
order_id INT NOT NULL PRIMARY KEY,
reservation_id INT,
menu_item_id INT,
order_date DATE,
total_price INT
);

-- Create bronze_payments table
CREATE TABLE IF NOT EXISTS bronze_payments(
payment_id INT NOT NULL PRIMARY KEY,
reservtion_id INT,
payment_method VARCHAR(50),
total_paid INT,
payment_date DATE,
discount INT
);

-- Create bronze_reservations table
CREATE TABLE IF NOT EXISTS bronze_reservations(
reservation_id INT NOT NULL PRIMARY KEY,
customer_id INT,
room_id INT,
check_in DATE,
check_out DATE,
payment INT,
total_amount INT,
reservation_status VARCHAR(50)
);

-- Create bronze_rooms table
CREATE TABLE IF NOT EXISTS bronze_rooms(
room_id INT NOT NULL PRIMARY KEY,
room_type VARCHAR(50),
bed_type VARCHAR(50),
price INT,
room_status VARCHAR(50)
);
