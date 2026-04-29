-- Write your PostgreSQL query statement below
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM activity
WHERE activity_date BETWEEN ('2019-07-27'::DATE - INTERVAL '29 DAY') AND '2019-07-27'::DATE
GROUP BY 1
-- SELECT *
-- FROM activity 
-- WHERE activity_date = '2019-06-28' OR activity_date = '2019-06-27'
-- ORDER BY activity_date