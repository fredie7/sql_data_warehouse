INSERT INTO silver_staffs
SELECT staff_id,
reservation_id,
payment_method,
total_paid,
payment_date,
discount 
FROM bronze_staffs;
