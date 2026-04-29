-- Write your PostgreSQL query statement below
WITH common AS (
    SELECT mr.*, u.name, m.title 
    FROM movierating mr
    JOIN users u
    ON mr.user_id = u.user_id
    JOIN movies m
    ON m.movie_id = mr.movie_id
),
sub1 AS (
    SELECT name, COUNT(movie_id) AS movierating_count
    FROM common
    GROUP BY 1
),
sub2 AS (
    SELECT title, AVG(rating) AS avg_rating
    FROM common
    WHERE created_at >= '2020-02-01' AND created_at < '2020-03-01'
    GROUP BY 1
)
--
(SELECT name AS results
FROM sub1
WHERE movierating_count = ( SELECT MAX(movierating_count) FROM sub1)
ORDER BY name
LIMIT 1)

UNION ALL

(SELECT title AS results
FROM sub2
WHERE avg_rating = (SELECT MAX(avg_rating) FROM sub2)
ORDER BY title
LIMIT 1)
