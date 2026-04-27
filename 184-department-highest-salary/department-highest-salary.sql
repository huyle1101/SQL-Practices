-- Write your PostgreSQL query statement below
WITH get_rn AS (
    SELECT 
        e.*,
        d.name AS department,
        DENSE_RANK() OVER(PARTITION BY d.name ORDER BY e.salary DESC) AS salary_rank
    FROM employee e
    JOIN department d
    ON e.departmentId = d.id
)

SELECT 
    department,
    name AS employee,
    salary
FROM get_rn
WHERE salary_rank=1