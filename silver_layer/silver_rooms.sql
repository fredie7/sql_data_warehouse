-- Check for null values
SELECT * FROM bronze_rooms WHERE room_id = NULL OR room_status = NULL OR room_type = NULL OR bed_type = NULL OR room_status = NULL;

-- Create & populate silver_rooms with transformed data
CREATE TABLE IF NOT EXISTS silver_rooms(
room_id INT NOT NULL PRIMARY KEY,
room_type VARCHAR(50),
bed_type VARCHAR(50),
room_price INT,
room_status VARCHAR(50)
);

INSERT INTO silver_rooms (room_id, room_type, bed_type, room_price, room_status)
SELECT room_id, room_type, bed_type, room_price, room_status FROM bronze_rooms;
