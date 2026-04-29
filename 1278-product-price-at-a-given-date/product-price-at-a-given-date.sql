-- Write your PostgreSQL query statement below
(SELECT product_id, 10 AS price
FROM products
GROUP BY product_id
HAVING MIN(change_date) > '2019-08-16')
-- if the min change_date is over '2019-08-16' then the price is 10
UNION ALL

(SELECT product_id, new_price AS price
FROM Products
WHERE (product_id, change_date) IN 
(
    SELECT product_id, MAX(change_date)
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
))
-- if the max change_date is or below '2019-08-16' then the price is new_price