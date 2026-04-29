-- Write your PostgreSQL query statement below
WITH first_day AS (
    SELECT player_id, MIN(event_date) AS first_login_day
    FROM activity 
    GROUP BY 1
),
day_2 AS (
    SELECT a.player_id
    FROM activity a
    JOIN first_day f
    ON a.player_id = f.player_id AND  a.event_date = f.first_login_day + INTERVAL '1 DAY'
)
SELECT ROUND(COUNT(player_id) * 1.0/(SELECT COUNT(DISTINCT player_id) FROM activity),2) AS fraction
-- *0.1 so that the result if float
FROM day_2