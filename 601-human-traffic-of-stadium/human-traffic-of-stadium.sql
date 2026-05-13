-- Write your PostgreSQL query statement below
WITH get_lag_values AS (
    SELECT
        id,
        visit_date, 
        people,
        COALESCE(LAG(id) OVER(ORDER BY visit_date), id) AS lag_id,
        LAG(people) OVER(ORDER BY visit_date) AS lag_people
    FROM stadium
    ORDER BY visit_date
),
get_flags AS (
    SELECT 
        *,
        CASE 
            WHEN id=lag_id+1 
            OR id=lag_id --first row with no lag id
        THEN 1 ELSE 0 END AS is_consecutive_id,
        CASE WHEN people>=100 THEN 1 ELSE 0 END AS geq_100_people
    FROM get_lag_values
),
assign_group AS(
    SELECT 
        *,
        id-ROW_NUMBER() OVER(ORDER BY id) AS group_id
    FROM get_flags
    WHERE is_consecutive_id=1 AND geq_100_people=1
    ORDER BY visit_date
)

SELECT 
    id,
    visit_date,
    people
FROM assign_group
WHERE group_id IN (
    SELECT group_id
    FROM assign_group
    GROUP BY group_id
    HAVING COUNT(id)>=3
)
ORDER BY visit_date
-- SELECT *
-- FROM assign_group

