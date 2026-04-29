WITH sub AS ( -- flag poor rating query
    SELECT *, 
    CASE WHEN rating<3 THEN 1 ELSE 0 END AS poor_rating
    FROM queries
)
SELECT query_name,
ROUND(AVG(rating*1.0/position*1.0),2) AS quality,
ROUND(AVG(poor_rating)*100,2) AS poor_query_percentage
FROM sub
GROUP BY 1