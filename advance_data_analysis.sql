-- CHANGES OVER TIME ANALYSIS
use hotel_data_warehouse;
-- Total Checked-in Customers By Year
SELECT IF(DATE_FORMAT(check_in,'%y')=24,2024,2025) AS checked_in_year,COUNT(DISTINCT customer_id) total_customers
FROM fact_reservations
