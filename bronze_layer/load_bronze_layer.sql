-- Access data warehouse
USE hotel_data_warehouse;

-- Empty tables of all items before loading
TRUNCATE TABLE bronze_customers;
TRUNCATE TABLE bronze_menu_orders;
TRUNCATE TABLE bronze_payments;
TRUNCATE TABLE bronze_reservations;
TRUNCATE TABLE bronze_rooms;

-- Note that stored procedures do not wrap the LOAD DATA function in MYSQL, otherwise, automating the following tasks should be the most efficient thing to do.
-- Load tables
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv'
INTO TABLE bronze_customers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/menu_orders.csv'
INTO TABLE bronze_menu_orders
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/payments.csv'
INTO TABLE bronze_payments
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/reservations.csv'
INTO TABLE bronze_reservations
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/rooms.csv'
INTO TABLE bronze_rooms
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
