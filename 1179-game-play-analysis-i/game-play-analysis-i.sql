-- Write your PostgreSQL query statement below
WITH get_rn AS (
    SELECT 
        player_id,
        event_date,
        ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date) AS rn
    FROM activity
)

SELECT player_id, event_date AS first_login
FROM get_rn 
WHERE rn=1