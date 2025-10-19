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

-- CUMULATIVE ANALYSIS - aggregates the progress of data over time
-- Customer Growth & Revenue Generated Over Time
SELECT 
    DATE_FORMAT(check_in, '%Y-%m') AS month_period, 
    COUNT(DISTINCT customer_id) AS new_customers, 
    SUM(COUNT(DISTINCT customer_id)) OVER (ORDER BY DATE_FORMAT(check_in, '%Y-%m')) AS cumulative_customers,
    SUM(dp.total_paid) AS revenue_generated
FROM fact_reservations
LEFT JOIN dim_payments dp
ON fact_reservations.payment_id = dp.payment_id
GROUP BY month_period
ORDER BY month_period;

-- PERFORMANCE ANALYSIS - Compare Average Perfromance By Year
WITH yearly_performance AS (
    SELECT 
        YEAR(payment_date) AS year, 
        SUM(total_paid) AS current_performance, 
        AVG(SUM(total_paid)) OVER () AS avg_performance
    FROM fact_reservations
    WHERE total_paid IS NOT NULL
    GROUP BY year
)
SELECT 
    year, 
    current_performance, 
    ROUND(avg_performance,2) AS average_performance, 
    ROUND(current_performance - avg_performance,2) AS difference_in_avg, 
    CASE 
        WHEN current_performance > avg_performance THEN 'Above Average' 
        WHEN current_performance < avg_performance THEN 'Below Average' 
        ELSE 'On Average' 
    END AS avg_change
FROM yearly_performance
ORDER BY year;

-- PART TO WHOLE ANALYSIS: Areas of highest impact
-- Room Type Demand
SELECT 
    rm.room_type, 
    COUNT(fr.room_id) AS total_bookings, 
    CONCAT(ROUND((COUNT(fr.room_id) / (SELECT COUNT(room_id) FROM fact_reservations) * 100),2),"","%") AS booking_percentage
FROM fact_reservations fr
JOIN dim_rooms rm 
ON fr.room_id = rm.room_id
GROUP BY rm.room_type
ORDER BY booking_percentage DESC;

-- SEGMENTATION ANALYSIS
-- Room Segmentation
SELECT 
    room_id, 
    room_type, 
    room_price, 
    CASE 
        WHEN room_price > (SELECT AVG(room_price) FROM dim_rooms) THEN 'Premium'
        ELSE 'Economy'
    END AS price_segment
FROM dim_rooms
ORDER BY room_price DESC;

-- Customer Segmentation
SELECT 
    c.customer_id, 
    c.customer_name, 
    COUNT(fr.reservation_id) AS total_reservations, 
    CASE 
        WHEN COUNT(fr.reservation_id) >= 5 THEN 'VIP'
        WHEN COUNT(fr.reservation_id) BETWEEN 2 AND 4 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment
FROM fact_reservations fr
JOIN dim_customers c ON fr.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_reservations DESC;

