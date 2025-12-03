-- Clinic Schema Setup

--Table clinics
CREATE TABLE clinics (cid TEXT, clinic_name TEXT, city TEXT, state TEXT, country TEXT);

--Table customer
CREATE TABLE customer (uid TEXT, name TEXT, mobile INTEGER);

--Table clinic_sales
CREATE TABLE clinic_sales (oid TEXT, uid TEXT, cid TEXT, amount INTEGER, datetime DATETIME, 
sales_channel TEXT);

--Table expenses
CREATE TABLE expenses (eid TEXT, cid TEXT, description TEXT, amount INTEGER, datetime DATETIME);

--Inserting Data....

--Table clinics
INSERT INTO clinics (cid, clinic_name, city, state, country)
VALUES ('cnc-0100001', 'XYZ clinic', 'lorem', 'ipsum', 'dolor');

--Table customer
CREATE TABLE customer (uid, name, mobile)
VALUES 
('bk-09f3e-95hj', 'Jon Doe', 9710101010);

--Table clinic_sales
CREATE TABLE clinic_sales (oid, uid, cid, amount, datetime,sales_channel)
VALUES
('ord-00100-00100', 'bk-09f3e-95hj', 'cnc-0100001', 24999 '2021-09-23 12:03:22','sodat');

--Table expenses
CREATE TABLE expenses (eid, cid, description, amount, datetime)
VALUES
('exp-0100-00100', 'cnc-0100001', 'first-aid supplies' 557, '2021-09-23 7:36:48');















