-- https://leetcode.com/problems/customers-who-bought-all-products/description/?envType=study-plan-v2&envId=top-sql-50

SELECT 
    customer_id 
FROM 
    Customer
GROUP BY
    customer_id
HAVING
    -- a customer can buy the same product more than once, so make sure to use unique otherwise it'll throw off the count
    -- to compare it against all the rows in Products, we need to wrap the entire subquery in parentheses otherwise it won't work
    COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product);