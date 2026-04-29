-- Write your PostgreSQL query statement below
SELECT DISTINCT user_id, COUNT(follower_id) AS followers_count
FROM followers
GROUP BY 1
ORDER BY 1