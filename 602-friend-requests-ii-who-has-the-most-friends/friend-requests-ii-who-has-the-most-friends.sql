-- Write your PostgreSQL query statement below
WITH sub1 AS (
    SELECT requester_id AS id, COUNT(requester_id)
    FROM requestaccepted
    GROUP BY 1
    ORDER BY 1
),
sub2 AS (
    SELECT accepter_id AS id, COUNT(accepter_id)
    FROM requestaccepted
    GROUP BY 1
    ORDER BY 1
)

SELECT id, SUM(count) AS num
FROM (
    (SELECT * FROM sub1) 
    UNION ALL 
    (SELECT * FROM sub2)
)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
