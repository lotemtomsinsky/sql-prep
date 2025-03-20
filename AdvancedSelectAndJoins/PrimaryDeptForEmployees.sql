-- https://leetcode.com/problems/primary-department-for-each-employee/description/?envType=study-plan-v2&envId=top-sql-50

SELECT
    employee_id, 
    CASE
        -- though MAX seems unintuitive here, SQL required any column in SELECT that isn't part of GROUP BY to be aggregated
        -- even though logically we expect there to only be one department for each employee to match either of these conditions,
        -- aggregate functions like MAX explicitly tell SQL to combine into a single value. 
        WHEN COUNT(DISTINCT department_id) = 1 THEN MAX(department_id)
        ELSE MAX(CASE WHEN primary_flag = "Y" THEN department_id END)
    END AS department_id
FROM 
    Employee
GROUP BY 
    employee_id;