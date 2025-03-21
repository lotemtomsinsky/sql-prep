-- https://leetcode.com/problems/consecutive-numbers/description/?envType=study-plan-v2&envId=top-sql-50

-- since grouping by num itself will ruin the ordering of the rows, we'll have to group in another way that doesn't destroy
-- the consecutiveness

WITH numbered AS (
    SELECT
        id, 
        num, 
        -- when we partition by num, we make groups of rows based on them having the same value in the num column
        -- ROW_NUMBER assigns a unique sequential int starting from 1 for each row within the partition based on the
        -- order, which is the id #
        ROW_NUMBER() OVER (PARTITION BY num ORDER BY id) AS rn
    FROM
        Logs
), 
groupings AS (
    SELECT
        num, 
        -- with this, we're able to see consecutive #s because for all rows containing a consecutive value in the num column, the
        -- difference between id and rn will be constant since both are incrementing by 1 until a new # is occured and restarts
        -- the count, changing the value of the difference indicating a consecutive value. 
        (id - rn) AS grp, 
        -- count how many occurences of each difference we see 
        COUNT(*) as cnt
    FROM numbered
    GROUP BY num, id - rn
)
SELECT
    -- since the nums occur potentially more than once, we don't want to double count any that repeat in our results
    DISTINCT num as ConsecutiveNums
FROM groupings 
-- this allows us to pick rows that have a consecutive difference occuring at least 3 times
WHERE cnt >= 3;


/* VISUALIZATION OF WHAT'S HAPPENING

Logs:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+

numbered:
+----+-----+----+
| id | num | rn |
+----+-----+----+
| 1  | 1   | 1  |
| 2  | 1   | 2  |
| 3  | 1   | 3  |
| 4  | 2   | 1  |
| 5  | 1   | 1  |
| 6  | 2   | 1  |
| 7  | 2   | 2  |
+----+-----+----+

groupings:
+-----+-----+-----+
| num | grp | cnt |
+-----+----+------+
| 1   |  0  |  3  |
| 1   |  0  |  3  |
| 1   |  0  |  3  | 
| 2   |  3  |  1  |
| 1   |  4  |  2  |
| 2   |  5  |  1  |
| 2   |  5  |  1  |
+-----+-----+-----+

FINAL RESULT:
+-----------------+
| ConsecutiveNums |
+-----------------+
|       1         |
+-----------------+

*/