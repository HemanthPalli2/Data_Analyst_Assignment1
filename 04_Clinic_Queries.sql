-- Clinic Queries
-- 1. Revenue by sales channel
SELECT sales_channel, SUM(amount) AS revenue
FROM clinic_sales
WHERE strftime('%Y', datetime)='2021'
GROUP BY sales_channel;

-- 2. Top 10 valuable customers
SELECT uid, SUM(amount) AS total_revenue
FROM clinic_sales
WHERE strftime('%Y', datetime)='2021'
GROUP BY uid
ORDER BY total_revenue DESC
LIMIT 10;

-- 3. Month-wise revenue, expense, profit
WITH rev AS (
    SELECT strftime('%Y-%m', datetime) AS month, SUM(amount) AS revenue
    FROM clinic_sales
    WHERE strftime('%Y', datetime)='2021'
    GROUP BY month
),
exp AS (
    SELECT strftime('%Y-%m', datetime) AS month, SUM(amount) AS expense
    FROM expenses
    WHERE strftime('%Y', datetime)='2021'
    GROUP BY month
)
SELECT r.month, r.revenue, e.expense,
       (r.revenue - e.expense) AS profit,
       CASE WHEN (r.revenue - e.expense)>=0 THEN 'profitable' ELSE 'not-profitable' END AS status
FROM rev r LEFT JOIN exp e USING(month);

-- 4. Most profitable clinic each city
WITH profit AS (
    SELECT c.city, c.cid,
           SUM(cs.amount) AS revenue,
           COALESCE(SUM(e.amount),0) AS expense,
           SUM(cs.amount)-COALESCE(SUM(e.amount),0) AS profit
    FROM clinics c
    LEFT JOIN clinic_sales cs ON c.cid = cs.cid
    LEFT JOIN expenses e ON c.cid = e.cid
    WHERE strftime('%Y-%m', cs.datetime)='2021-09'
    GROUP BY c.cid
),
ranked AS (
    SELECT *, RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS rnk
    FROM profit
)
SELECT city, cid, profit FROM ranked WHERE rnk=1;

-- 5. Second least profitable clinic each state
WITH profit AS (
    SELECT c.state, c.cid,
           SUM(cs.amount) AS revenue,
           COALESCE(SUM(e.amount),0) AS expense,
           SUM(cs.amount)-COALESCE(SUM(e.amount),0) AS profit
    FROM clinics c
    LEFT JOIN clinic_sales cs ON c.cid = cs.cid
    LEFT JOIN expenses e ON c.cid = e.cid
    WHERE strftime('%Y-%m', cs.datetime)='2021-09'
    GROUP BY c.cid
),
ranked AS (
    SELECT *, DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk
    FROM profit
)
SELECT state, cid, profit FROM ranked WHERE rnk=2;
