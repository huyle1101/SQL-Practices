-- Write your PostgreSQL query statement below
WITH sub AS (
    SELECT id, salary, DENSE_RANK() OVER(ORDER BY salary DESC)
    FROM employee
)
SELECT COALESCE(
    (SELECT DISTINCT salary
    FROM sub
    WHERE dense_rank = 2), NULL) AS secondhighestsalary