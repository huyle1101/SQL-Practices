# Write your MySQL query statement below
WITH sub AS (
    SELECT COUNT(*) AS user_count
    FROM users
)
SELECT r.contest_id, ROUND(COUNT(r.user_id)/(SELECT user_count FROM sub) *100,2) AS percentage
FROM register r
JOIN users u
ON r.user_id = u.user_id
GROUP BY 1
ORDER BY 2 DESC, 1 