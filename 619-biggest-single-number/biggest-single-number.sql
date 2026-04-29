-- Write your PostgreSQL query statement below
WITH sub AS (
    SELECT DISTINCT num, COUNT(num) AS num_count
    FROM MyNumbers
    GROUP BY 1
)
SELECT MAX(num) AS num
FROM sub
WHERE num_count = 1