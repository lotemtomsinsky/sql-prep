-- https://leetcode.com/problems/employees-whose-manager-left-the-company/description/?envType=study-plan-v2&envId=top-sql-50

-- **A CTE is not a subquery**

SELECT employee_id
FROM Employees 
-- a manager left if their id is not in the employee_id column, so select all the employee id's and select any manager id not in it
WHERE manager_id NOT IN (
    SELECT employee_id
    FROM Employees 
)
AND salary < 30000
ORDER BY employee_id ASC;