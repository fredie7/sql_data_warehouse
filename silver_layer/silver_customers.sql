-- QUALITY CHECKS

-- Check for duplicates
SELECT customer_id, COUNT(*) FROM bronze_customers GROUP BY order_id HAVING COUNT(*) > 1;

-- Check for unnecessary spaces
SELECT email FROM bronze_customers WHERE email != TRIM(email);

-- Check for unwanted brackets within the nationality
SELECT nationality
FROM bronze_customers
WHERE REGEXP_LIKE(nationality, '[\(\)\{\}]');



-- TRANSFORM AND LOAD THE silver_customers TABLE

USE hotel_data_warehouse;

CREATE TABLE IF NOT EXISTS silver_customers(
customer_id INT NOT NULL PRIMARY KEY,
customer_name VARCHAR(50),
email VARCHAR(50),
phone_number VARCHAR(50),
loyalty_status VARCHAR(50),
nationality VARCHAR(50)
);

-- Truncate  before insert
TRUNCATE table silver_customers;
INSERT INTO silver_customers
SELECT 
  customer_id,
  customer_name,
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
  REGEXP_SUBSTR(nationality,'^[^()]+') as nationality 
FROM bronze_customers;

-- View the first 5 rows
SELECT * FROM silver_customers LIMIT 5;

-- QUALITY CHECKS
-- Check for unnecessary spaces
SELECT email FROM silver_customers WHERE email != TRIM(email);

-- Check for unwanted brackets within the nationality
SELECT nationality
FROM silver_customers
WHERE REGEXP_LIKE(nationality, '[\(\)\{\}]');

-- View the first 5 rows
SELECT * FROM silver_customers LIMIT 5;



-- QUALITY CHECKS
-- Check for unnecessary spaces
SELECT email FROM silver_customers WHERE email != TRIM(email);

-- Check for unwanted brackets within the nationality
SELECT nationality
FROM silver_customers
WHERE REGEXP_LIKE(nationality, '[\(\)\{\}]');
