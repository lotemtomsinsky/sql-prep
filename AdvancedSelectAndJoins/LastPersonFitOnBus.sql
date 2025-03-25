-- https://leetcode.com/problems/last-person-to-fit-in-the-bus/description/?envType=study-plan-v2&envId=top-sql-50

-- first thing we need to do is get all the passengers who boarded the bus, and for each person's turn what the total weight
-- on the bus was
WITH boarded_passengers AS (
    SELECT 
        *,
        -- we want to sum the weight of the passengers in the order of their boarding 
        SUM(weight) OVER (ORDER BY turn) AS total_bus_weight
    FROM 
        Queue q 
)
-- now we want to select the last person who boarded the bus
SELECT 
    person_name
FROM 
    boarded_passengers
-- only consider those people in the queue who don't exceed the total limit 
WHERE 
    total_bus_weight <= 1000
-- earlier we ordered by turn, so to get the last person at the top we need to reverse the ordering
ORDER BY 
    turn DESC
-- limit 1 gets us the top row, which is the last person to board the bus
LIMIT 1;
