-- Write your PostgreSQL query statement below
WITH identify_zombie AS (
    SELECT
        session_id,
        user_id,
        CASE WHEN event_type='click' THEN 1 ELSE 0 END AS has_clicks,
        CASE WHEN event_type='scroll' THEN 1 ELSE 0 END AS has_scrolls,
        CASE WHEN event_type='purchase' THEN 1 ELSE 0 END AS has_purchases
    FROM app_events
    ORDER BY 
        session_id,
        user_id
),
get_duration AS (
    SELECT
        session_id,
        user_id,
        EXTRACT(EPOCH FROM (MAX(event_timestamp) - MIN(event_timestamp))) / 60 AS session_duration_minutes
    FROM app_events
    GROUP BY
        session_id,
        user_id
    ORDER BY
        session_id,
        user_id
)

SELECT 
    gd.session_id,
    gd.user_id,
    gd.session_duration_minutes,
    SUM(has_scrolls) AS scroll_count
FROM identify_zombie iz
JOIN get_duration gd
USING(user_id)
GROUP BY
    gd.session_id,
    gd.user_id,
    gd.session_duration_minutes
HAVING
    gd.session_duration_minutes > 30
    AND SUM(has_clicks)*1.0 / SUM(has_scrolls)*1.0 <0.2
    AND SUM(has_purchases)=0
    AND SUM(has_scrolls)>=5
ORDER BY 
    SUM(has_scrolls) DESC,
    gd.session_id

-- SELECT *
-- FROM get_duration