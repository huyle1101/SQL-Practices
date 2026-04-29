# Write your MySQL query statement below
SELECT machine_id, ROUND(SUM(time_modified) / COUNT(DISTINCT process_id),3) AS processing_time
FROM
(SELECT machine_id, process_id,
CASE WHEN activity_type = 'start' THEN timestamp*-1 ELSE timestamp*1 END AS "time_modified"
FROM Activity) timestamp_manipulation
GROUP BY 1