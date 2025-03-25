-- https://leetcode.com/problems/exchange-seats/description/?envType=study-plan-v2&envId=top-sql-50

-- can swap ids and then re-order, or just swap the student names. Gets you the same result 
SELECT
    id,
    CASE 
        -- if the row (aka id) is odd, then select the student name from the next even row. if that's null (aka on last row), 
        -- then just keep the current student name
        WHEN id % 2 = 1 THEN 
            IFNULL((SELECT s.student 
                    FROM Seat s 
                    WHERE s.id = Seat.id + 1), student)
        -- if the id is even just swap the current student name for the previous 
        WHEN id % 2 = 0 THEN 
            (SELECT s.student 
             FROM Seat s 
             WHERE s.id = Seat.id - 1)
    END AS student
FROM Seat
ORDER BY id;
