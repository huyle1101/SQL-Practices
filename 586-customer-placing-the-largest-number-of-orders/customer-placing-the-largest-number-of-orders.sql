-- Write your PostgreSQL query statement below
WITH get_total_orders AS (
    SELECT 
        customer_number,
        COUNT(order_number) AS num_orders
    FROM orders
    GROUP BY 1
)
SELECT customer_number
FROM get_total_orders
ORDER BY num_orders DESC
FETCH FIRST 1 ROWS WITH TIES