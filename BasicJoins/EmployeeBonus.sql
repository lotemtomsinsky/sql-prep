-- https://leetcode.com/problems/employee-bonus/description/?envType=study-plan-v2&envId=top-sql-50

SELECT 
    e.name, b.bonus 
FROM 
    Employee e
LEFT JOIN 
    Bonus b 
ON 
    e.empId = b.empId
WHERE 
    b.bonus < 1000
-- if you want to include null values, it has to be done explicitly because by default they’re excluded
OR 
    b.bonus IS NULL;