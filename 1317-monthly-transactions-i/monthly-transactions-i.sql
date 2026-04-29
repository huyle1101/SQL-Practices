-- Write your PostgreSQL query statement below
WITH sub AS (
  SELECT *,
         CASE WHEN state = 'approved' THEN 1 ELSE 0 END AS new_state,
         CASE WHEN state = 'approved' THEN amount ELSE 0 END AS new_amount
  FROM transactions
)
SELECT TO_CHAR(trans_date, 'YYYY-MM') AS month, 
       country, 
       COUNT(*) AS trans_count,
       SUM(new_state) AS approved_count,
       SUM(amount) AS trans_total_amount,
       SUM(new_amount) AS approved_total_amount
FROM sub
GROUP BY 1, 2