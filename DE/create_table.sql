DROP DATABASE IF EXISTS ACT_SSIS_1
CREATE DATABASE ACT_SSIS_1;

USE ACT_SSIS_1;
GO


CREATE TABLE netflix_titles(
	duration_minutes INT NULL,
    duration_seasons INT NULL,
    [type] NVARCHAR(255) NOT NULL,
	title NVARCHAR(255) NOT NULL,
	date_added NVARCHAR(255) NULL,
	release_year INT NOT NULL,
	rating NVARCHAR(255) NULL,
	[description] NVARCHAR(2000) NOT NULL,
	show_id NVARCHAR(255) NOT NULL
);

CREATE TABLE netflix_titles_directors(
	director NVARCHAR(255) NOT NULL,
	show_id NVARCHAR(255) NOT NULL,
);

CREATE TABLE netflix_titles_countries(
	country NVARCHAR(255) NOT NULL,
	show_id NVARCHAR(255) NOT NULL,
);

CREATE TABLE netflix_titles_cast(
	[cast] NVARCHAR(255) NOT NULL,
	show_id NVARCHAR(255) NOT NULL,
);

CREATE TABLE netflix_titles_category(
	listed_in NVARCHAR(255) NOT NULL,
	show_id NVARCHAR(255) NOT NULL,
);

CREATE TABLE Netflix_Join(
    duration_minutes INT NULL,
    duration_seasons INT NULL,
    [type] NVARCHAR(255) NOT NULL,
    title NVARCHAR(255) NOT NULL,
    date_added NVARCHAR(255) NULL,
    release_year INT NOT NULL,
    rating NVARCHAR(255) NULL,
    [description] NVARCHAR(2000) NOT NULL,
    show_id NVARCHAR(255) NOT NULL,
    director NVARCHAR(MAX) NULL,
    country NVARCHAR(MAX) NULL,
    [cast] NVARCHAR(MAX) NULL,
    listed_in NVARCHAR(MAX) NULL
);

CREATE TABLE Netflix_Join2(
    duration_minutes INT NULL,
    duration_seasons INT NULL,
    [type] NVARCHAR(255) NOT NULL,
    title NVARCHAR(255) NOT NULL,
    date_added NVARCHAR(255) NULL,
    release_year INT NOT NULL,
    rating NVARCHAR(255) NULL,
    [description] NVARCHAR(2000) NOT NULL,
    show_id NVARCHAR(255) NOT NULL,
    director NVARCHAR(MAX) NULL,
    country NVARCHAR(MAX) NULL,
    [cast] NVARCHAR(MAX) NULL,
    listed_in NVARCHAR(MAX) NULL
);


truncate table Netflix_Join;
select count(distinct show_id) from Netflix_Join;
select * from Netflix_Join;


select * from netflix_titles_directors order by show_id desc;
select * from netflix_titles_countries order by show_id desc;
select * from netflix_titles_cast order by show_id desc;
select * from netflix_titles_category order by show_id desc;
select count(distinct show_id) from Netflix_Join2 ;
select top 5*  from Netflix_Join2;
select *  from Netflix_Join2;

WITH DistinctValues AS (
    SELECT DISTINCT
        show_id,
        TRIM(director) AS director,
        TRIM(country) AS country,
        TRIM([cast]) AS [cast],
        TRIM(listed_in) AS listed_in
    FROM Netflix_Join2
)
UPDATE nj
SET 
    director = agg.director_list,
    country = agg.country_list,
    [cast] = agg.cast_list,
    listed_in = agg.genre_list
FROM Netflix_Join2 nj
JOIN (
    SELECT 
        show_id,
        STRING_AGG(director, ', ') AS director_list,
        STRING_AGG(country, ', ') AS country_list,
        STRING_AGG([cast], ', ') AS cast_list,
        STRING_AGG(listed_in, ', ') AS genre_list
    FROM DistinctValues
    GROUP BY show_id
) AS agg
ON nj.show_id = agg.show_id;


