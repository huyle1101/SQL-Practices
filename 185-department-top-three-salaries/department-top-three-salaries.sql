-- Write your PostgreSQL query statement below
WITH sub AS (
    SELECT e.*, d.name AS department_name, DENSE_RANK() OVER (PARTITION BY departmentid ORDER BY salary DESC)
FROM employee e
JOIN department d
ON e.departmentid = d.id
ORDER BY departmentid, salary DESC
)
SELECT department_name AS department, name AS employee, salary
FROM sub
WHERE dense_rank <= 3