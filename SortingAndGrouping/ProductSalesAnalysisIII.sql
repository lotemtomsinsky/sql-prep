-- https://leetcode.com/problems/product-sales-analysis-iii/?envType=study-plan-v2&envId=top-sql-50

SELECT product_id,
    year AS "first_year",
    quantity,
    price
FROM 
    Sales
WHERE 
    (product_id, year) IN (
        SELECT 
            product_id,
            MIN(year) AS "first_year" 
        FROM 
            Sales 
        GROUP BY 
            product_id
    );