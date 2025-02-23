use hotel_data_warehouse;

CREATE VIEW fact_reservation AS
SELECT sr.reservation_id,sr.customer_id,so.order_id,sp.payment_id,sr.room_id,ss.staff_id,so.order_date,sp.payment_date,
sr.check_in,sr.check_out,sp.discount_applied as discount_percent,srms.room_price,sp.total_paid
FROM silver_reservations sr
INNER JOIN silver_payments sp ON sr.reservation_id = sp.reservation_id
INNER JOIN silver_orders so ON sr.reservation_id = so.reservation_id
INNER JOIN silver_staffs ss ON sr.reservation_id = ss.reservation_id
INNER JOIN silver_rooms srms ON sr.room_id = srms.room_id
ORDER BY reservation_id;

drop view dm_staffs;
show full tables where table_type = 'view';
CREATE VIEW dim_customers AS
SELECT customer_id,customer_name,email,phone_number,loyalty_status,nationality from silver_customers;

CREATE VIEW dim_payments AS
SELECT payment_id, reservation_id, payment_method, total_paid, payment_date, discount_applied FROM silver_payments;

CREATE VIEW dim_rooms AS
SELECT room_id, room_type, bed_type, room_price, room_status FROM silver_rooms;

CREATE VIEW dim_staffs AS
SELECT staff_id, reservation_id, staff_name FROM silver_staffs;
