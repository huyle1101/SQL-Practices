-- Write your PostgreSQL query statement below
WITH prefix_found AS (
    SELECT *, LEFT(mail, LENGTH(mail)-13) AS prefix
    FROM users
)
SELECT user_id, name, mail
FROM prefix_found
WHERE mail LIKE '%@leetcode.com' AND prefix ~* '^[a-z][a-z0-9_.-]*$'