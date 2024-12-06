DROP DATABASE IF EXISTS ACT_SSIS_1
CREATE DATABASE ACT_SSIS_1;

USE ACT_SSIS_1;
GO

CREATE TABLE NetflixTitles(
    DurationMinutes INT NULL,
    DurationSeasons INT NULL,
    [Type] NVARCHAR(255) NOT NULL,
    Title NVARCHAR(255) NOT NULL,
    DateAdded NVARCHAR(255) NULL,
    ReleaseYear INT NOT NULL,
    Rating NVARCHAR(255) NULL,
    [Description] NVARCHAR(2000) NOT NULL,
    ShowId NVARCHAR(255) NOT NULL
);

CREATE TABLE NetflixTitlesDirectors(
    Director NVARCHAR(255) NOT NULL,
    ShowId NVARCHAR(255) NOT NULL
);

CREATE TABLE NetflixTitlesCountries(
    Country NVARCHAR(255) NOT NULL,
    ShowId NVARCHAR(255) NOT NULL
);

CREATE TABLE NetflixTitlesCast(
    [Cast] NVARCHAR(255) NOT NULL,
    ShowId NVARCHAR(255) NOT NULL
);

CREATE TABLE NetflixTitlesCategory(
    ListedIn NVARCHAR(255) NOT NULL,
    ShowId NVARCHAR(255) NOT NULL
);

CREATE TABLE Netflix_Join(
    DurationMinutes INT NULL,
    DurationSeasons INT NULL,
    [Type] NVARCHAR(255) NOT NULL,
    Title NVARCHAR(255) NOT NULL,
    DateAdded NVARCHAR(255) NULL,
    ReleaseYear INT NOT NULL,
    Rating NVARCHAR(255) NULL,
    [Description] NVARCHAR(2000) NOT NULL,
    ShowId NVARCHAR(255) NOT NULL,
    Director NVARCHAR(255) NULL,
    Country NVARCHAR(255) NULL,
    [Cast] NVARCHAR(255) NULL,
    ListedIn NVARCHAR(255) NULL
);



/* CREATE TABLE netflix_titles(
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
    director NVARCHAR(255) NULL,
    country NVARCHAR(255) NULL,
    [cast] NVARCHAR(255) NULL,
    listed_in NVARCHAR(255) NULL
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
); */