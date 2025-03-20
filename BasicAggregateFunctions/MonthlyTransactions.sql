-- https://leetcode.com/problems/monthly-transactions-i/description/?envType=study-plan-v2&envId=top-sql-50

SELECT
    DATE_FORMAT(trans_date, '%Y-%m') as month, 
    country,
    COUNT(*) as trans_count,
    -- can't use COUNT here because t.state = "approved" returns 1 or 0, and since they're both not NULL count will count all rows
    -- regardless of a state. instead, use CASE WHEN 
    SUM(CASE WHEN t.state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(t.amount) as trans_total_amount,
    SUM(CASE WHEN state = "approved" THEN T.amount ELSE 0 END) as approved_total_amount
FROM
    Transactions t
GROUP BY 
    DATE_FORMAT(trans_date, '%Y-%m'),
    country