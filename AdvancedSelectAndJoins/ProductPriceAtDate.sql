-- https://leetcode.com/problems/product-price-at-a-given-date/?envType=study-plan-v2&envId=top-sql-50

-- the approach behind this problem is to keep refining CTEs until we're left with a result that's easy to work with.

-- 1) we want to keep a reference of all the products we need to consider in case some get filtered out from the input table with
--    our later queries
WITH IDs AS (
    SELECT product_id 
    FROM Products
), 
-- 2) from the main table, we want to remove from consideration any rows that were updated after our date of interest since they're
--    invalid/outside of the domain
ValidDates AS (
    Select * 
    FROM Products
    WHERE change_date <= '2019-08-16'
),
-- 3) for each product that was updated at least once up till the date of interest, we want to keep only the row detailing the most
--    recent update.
Prices AS (
    SELECT *
    -- we need to keep the subquery here so that on the spot once we do the partitioning and assign the row numbers, we can filter
    -- out just the top row from each group
    FROM (
        SELECT 
            *, 
            -- use ROW_NUMBER() to rank each row within its group (which is products with the same id) based on the change 
            -- date, from the most recent date to the least recent. 
            ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY change_date DESC) AS rn
        FROM ValidDates 
    ) v
    WHERE v.rn = 1
)
-- 4) the main query:
-- there may be duplicates due to the join so we want to make sure we don't have those in our result
SELECT DISTINCT
    i.product_id, 
    -- here we switch out the default value. Left join leaves us wil NULL if the product was never updated, but we know the base
    -- price displayed should be 10
    CASE
        WHEN p.new_price IS NULL THEN 10
        ELSE p.new_price
    END AS price
-- left join from IDs to Prices because we want to account for all products. If they were never updated, left join will leave us
-- with a NULL in the price column. Otherwise it'll get the value from the top row filtration in Prices we did earlier
FROM IDs i
LEFT JOIN Prices p ON i.product_id = p.product_id;