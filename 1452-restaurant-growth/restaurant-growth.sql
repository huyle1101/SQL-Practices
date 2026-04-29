-- Write your PostgreSQL query statement below
WITH visited_on_handling AS (
    SELECT DISTINCT (visited_on + INTERVAL '6 DAY')::DATE AS visited_on
    FROM customer
    WHERE (visited_on + INTERVAL '6 DAY')::DATE <= (SELECT MAX(visited_on) FROM Customer)
),
sum_avg_handling AS (
    SELECT visited_on,
    SUM(sum_amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
    ROUND(AVG(sum_amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS average_amount
    FROM (
        SELECT visited_on, SUM(amount) AS sum_amount
        FROM customer
        GROUP BY 1
        ORDER BY 1
    ) dupliacate_visited_on_handling
)

SELECT v.visited_on, s.amount, s.average_amount
FROM visited_on_handling v
JOIN sum_avg_handling s
ON v.visited_on = s.visited_on
ORDER BY 1