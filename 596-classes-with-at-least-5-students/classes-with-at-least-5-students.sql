-- Write your PostgreSQL query statement below
WITH sub AS (
    SELECT class, COUNT(student) AS cnt
    FROM courses
    GROUP BY 1
)
-- SELECT DISTINCT s.class
-- FROM courses c
-- JOIN sub s
-- ON s.class = c.class
-- WHERE s.cnt >=5
SELECT DISTINCT class
FROM sub
WHERE cnt >= 5