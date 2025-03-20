-- https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/?envType=study-plan-v2&envId=top-sql-50

SELECT e1.name
FROM   employee e1
        JOIN employee e2
        ON e1.id = e2.managerid
-- need to group by name AND id or else it won’t show managers with same names but different Id’s
GROUP  BY e1.name, e1.id
HAVING Count(*) >= 5; 