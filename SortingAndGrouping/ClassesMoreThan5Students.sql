-- https://leetcode.com/problems/classes-more-than-5-students/description/?envType=study-plan-v2&envId=top-sql-50

SELECT 
    class
FROM 
    Courses
-- since it's per class, we group by class
GROUP BY 
    class
-- this is an attribute/condition each group should meet, so instead of where (which is filtering individual rows)
-- we need to filter by group conditions
HAVING
    COUNT(student) >= 5;