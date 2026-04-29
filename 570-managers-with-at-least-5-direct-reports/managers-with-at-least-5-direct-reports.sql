-- Write your PostgreSQL query statement below
SELECT name
FROM
(SELECT managerID, COUNT(*) AS report_count
FROM Employee
GROUP BY 1
ORDER BY 2 DESC) sub
JOIN employee e
ON e.id = sub.managerID
WHERE report_count >= 5