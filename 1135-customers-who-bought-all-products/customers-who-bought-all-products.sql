-- Write your PostgreSQL query statement below
WITH bought_product AS (
    SELECT customer_id, COUNT(DISTINCT product_key) AS bought_product_count
    FROM customer
    GROUP BY 1
)
SELECT customer_id 
FROM bought_product 
WHERE bought_product_count = (SELECT COUNT(*) FROM product)