WITH AggregatedData AS (
    SELECT 
        show_id,
        (SELECT STRING_AGG(director, ', ') 
		FROM (SELECT DISTINCT director FROM Netflix_Join2 WHERE show_id = nj2.show_id) AS DistinctDirectors) AS director_list,
		(SELECT STRING_AGG(country, ', ') 
		 FROM (SELECT DISTINCT country FROM Netflix_Join2 WHERE show_id = nj2.show_id) AS DistinctCountries) AS country_list,
		(SELECT STRING_AGG([cast], ', ') 
		 FROM (SELECT DISTINCT [cast] FROM Netflix_Join2 WHERE show_id = nj2.show_id) AS DistinctCast) AS cast_list,
		(SELECT STRING_AGG(listed_in, ', ') 
		 FROM (SELECT DISTINCT listed_in FROM Netflix_Join2 WHERE show_id = nj2.show_id) AS DistinctGenres) AS category_list
		FROM Netflix_Join2 nj2
		GROUP BY show_id
)
UPDATE nj2
SET
    nj2.director = agg.director_list,
    nj2.country = agg.country_list,
    nj2.[cast] = agg.cast_list,
    nj2.listed_in = agg.category_list
FROM Netflix_Join2 nj2
JOIN AggregatedData agg
    ON nj2.show_id = agg.show_id;

SELECT * INTO test1
FROM Netflix_Join2
WHERE 1 = 0;
truncate table test1;
INSERT INTO test1
SELECT * FROM Netflix_Join2;

select count(distinct show_id) from test1 ;
select *  from test1 where director = NULL AND country = NULL and cast = NULL and listed_in = NULL;
select *  from test1 where show_id = '81075235';
select *  from Netflix_Join2 where show_id = '81075235';

WITH CTE AS (
    SELECT *,
           RN = ROW_NUMBER() OVER (PARTITION BY title, [type], duration_minutes, 
		   duration_seasons, date_added, release_year, rating, [description], 
		   director, country, [cast], listed_in ORDER BY show_id)
    FROM test1
)
DELETE FROM CTE WHERE RN > 1;



SELECT t1.show_id
FROM Netflix_Join2 t1
LEFT JOIN test1 t2 ON t1.show_id = t2.show_id
WHERE t2.show_id IS NULL;


INSERT INTO Netflix_Join2 (show_id, title, [type], duration_minutes, duration_seasons, date_added, 
                  release_year, rating, [description], director, country, [cast], listed_in)
SELECT distinct t1.show_id, t1.title, t1.[type], t1.duration_minutes, t1.duration_seasons, t1.date_added,
       t1.release_year, t1.rating, t1.[description], t1.director, t1.country, t1.[cast], t1.listed_in
FROM test1 t1
LEFT JOIN Netflix_Join2 nj2 ON t1.show_id = nj2.show_id
WHERE nj2.show_id IS NULL;



SELECT 
    show_id,
	title,
    [type],
    duration_minutes,
    duration_seasons,
    date_added,
    release_year,
    rating,
    [description],
    (SELECT STRING_AGG(director, ', ') 
     FROM (SELECT DISTINCT director FROM Netflix_Join2 WHERE show_id = nj.show_id) AS DistinctDirectors) AS director_list,
    (SELECT STRING_AGG(country, ', ') 
     FROM (SELECT DISTINCT country FROM Netflix_Join2 WHERE show_id = nj.show_id) AS DistinctCountries) AS country_list,
    (SELECT STRING_AGG([cast], ', ') 
     FROM (SELECT DISTINCT [cast] FROM Netflix_Join2 WHERE show_id = nj.show_id) AS DistinctCast) AS cast_list,
    (SELECT STRING_AGG(listed_in, ', ') 
     FROM (SELECT DISTINCT listed_in FROM Netflix_Join2 WHERE show_id = nj.show_id) AS DistinctGenres) AS genre_list
FROM Netflix_Join2 nj
GROUP BY 
	show_id,
	title,
    [type],
    duration_minutes,
    duration_seasons,
    date_added,
    release_year,
    rating,
    [description]
order by title desc;


WITH DistinctValues AS (
    SELECT DISTINCT 
        show_id, 
		title,
		[type],
		duration_minutes,
		duration_seasons,
		date_added,
		release_year,
		rating,
		[description],
        director, 
        country, 
        [cast], 
        listed_in
    FROM Netflix_Join2
)
SELECT 
    show_id, 
	title,
	[type],
	duration_minutes,
	duration_seasons,
	date_added,
	release_year,
	rating,
	[description],
    STRING_AGG(director, ', ') AS director_list,
    STRING_AGG(country, ', ') AS country_list,
    STRING_AGG([cast], ', ') AS cast_list,
    STRING_AGG(listed_in, ', ') AS genre_list
FROM DistinctValues
GROUP BY 
	show_id,
	title,
    [type],
    duration_minutes,
    duration_seasons,
    date_added,
    release_year,
    rating,
    [description];



