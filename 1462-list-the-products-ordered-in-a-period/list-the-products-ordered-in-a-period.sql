-- Write your PostgreSQL query statement below
WITH sub AS (
    SELECT p.product_id, p.product_name, o.order_date, o.unit
    FROM products p
    JOIN orders o
    ON p.product_id = o.product_id
    WHERE o.order_date >= '2020-02-01' AND o.order_date < '2020-03-01'
)
SELECT product_name, SUM(unit) AS unit
FROM sub
GROUP BY 1
HAVING SUM(unit) >= 100