-- https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/description/?envType=study-plan-v2&envId=top-sql-50

-- it's not guaranteed that all the people that have friends made requests, they could be just accepting requests so we want a 
-- list of ALL potential ids
WITH ids AS (
    SELECT requester_id as id FROM RequestAccepted 
    UNION
    SELECT accepter_id FROM RequestAccepted 
)
SELECT 
    id,
    -- total # friends = # times you requested someone + # times you accepted someone
    ( 
        -- first subquery counts how many times the id we're considering shows up as a requester
        (SELECT COUNT(r.requester_id)
        FROM RequestAccepted r
        WHERE r.requester_id = i.id )
        + 
        -- second subquery counts how many times the id we're considering shows up as an accepter
        (SELECT COUNT(r.accepter_id)
        FROM RequestAccepted r
        WHERE r.accepter_id = i.id)
    ) AS num
FROM ids i
-- you don't need to do this for the answer to be correct, but it helps minimize how many times the expensive subqueries are 
-- executed, leading to a better overall run-time.
GROUP BY id
ORDER BY num DESC
LIMIT 1;