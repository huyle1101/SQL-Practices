-- Write your PostgreSQL query statement below
WITH sub1 AS
(    SELECT * 
    FROM weather 
    ORDER BY recordDate
),
sub2 AS
(
    SELECT id, recordDate, temperature AS temp,
    LAG(temperature) OVER(ORDER BY recordDate) AS lag_temp,
    LAG(recordDate) OVER(ORDER BY recordDate) AS lag_date
    FROM sub1
)
SELECT id
FROM sub2
WHERE temp > lag_temp AND recordDate - lag_date=1