-- Hotel Schema Setup
-- Table users
CREATE TABLE users (user_id TEXT, name TEXT, phone_number INTEGER, mail_id TEXT, billing_address TEXT);

-- Table bookings
CREATE TABLE bookings (booking_id TEXT, booking_date DATETIME, room_no TEXT, user_id TEXT);

--Table booking-commercials
CREATE TABLE booking_commercials (id TEXT, booking_id TEXT, bill_id TEXT, bill_date DATETIME, item_id TEXT, item_quantity INTEGER);

--Table items
CREATE TABLE items (item_id TEXT, item_name TEXT, item_rate INTEGER);

--Inserting Data....

--Table users
INSERT INTO USERS (user_id, name, phone_number, mail_id, billing_address)
VALUES ('21wrcxuy-67erfn','John Doe',9700000000, 'john.doe@example.com', 'XX, Street Y, ABC City');

--Table bookings
INSERT INTO bookings (booking_id, booking_date, room_no, user_id)
VALUES 
('bk-09f3e-95hj', '2021-09-23 7:36:48', 'rm-bhf9-aerjn', '21wrcxuy-67erfn');

--Table booking_commercials
INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity)
VALUES 
('q34r-3q4o8-q34u', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a9e8-q8fu', 3),
('q3o4-ahf32-o2u4', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1),
('134lr-oyfo8-3qk4', 'bk-q034-q4o', 'bl-34qhd-r7h8', '2021-09-23 12:05:37', 'itm-w978-23u4', 0.5);

--Table items
INSERT INTO items (item_id, item_name, item_rate)
VALUES ('itm-a9e8-q8fu', 'Tawa Paratha', 18),
('itm-a07vh-aer8', 'Mix Veg', 89);






