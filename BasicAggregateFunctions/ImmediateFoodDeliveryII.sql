-- https://leetcode.com/problems/immediate-food-delivery-ii/description/?envType=study-plan-v2&envId=top-sql-50

-- use the WITH clause to create a temporary result where for each customer, we assign their orders a rank with the first order
-- ranked as 1
WITH first_orders AS (
  SELECT
    customer_id,
    order_date,
    customer_pref_delivery_date,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS rn
  FROM Delivery
)
SELECT 
    -- increase count by 1 every time an order is considered an immediate order, otherwise don't 
    ROUND(100.0 * SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) / COUNT(*), 2) AS immediate_percentage
FROM first_orders
-- filters so that for all customers, we only deal with the earliest orders 
WHERE rn = 1;