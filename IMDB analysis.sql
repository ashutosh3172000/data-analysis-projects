use movie;
select * from moviedataset;
ALTER TABLE moviedataset RENAME COLUMN `Revenue(Millions)` TO revenue;
##Top 10 highest rated movies
SELECT title, rating
FROM moviedataset
ORDER BY rating DESC
LIMIT 10;
##Movies Released After 2015
SELECT title,year
FROM moviedataset
WHERE year > 2015;
##Movies with Rating Greater Than 8
SELECT title, rating
FROM moviedataset
WHERE rating > 8
ORDER BY rating DESC;
##Total Number of Movies
SELECT COUNT(*) AS total_movies
FROM moviedataset;
##Average Rating by Genre
SELECT genre, AVG(rating) AS avg_rating
FROM moviedataset
GROUP BY genre
ORDER BY avg_rating DESC;
##Count of Movies by Year
SELECT year, COUNT(*) AS movie_count
FROM moviedataset
GROUP BY year
ORDER BY year;
##Top 5 Genres by Movie Count
SELECT genre, COUNT(*) AS movie_count
FROM moviedataset
GROUP BY genre
ORDER BY movie_count DESC
LIMIT 5;
##Movies Between 2000 and 2010
SELECT title,year
FROM moviedataset
WHERE year BETWEEN 2000 AND 2010
ORDER BY year;
##Movie with Highest Votes
SELECT title, votes
FROM moviedataset
ORDER BY votes DESC
LIMIT 1;
##JOIN Example (If Rat in Separate Table)
CREATE TABLE movie_ratings AS
SELECT m.rank,
       m.title,
       m.genre,
       m.year,
       m.rating
FROM moviedataset m;
SELECT m.title, m.rating
FROM moviedataset m
JOIN movie_ratings r
ON m.rank = r.rank;
##Rank Movies by Rating (Window Function)
SELECT title, rating,
       RANK() OVER (ORDER BY rating DESC) AS ranking
FROM moviedataset;
##Top Movie Per Year
SELECT *
FROM (
    SELECT title, year, rating,
           RANK() OVER (PARTITION BY year ORDER BY rating DESC) AS ranking
    FROM moviedataset
) ranked_movies
WHERE ranking = 1;
##Movies Above Average Rating
SELECT title, rating
FROM moviedataset
WHERE rating > (SELECT AVG(rating) FROM moviedataset);
##votes by Genre
SELECT genre, SUM(votes) AS total_votes
FROM moviedataset
GROUP BY genre
ORDER BY total_votes DESC;
##Most Active Director
SELECT director, COUNT(*) AS movie_count
FROM moviedataset
GROUP BY director
ORDER BY movie_count DESC
LIMIT 1;
##Movies Having More Then Avarage Metascore
SELECT title, metascore
FROM moviedataset
WHERE metascore > (SELECT AVG(metascore) FROM moviedataset);
##Year with Most Movie Releases
SELECT year, COUNT(*) AS movie_count
FROM moviedataset
GROUP BY year
ORDER BY movie_count DESC
LIMIT 1;
##Top 3 Movies in Each Genre
SELECT *
FROM (
    SELECT title, genre, rating,
           RANK() OVER (PARTITION BY genre ORDER BY rating DESC) AS ranking
    FROM moviedataset
) ranked_movies
WHERE ranking <= 3;
##Create View for Top Rated Movies
CREATE VIEW top_rated_movies AS
SELECT title, rating
FROM moviedataset
WHERE rating > 8;