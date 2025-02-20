-- Check for spaces between payment method
SELECT payment_method FROM bronze_payments WHERE payment_method != TRIM(payment_method);

-- Create & populate processed data on silver_payments table
CREATE TABLE silver_payments(
payment_id INT PRIMARY KEY,
reservation_id INT,
payment_method VARCHAR(30),
total_paid INT,
payment_date DATE,
discount_applied INT
);
INSERT INTO silver_payments

-- QUALITY CHECKS
SELECT payment_method FROM silver_payments WHERE payment_method != TRIM(payment_method);
