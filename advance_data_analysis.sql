-- CHANGES OVER TIME ANALYSIS
use hotel_data_warehouse;
-- Total Checked-in Customers By Year
SELECT IF(DATE_FORMAT(check_in,'%y')=24,2024,2025) AS checked_in_year,COUNT(DISTINCT customer_id) total_customers
FROM fact_reservations

-- New Vs Repeat Customers Over Time
SELECT 
    booking_year,
    COUNT(DISTINCT CASE WHEN total_bookings = 1 THEN customer_id END) AS new_customers,
    COUNT(DISTINCT CASE WHEN total_bookings > 1 THEN customer_id END) AS returning_customers
FROM (
    SELECT 
        customer_id,
        DATE_FORMAT(payment_date, '%Y') AS booking_year, 
        COUNT(reservation_id) AS total_bookings
    FROM Fact_Reservations
    GROUP BY customer_id, booking_year
) AS customer_bookings
GROUP BY booking_year;
