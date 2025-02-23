-- Check for values less than 0 
select * from bronze_menu_orders where reservation_id < 0 or menu_item_id < 0 or total_price < 0;

-- Check for null values
select * from bronze_menu_orders where reservation_id = null or menu_item_id = null or total_price = null or order_date = null;

-- Check for empty values
select * from bronze_menu_orders where reservation_id = '' or menu_item_id = '' or total_price = '';

-- Check for duplicates
SELECT order_id, COUNT(*) FROM bronze_menu_orders GROUP BY order_id HAVING COUNT(*) > 1;

-- Create the silver_menu_order table
CREATE TABLE silver_orders(
order_id INT PRIMARY KEY,
reservation_id INT,
order_date DATE
);

-- drop table silver_menu_orders;
INSERT INTO silver_menu_orders
select * from bronze_menu_orders;
