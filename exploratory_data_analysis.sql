use hotel_data_warehouse;

-- ANALYSIS OF REVENUE TRENDS
-- Top  5 revenure generating customers
SELECT 
    c.customer_id, 
    c.customer_name, 
    SUM(f.total_paid) AS total_spent
FROM fact_reservations f
LEFT JOIN dim_Customers c ON f.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 5;

-- Monthly Revenue Breakdown
SELECT 
    CASE 
        WHEN DATE_FORMAT(payment_date, '%m') = '01' THEN 'January'
        WHEN DATE_FORMAT(payment_date, '%m') = '02' THEN 'February'
        WHEN DATE_FORMAT(payment_date, '%m') = '03' THEN 'March'
        WHEN DATE_FORMAT(payment_date, '%m') = '04' THEN 'April'
        WHEN DATE_FORMAT(payment_date, '%m') = '05' THEN 'May'
        WHEN DATE_FORMAT(payment_date, '%m') = '06' THEN 'June'
        WHEN DATE_FORMAT(payment_date, '%m') = '07' THEN 'July'
        WHEN DATE_FORMAT(payment_date, '%m') = '08' THEN 'August'
        WHEN DATE_FORMAT(payment_date, '%m') = '09' THEN 'September'
        WHEN DATE_FORMAT(payment_date, '%m') = '10' THEN 'October'
        WHEN DATE_FORMAT(payment_date, '%m') = '11' THEN 'November'
        WHEN DATE_FORMAT(payment_date, '%m') = '12' THEN 'December'
    END AS month, 
    SUM(total_paid) AS total_revenue
FROM Fact_Reservations
WHERE total_paid IS NOT NULL
GROUP BY month
ORDER BY total_revenue DESC;

-- ROOM OCCUPANCY TRENDS
-- Most frequently booked rooms
SELECT 
    r.room_type, 
    COUNT(f.reservation_id) AS total_bookings
FROM fact_reservations f
LEFT JOIN dim_Rooms r ON f.room_id = r.room_id
GROUP BY r.room_type
ORDER BY total_bookings DESC;

-- Percentage trend of booked rooms
SELECT
	r.room_type,
    (COUNT(DISTINCT f.reservation_id) * 100.0) / 
    COUNT(*) AS occupancy_rate
FROM fact_reservations f
LEFT JOIN dim_rooms r
ON f.room_id = r.room_id
WHERE r.room_status = 'Occupied'
GROUP BY r.room_type
ORDER BY occupancy_rate DESC;

--
SELECT 
    COUNT(DISTINCT CASE WHEN total_bookings = 1 THEN customer_id END) AS new_customers,
    COUNT(DISTINCT CASE WHEN total_bookings > 1 THEN customer_id END) AS returning_customers
FROM (
    SELECT customer_id, COUNT(reservation_id) AS total_bookings
    FROM Fact_Reservations
    GROUP BY customer_id
) AS subquery;

-- CUSTOMER BEHAVIOUR
-- Total bookings by customer
SELECT c.customer_id, c.customer_name, COUNT(f.reservation_id) AS total_bookings
FROM Fact_Reservations f
LEFT JOIN dim_customers c
ON f.customer_id = c.customer_id
GROUP BY customer_id
ORDER BY total_bookings DESC;

-- Find chun or non-repeat customers
WITH customers AS (
    SELECT 
        c.customer_id, 
        c.customer_name, 
        COUNT(f.reservation_id) AS total_bookings
    FROM Fact_Reservations f
    LEFT JOIN dim_customers c
    ON f.customer_id = c.customer_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT *, 
    CASE 
        WHEN total_bookings > 1 THEN 'Repeat Customer'
        ELSE 'Non-Repeat Customer'
    END AS customer_type
FROM customers
ORDER BY total_bookings DESC,customer_type DESC;
