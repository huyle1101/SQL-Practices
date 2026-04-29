-- Write your PostgreSQL query statement below
WITH sub AS (
    SELECT employee_id, COUNT(*) AS department_count
    FROM employee
    GROUP BY 1
)
SELECT s.employee_id, e.department_id
FROM sub s
JOIN employee e
ON s.employee_id = e.employee_id
WHERE s.department_count = 1

UNION ALL

SELECT employee_id, department_id
FROM employee
WHERE primary_flag = 'Y'