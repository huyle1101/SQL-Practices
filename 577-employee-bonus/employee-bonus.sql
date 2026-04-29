-- Write your PostgreSQL query statement below
SELECT name, bonus
FROM
(SELECT e.empId AS employee_id, e.name, b.empId AS bonus_id, b.bonus
FROM Employee e
LEFT JOIN Bonus b
ON e.empID = b.empID) sub
WHERE bonus IS NULL OR bonus < 1000;