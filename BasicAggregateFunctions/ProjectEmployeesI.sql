-- https://leetcode.com/problems/project-employees-i/description/?envType=study-plan-v2&envId=top-sql-50

SELECT 
    p.project_id, 
        ROUND(SUM(e.experience_years)/COUNT(*), 2) as average_years
FROM 
    Project p 
    INNER JOIN Employee e 
    ON p.employee_id = e.employee_id
GROUP BY 
    project_id;