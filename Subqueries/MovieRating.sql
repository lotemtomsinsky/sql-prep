-- https://leetcode.com/problems/movie-rating/description/?envType=study-plan-v2&envId=top-sql-50

-- by making an alias here, we define what the column name should be 
SELECT name AS results
FROM (
    -- we want to make a result where we have the name of each reviewer and how many movies they've reviewed, sorted in most to
    -- least reviewed, and alphabetically for any ties
    SELECT
        u.name, 
        COUNT(*) AS movies_rated
    FROM 
        MovieRating m
        INNER JOIN Users u ON m.user_id = u.user_id
    GROUP BY 
        m.user_id
    ORDER BY 
        movies_rated DESC, 
        u.name ASC
    -- as we're only interested in the person with the MOST overall reviews, limit by 1 to get only them
    LIMIT 1
) AS most_ratings_written

-- if we did UNION instead, it would remove rows where the name of the person is the same as the name of the movie, which is
-- not something that we want 
UNION ALL

SELECT title
FROM (
    -- we want a result where for each movie title, we get its average rating for the month of februrary. Sort in highest to lowest
    -- ratings, breaking ties alphabetically
    SELECT 
        m.title,
        AVG(mr.rating) AS rated
    FROM 
        MovieRating mr
        INNER JOIN Movies m ON mr.movie_id = m.movie_id
    -- 28 days in Feb, capture all ratings within these dates 
    WHERE 
        mr.created_at BETWEEN '2020-02-01' AND '2020-02-28'
    -- if we don't do this, it'll take the average rating for all the movies 
    GROUP BY 
        m.title
    ORDER BY 
        rated DESC, 
        m.title ASC
    -- since we only want the highest rated movie (not movies), limit by 1 to get the top result 
    LIMIT 1
) AS highest_rated_movie;


/*
this was my initial draft, and these CTEs can be rewritten as subqueries by directly imbedding everything within the () after AS 
into the FROM statement 

WITH most_ratings_written AS (
    SELECT
        u.name, 
        COUNT(*) AS movies_rated
    FROM MovieRating m
    INNER JOIN Users u on m.user_id = u.user_id
    GROUP BY m.user_id
    ORDER BY movies_rated DESC, u.name ASC
    LIMIT 1
),
highest_rated_movie AS (
    SELECT 
        m.title, 
        AVG(mr.rating) as rated
    FROM 
        MovieRating mr
        INNER JOIN Movies m
        ON mr.movie_id = m.movie_id
    WHERE mr.created_at BETWEEN '2020-02-01' AND '2020-02-28'
    GROUP BY m.title
    ORDER BY rated DESC, m.title ASC
    LIMIT 1
)
SELECT 
    name as results FROM most_ratings_written
UNION ALL
SELECT 
    title FROM highest_rated_movie
*/