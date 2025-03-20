-- https://leetcode.com/problems/confirmation-rate/description/?envType=study-plan-v2&envId=top-sql-50

SELECT s.user_id,
       -- Can't use WHERE to filter confirmed actions because it would remove "timeout" actions from the dataset before counting. 
       -- This would cause incorrect results when calculating the confirmation rate.

       -- a tricky edge case is that a user might have no actions, need to handle this with the IFNULL in select, making the 
       -- default output 0 in this case 
       Round(Ifnull(Count(c.action = "confirmed"OR NULL) / Count(c.action), 0), 2) AS confirmation_rate
FROM   
    signups s
    LEFT JOIN confirmations c
    ON s.user_id = c.user_id
GROUP  BY 
    s.user_id; 