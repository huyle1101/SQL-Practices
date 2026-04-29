# Write your MySQL query statement below
# Write your MySQL query statement below
SELECT unique_id, name
FROM EmployeeUNI e1
RIGHT JOIN Employees e2
ON e1.id = e2.id;