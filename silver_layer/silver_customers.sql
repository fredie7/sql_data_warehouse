-- QUALITY CHECKS
-- Check for unnecessary spaces
select email from bronze_customers where email != trim(email);

-- Check for unwanted brackets within the nationality
SELECT nationality
FROM bronze_customers
WHERE REGEXP_LIKE(nationality, '[\(\)\{\}]');



-- TRANSFORM AND LOAD THE silver_customers TABLE

use hotel_data_warehouse;

CREATE TABLE IF NOT EXISTS silver_customers(
customer_id INT NOT NULL PRIMARY KEY,
customer_name VARCHAR(50),
email VARCHAR(50),
phone_number VARCHAR(50),
loyalty_status VARCHAR(50),
nationality VARCHAR(50)
);

truncate table silver_customers;
INSERT INTO silver_customers
SELECT customer_id,customer_name,
LOWER(TRIM(email)) as email,
CASE
WHEN LENGTH(REGEXP_REPLACE(phone_number,'[^0-9]','')) >= 10 
THEN CONCAT(
SUBSTRING(REGEXP_REPLACE(phone_number,'[^0-9]',''),1,3),'-',
SUBSTRING(REGEXP_REPLACE(phone_number,'[^0-9]',''),4,3),'-',
SUBSTRING(REGEXP_REPLACE(phone_number,'[^0-9]',''),7,3)
)
ELSE REGEXP_REPLACE(phone_number,'[^0-9]','')
END AS phone_number,
loyalty_status,
REGEXP_SUBSTR(nationality,'^[^()]+') as nationality from bronze_customers;

-- View the first 5 rows
select * from silver_customers limit 5;

-- QUALITY CHECKS
-- Check for unnecessary spaces
select email from silver_customers where email != TRIM(email);

-- Check for unwanted brackets within the nationality
SELECT nationality
FROM silver_customers
WHERE REGEXP_LIKE(nationality, '[\(\)\{\}]');

-- View the first 5 rows
select * from silver_customers limit 5;



-- QUALITY CHECKS
-- Check for unnecessary spaces
select email from silver_customers where email != TRIM(email);

-- Check for unwanted brackets within the nationality
SELECT nationality
FROM silver_customers
WHERE REGEXP_LIKE(nationality, '[\(\)\{\}]');
