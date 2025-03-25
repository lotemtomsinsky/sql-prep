-- https://leetcode.com/problems/count-salary-categories/description/?envType=study-plan-v2&envId=top-sql-50


-- make a CTE for each of the salary categories
WITH low_salary AS (
    SELECT *
    FROM Accounts 
    WHERE income < 20000
), 
average_salary AS (
    SELECT *
    FROM Accounts 
    WHERE income BETWEEN 20000 AND 50000
),
high_salary AS (
    SELECT *
    FROM Accounts 
    WHERE income > 50000
)

/*
now we need to build our final table. A normal select would give us the format:
+-------------+----------------+------------+
| High Salary | Average Salary | Low Salary |
+-------------+----------------+------------+
|    ...      |      ...       |      ...   |
+-------------+----------------+------------+

but we want:
+----------------+----------------+
|     categry    | accounts_count |
+---------+-----------------------+
|   High Salary  |      ...       |
+----------------+----------------+
| Average Salary |      ...       |
+----------------+----------------+
|   Low Salary   |      ...       |
+----------------+----------------+
*/

-- UNION lets us combine multiple results into 1. We want to write a seperate SELECT for each CTE that'll return two columns:
-- a string literal representing the salary category (so we alias it), and a number which counts how many salaries match that 
-- based on the corresponding CTE. 
SELECT 
    'High Salary' AS category, COUNT(*) AS accounts_count FROM high_salary
UNION
SELECT 
    'Low Salary', COUNT(*) FROM low_salary
UNION
SELECT 
    'Average Salary', COUNT(*) FROM average_salary
-- this lets us define the row order in the table as we wish. We assign a ranking to each row based on the value of the category.
-- default order is ASC so when we rank high as 1, low as 2 and avg as 3, it lets us retain that exact order in the presentation
-- of the final result 
ORDER BY 
  CASE category
    WHEN 'High Salary' THEN 1
    WHEN 'Low Salary' THEN 2
    WHEN 'Average Salary' THEN 3
  END;