-- Write your PostgreSQL query statement below
SELECT user_id, UPPER(LEFT(name, 1) ) || LOWER(RIGHT(name,LENGTH(name)-1)) AS name
FROM users
ORDER BY 1