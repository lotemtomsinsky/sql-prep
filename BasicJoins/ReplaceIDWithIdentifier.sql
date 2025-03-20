-- https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/description/?envType=study-plan-v2&envId=top-sql-50

SELECT 
    EU.unique_id, E.name 
FROM 
    Employees 
AS 
    E 
LEFT JOIN 
    EmployeeUNI 
AS 
    EU 
ON 
    E.id = EU.id;