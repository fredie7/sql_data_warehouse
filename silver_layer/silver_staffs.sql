TRUNCATE TABLE silver_staffs;
INSERT INTO silver_staffs
SELECT 
  staff_id,
	reservation_id,
	staff_name
FROM bronze_staffs;
