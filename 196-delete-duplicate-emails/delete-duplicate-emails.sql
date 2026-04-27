-- Write your PostgreSQL query statement below
WITH sub AS (
    SELECT Id, ROW_NUMBER() OVER (PARTITION BY Email ORDER BY Id) AS rn
    FROM Person
)
DELETE FROM Person WHERE Id IN (
    SELECT Id FROM sub WHERE rn > 1
);