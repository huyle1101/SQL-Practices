-- Write your PostgreSQL query statement below
WITH sub AS (
    SELECT product_id, MIN(year) AS first_year
    FROM sales
    GROUP BY 1
)

SELECT s.product_id, s.first_year, sa.quantity, sa.price
-- SELECT *
FROM sub s
JOIN sales sa
ON sa.product_id = s.product_id
WHERE sa.year = s.first_year