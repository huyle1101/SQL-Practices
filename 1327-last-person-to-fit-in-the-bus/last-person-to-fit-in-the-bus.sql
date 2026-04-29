-- Write your PostgreSQL query statement below
WITH sub AS (
    SELECT turn, person_id, person_name, weight,
    SUM(weight) OVER(ORDER BY turn) AS total_weight
    FROM queue 
)
SELECT person_name
FROM
(SELECT turn, person_id, person_name, weight, total_weight
FROM sub
WHERE total_weight <= 1000
ORDER BY total_weight DESC) sub_qry
LIMIT 1