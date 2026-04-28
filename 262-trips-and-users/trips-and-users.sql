-- Write your PostgreSQL query statement below
WITH sub AS ( -- remove banned users and flag cancelled requests
    SELECT 
        id,
        client_id, 
        driver_id,
        status,
        request_at,
        CASE WHEN status LIKE 'cancelled%' THEN 1 ELSE 0 END AS is_cancelled
    FROM trips t
    JOIN users u1 ON t.client_id = u1.users_id AND u1.banned='No' --filter out unbanned client
    JOIN users u2 ON t.driver_id = u2.users_id AND u2.banned='No' --filter out unbanned drivers
    AND request_at::DATE BETWEEN '2013-10-01' AND '2013-10-03'
)

SELECT 
    request_at AS day,
    ROUND(AVG(is_cancelled), 2) AS "cancellation rate"
FROM sub
GROUP BY 1

-- SELECT *
-- FROM sub