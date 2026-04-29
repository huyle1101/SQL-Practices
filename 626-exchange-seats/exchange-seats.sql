-- Write your PostgreSQL query statement below
WITH max_id_check AS (
    SELECT MAX(id) AS max_id
    FROM seat
),
even_case AS (
    SELECT id,
    CASE WHEN id % 2 = 0 THEN LAG(student) OVER(ORDER BY id)
    ELSE LEAD(student) OVER(ORDER BY id) END AS "student"
    FROM seat
),
odd_case AS (
    SELECT id,
    CASE WHEN id % 2 = 1 THEN LEAD(student) OVER(ORDER BY id)
    ELSE LAG(student) OVER(ORDER BY id) END AS "student"
    FROM seat
    WHERE id <= (SELECT max_id FROM max_id_check) -1
-- similar to the even_case
    UNION ALL
    SELECT id, student
    FROM seat
    WHERE id = (SELECT max_id FROM max_id_check)
-- find the last odd seat that is unchanged
)
SELECT *
FROM even_case
WHERE (SELECT max_id FROM max_id_check) % 2 = 0 

UNION ALL

SELECT *
FROM odd_case
WHERE (SELECT max_id FROM max_id_check) % 2 = 1