-- https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/description/?envType=study-plan-v2&envId=top-sql-50

-- returns a table with all managers' names and ids
WITH managers AS (
    -- if you don't use distinct, for managers with more than one report it'll make a new row for each new report 
    SELECT DISTINCT
        e.name, 
        e.employee_id AS manager_id
    FROM Employees e
    JOIN Employees p ON e.employee_id = p.reports_to
)
SELECT
    m.manager_id as employee_id, 
    m.name as name,
    COUNT(e.name) as reports_count,
    ROUND(AVG(e.age), 0) as average_age -- rounded to the nearest integer
FROM managers m
-- the common column here is that the manager id's are those in reports_to in employees
INNER JOIN Employees e ON m.manager_id = e.reports_to
-- we don't want to consider any employee who doesn't report to someone 
WHERE 
    e.reports_to IS NOT NULL
GROUP BY 
    m.manager_id
ORDER BY 
    m.manager_id; -- order by the employee id of the manager not their subordinates