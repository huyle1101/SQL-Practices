-- Write your PostgreSQL query statement below
WITH sub AS (
    SELECT *,
LEAD(num) OVER(ORDER BY id) AS lead_num,
LAG(num) OVER(ORDER BY id) AS lag_num
FROM logs
)
SELECT num AS ConsecutiveNums
FROM
(SELECT num, COUNT(consecutive) AS consecutive_count
FROM
(SELECT num, CASE WHEN (num = lead_num AND num = lag_num) THEN 'Yes' ELSE 'No' END AS "consecutive"
FROM sub) inner_sub_qry
WHERE consecutive = 'Yes'
GROUP BY 1) outer_sub_query
WHERE consecutive_count >= 1