-- https://leetcode.com/problems/percentage-of-users-attended-a-contest/description/?envType=study-plan-v2&envId=top-sql-50

SELECT 
    r.contest_id, 
    -- you can count * from different tables by inserting another select statement in ()
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM Users))*100, 2) as percentage
FROM 
    Users u
    LEFT JOIN Register r 
    ON r.user_id = u.user_id
-- null contests are invalid, but they’ll show up as long as it’s not explicitly stated that they shouldn’t due to the 
-- nature of the join
WHERE 
    contest_id IS NOT NULL
GROUP BY 
    contest_id
ORDER BY 
    percentage DESC, 
    contest_id ASC;