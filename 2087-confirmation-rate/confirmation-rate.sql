# Write your MySQL query statement below
WITH sub1 AS (SELECT s.user_id, c.action
FROM signups s
LEFT JOIN confirmations c
ON s.user_id = c.user_id),
sub2 AS 
(SELECT user_id,
COUNT(*) AS request_count,
SUM(CASE WHEN action='confirmed' THEN 1 ELSE 0 END) AS confirmed_count
FROM sub1
GROUP BY 1)

SELECT user_id, ROUND(confirmed_count/request_count,2) AS confirmation_rate
FROM sub2
GROUP BY 1