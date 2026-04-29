-- Write your PostgreSQL query statement below
WITH sub AS (
    SELECT customer_id,
MIN(order_date) AS first_order,
MIN(customer_pref_delivery_date) AS first_delivery
FROM delivery
GROUP BY 1
)
SELECT  
ROUND(AVG(CASE WHEN first_delivery = first_order THEN 1 ELSE 0 END)*100,2) AS immediate_percentage
FROM sub