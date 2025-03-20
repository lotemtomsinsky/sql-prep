-- https://leetcode.com/problems/queries-quality-and-percentage/description/?envType=study-plan-v2&envId=top-sql-50

SELECT 
    query_name,
    ROUND(AVG(rating * 1.0 / position), 2) AS quality, 
    -- for selecting queries with ratings less than 3 and dividing by total # queries, need to use a CASE WHEN statement, 
    -- and sum all the values as the count for that 
    ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS poor_query_percentage
FROM 
    Queries
GROUP BY 
    query_name;