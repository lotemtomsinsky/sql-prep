-- https://leetcode.com/problems/triangle-judgement/description/?envType=study-plan-v2&envId=top-sql-50

-- need to use triangle inequality theorem. if x+y>z && x+z>y && z+y>x then YES else NO
SELECT 
    x, 
    y, 
    z, 
    -- we can use the boolean expression combinations through AND to determine if it's a triangle or not, and then CASE WHEN
    -- to map T and F results to our expected outcomes
    (CASE WHEN (x + y > z) AND (x + z > y) AND (z + y > x) THEN "Yes" ELSE "No" END) AS triangle
FROM Triangle;