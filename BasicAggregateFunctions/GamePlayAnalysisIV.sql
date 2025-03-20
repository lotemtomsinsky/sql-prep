-- https://leetcode.com/problems/game-play-analysis-iv/description/?envType=study-plan-v2&envId=top-sql-50

-- the key is not counting all consecutive logins, but consecutive from FIRST login. Find the initial login 
-- for each player first
WITH first_login AS (
    SELECT 
        player_id,
        MIN(event_date) AS first_date
    FROM Activity
    GROUP BY player_id
),
-- now find all players who logged in the day after their first login
consecutive_players AS (
    -- need to use DISTINCT so each player is only counted once regardless of how many times they've logged in
    SELECT DISTINCT f.player_id
    FROM first_login f
    -- this will leave us with a list of players whose event dates are exactly 1 day after their first login
    JOIN Activity a 
        ON f.player_id = a.player_id 
        AND a.event_date = DATE_ADD(f.first_date, INTERVAL 1 DAY)
)
SELECT ROUND(
    (SELECT COUNT(*) FROM consecutive_players) / (SELECT COUNT(*) FROM first_login), 2) AS fraction;