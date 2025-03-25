-- https://leetcode.com/problems/restaurant-growth/description/?envType=study-plan-v2&envId=top-sql-50

SELECT 
    c1.visited_on, 
    (
        SELECT (SUM(c2.amount))
        FROM Customer c2
        -- how to get dates within the range of the initial date and 6 days before it
        WHERE c2.visited_on BETWEEN DATE_SUB(c1.visited_on, INTERVAL 6 DAY) AND c1.visited_on
    ) as amount,
    (
        -- if you use AVG() here and there's more than one visit per day, then it'll divide by the total number of visits in the
        -- 7 day period rather than by the 7 days themselves. To get the running average for the 7 days, you need to compute the 
        -- sum first, then divide by the period
        SELECT ROUND((SUM(c2.amount)/7), 2)
        FROM Customer c2
        WHERE c2.visited_on BETWEEN DATE_SUB(c1.visited_on, INTERVAL 6 DAY) AND c1.visited_on
    ) as average_amount
FROM Customer c1
-- if we don't do this, we'll have wrong averages for dates that don't have 6 days prior to them, we want to filter that out 
-- this starts from dates that are at least 6 days after the minimum date in the table
WHERE c1.visited_on >= DATE_ADD((SELECT MIN(visited_on) FROM Customer), INTERVAL 6 DAY)
-- if we don't do this, we get duplicate rows and incorrect averages for dates where multiple customers visited
GROUP BY c1.visited_on
ORDER BY c1.visited_on;