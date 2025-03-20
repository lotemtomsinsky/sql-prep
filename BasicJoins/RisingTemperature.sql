-- https://leetcode.com/problems/rising-temperature/description/?envType=study-plan-v2&envId=top-sql-50

SELECT 
    w1.id
FROM 
    Weather w1
-- WHERE EXISTS helps see if a subquery returns anything, and the subquery is inside the ()
WHERE EXISTS (
    SELECT 1
    FROM Weather w2
    WHERE w1.temperature > w2.temperature
    -- DATE_SUB allows us to specify intervals between the dates to help us match the condition of consecutive days
    AND w2.recordDate = DATE_SUB(w1.recordDate, INTERVAL 1 DAY)
);