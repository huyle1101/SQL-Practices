-- Write your PostgreSQL query statement below
WITH sub AS ( -- get salesperson that have sales to company RED
    SELECT 
        s.name AS salesperson_name,
        c.name AS company_name
    FROM salesperson s
    JOIN orders o
    USING(sales_id)
    JOIN company c
    USING(com_id)
    WHERE c.name = 'RED'
)

SELECT name 
FROM salesperson
WHERE name NOT IN (SELECT salesperson_name FROM sub)