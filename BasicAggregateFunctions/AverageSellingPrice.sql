-- https://leetcode.com/problems/average-selling-price/description/?envType=study-plan-v2&envId=top-sql-50

SELECT 
    p.product_id, 
    IFNULL(ROUND(SUM(p.price * u.units)/SUM(u.units), 2), 0) as average_price 
FROM 
    Prices p
    LEFT JOIN UnitsSold u 
    ON p.product_id = u.product_id 
    AND u.purchase_date 
    -- can use the between keyword to filter things that aren't exact and it gives you a range with upper and lower bounds
    BETWEEN p.start_date AND p.end_date
GROUP BY 
    p.product_id;