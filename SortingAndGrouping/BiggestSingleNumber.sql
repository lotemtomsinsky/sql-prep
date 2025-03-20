-- https://leetcode.com/problems/biggest-single-number/description/?envType=study-plan-v2&envId=top-sql-50

-- this is to find all the uniquely occuring numbers in the table
WITH unique_nums AS (
    SELECT *
    FROM 
        MyNumbers
    GROUP BY 
        num
    HAVING 
        COUNT(num) = 1
)
SELECT 
    -- when we run an aggregate function over an empty set of rows, SQL returns a single row with the result as NULL 
    -- which is why we don't need to explicitly define that behaviour in our query
    MAX(num) AS num
FROM unique_nums;