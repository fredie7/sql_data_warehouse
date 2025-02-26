-- Use the correct database
USE hotel_data_warehouse;

-- Automate the data processing with stored procedure
DELIMITER //

CREATE PROCEDURE LoadSilverTables()
BEGIN

    -- Create silver_customers table if not exists
    CREATE TABLE IF NOT EXISTS silver_customers (
        customer_id INT NOT NULL PRIMARY KEY,
        customer_name VARCHAR(50),
        email VARCHAR(50),
        phone_number VARCHAR(50),
        loyalty_status VARCHAR(50),
        nationality VARCHAR(50)
    );

    -- Truncate before inserting new data
    TRUNCATE TABLE silver_customers;

    -- Insert cleaned data into silver_customers
    INSERT INTO silver_customers (customer_id, customer_name, email, phone_number, loyalty_status, nationality)
    SELECT 
        customer_id,
        customer_name,
        LOWER(TRIM(email)) AS email,
        CASE 
            WHEN LENGTH(REGEXP_REPLACE(phone_number, '[^0-9]', '')) >= 10 
            THEN CONCAT(
                SUBSTRING(REGEXP_REPLACE(phone_number, '[^0-9]', ''), 1, 3), '-',
                SUBSTRING(REGEXP_REPLACE(phone_number, '[^0-9]', ''), 4, 3), '-',
                SUBSTRING(REGEXP_REPLACE(phone_number, '[^0-9]', ''), 7, 4)
            )
            ELSE REGEXP_REPLACE(phone_number, '[^0-9]', '')
        END AS phone_number,
        loyalty_status,
        REGEXP_SUBSTR(nationality, '^[^()]+') AS nationality 
    FROM bronze_customers;

    -- Quality Check: Unnecessary spaces in emails
    SELECT email FROM silver_customers WHERE email != TRIM(email);

    -- Quality Check: Unwanted brackets in nationality
    SELECT nationality FROM silver_customers WHERE REGEXP_LIKE(nationality, '[\(\)\{\}]');

    -- Create silver_menu_orders table if not exists
    CREATE TABLE IF NOT EXISTS silver_orders (
        order_id INT PRIMARY KEY,
        reservation_id INT,
        order_date DATE
        
    );

    -- Truncate & Insert data into silver_menu_orders (Excluding 'created_date' and mapping menu_item_id to menu_id)
    TRUNCATE TABLE silver_orders;
    INSERT INTO silver_orders (order_id, reservation_id,order_date)
    SELECT order_id, reservation_id,order_date FROM bronze_orders;

    -- Create silver_payments table if not exists
    CREATE TABLE IF NOT EXISTS silver_payments (
        payment_id INT PRIMARY KEY,
        reservation_id INT,
        payment_method VARCHAR(30),
        total_paid INT,
        payment_date DATE,
        discount_applied INT
    );

    -- Truncate & Insert data into silver_payments
    TRUNCATE TABLE silver_payments;
    INSERT INTO silver_payments (payment_id, reservation_id, payment_method, total_paid, payment_date, discount_applied)
    SELECT payment_id, reservation_id, payment_method, total_paid, payment_date, discount_applied FROM bronze_payments;

    -- Create silver_reservations table if not exists
    CREATE TABLE IF NOT EXISTS silver_reservations (
        reservation_id INT PRIMARY KEY,
        customer_id INT,
        room_id INT,
        check_in DATE,
        check_out DATE,
        reservation_status VARCHAR(30)
    );

    -- Truncate & Insert data into silver_reservations
    TRUNCATE TABLE silver_reservations;
    INSERT INTO silver_reservations (reservation_id, customer_id, room_id, check_in, check_out,reservation_status)
    SELECT reservation_id, customer_id, room_id, check_in, check_out,reservation_status FROM bronze_reservations;

    -- Create silver_rooms table if not exists
    CREATE TABLE IF NOT EXISTS silver_rooms (
        room_id INT NOT NULL PRIMARY KEY,
        room_type VARCHAR(50),
        bed_type VARCHAR(50),
        room_price INT,
        room_status VARCHAR(50)
    );

    -- Truncate & Insert data into silver_rooms
    TRUNCATE TABLE silver_rooms;
    INSERT INTO silver_rooms (room_id, room_type, bed_type, room_price, room_status)
    SELECT room_id, room_type, bed_type, room_price, room_status FROM bronze_rooms;
    
    -- Truncate & Insert data into silver_staffs
    TRUNCATE TABLE silver_staffs;
    INSERT INTO silver_staffs
	SELECT 
    staff_id,
	reservation_id,
	staff_name
	FROM bronze_staffs;

    -- Final check for inserted rows
    SELECT * FROM silver_customers LIMIT 5;
    SELECT * FROM silver_orders LIMIT 5;
    SELECT * FROM silver_payments LIMIT 2;
    SELECT * FROM silver_reservations LIMIT 3;
    SELECT * FROM silver_rooms LIMIT 5;
    SELECT * FROM silver_staffs LIMIT 5;

END //

DELIMITER ;


CALL LoadSilverTables();
show tables;
select * from silver_customers limit 3;
drop procedure LoadSilverTables
