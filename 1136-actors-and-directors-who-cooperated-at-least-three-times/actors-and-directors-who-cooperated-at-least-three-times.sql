-- Write your PostgreSQL query statement below
WITH get_num_cooperation AS (
    SELECT 
        actor_id,
        director_id, 
        COUNT(director_id) AS num_cooperation
    FROM actordirector
    GROUP BY 1,2
    ORDER BY 3 DESC
)

SELECT 
    actor_id, director_id
FROM get_num_cooperation
WHERE num_cooperation>=3