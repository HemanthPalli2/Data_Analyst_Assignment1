-- Hotel Queries
-- 1. Last booked room per user
SELECT users.user_id, bookings.room_no
FROM users
LEFT JOIN bookings ON users.user_id = bookings.user_id
WHERE bookings.booking_date = (
    SELECT MAX(booking_date) FROM bookings WHERE bookings.user_id = users.user_id
);

-- 2. Total billing amount for bookings in Nov 2021
SELECT booking_commercials.booking_id, SUM(items.item_rate * booking_commercials.item_quantity) AS total_amount
FROM booking_commercials
JOIN items ON booking_commercials.item_id = items.item_id
JOIN bookings ON booking_commercials.booking_id = bookings.booking_id
WHERE strftime('%Y-%m', bookings.booking_date) = '2021-11'
GROUP BY booking_commercials.booking_id;

-- 3. Bills in Oct 2021 > 1000
SELECT booking_commercials.bill_id, SUM(items.item_rate * booking_commercials.item_quantity) AS bill_amount
FROM booking_commercials
JOIN items ON booking_commercials.item_id = items.item_id
WHERE strftime('%Y-%m', booking_commercials.bill_date) = '2021-10'
GROUP BY booking_commercials.bill_id
HAVING bill_amount > 1000;

-- 4. Most & least ordered item each month
WITH monthly AS (
    SELECT strftime('%m', bill_date) AS month, item_id, SUM(item_quantity) AS qty
    FROM booking_commercials
    WHERE strftime('%Y', bill_date)='2021'
    GROUP BY month, item_id
),
ranked AS (
    SELECT month, item_id, qty,
           RANK() OVER (PARTITION BY month ORDER BY qty DESC) AS r_max,
           RANK() OVER (PARTITION BY month ORDER BY qty ASC) AS r_min
    FROM monthly
)
SELECT month,
       MAX(CASE WHEN r_max = 1 THEN item_id END) AS most_ordered,
       MAX(CASE WHEN r_min = 1 THEN item_id END) AS least_ordered
FROM ranked
GROUP BY month;

-- 5. Second-highest bill user each month
WITH bill_month AS (
    SELECT booking_commercials.bill_id, bookings.user_id,
           strftime('%m', booking_commercials.bill_date) AS month,
           SUM(items.item_rate * booking_commercials.item_quantity) AS bill_value
    FROM booking_commercials
    JOIN items ON booking_commercials.item_id = items.item_id
    JOIN bookings ON booking_commercials.booking_id = bookings.booking_id
    WHERE strftime('%Y', booking_commercials.bill_date)='2021'
    GROUP BY booking_commercials.bill_id
),
ranked AS (
    SELECT *, DENSE_RANK() OVER (PARTITION BY month ORDER BY bill_value DESC) AS rnk
    FROM bill_month)
SELECT month, user_id, bill_id, bill_value
FROM ranked

WHERE rnk = 2;