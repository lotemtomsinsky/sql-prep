-- https://leetcode.com/problems/average-time-of-process-per-machine/description/?envType=study-plan-v2&envId=top-sql-50

SELECT 
    s.machine_id, ROUND(SUM(e.timestamp - s.timestamp)/COUNT(*),3) AS processing_time
-- joining the table with itself lets us subtract the start and end timestamps as well as to specify that the first timestamp 
-- should be the end and the second should be the start 
FROM 
    Activity s
JOIN 
    Activity e 
ON 
    s.machine_id = e.machine_id
AND  
    s.activity_type = 'start'
AND 
    e.activity_type = 'end'
GROUP BY 
    s.machine_id;