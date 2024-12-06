USE ACT_SSIS_1;
GO

-- FactNetflixShow
CREATE TABLE FactNetflixShow(
    ShowId NVARCHAR(20) NOT NULL,
    DurationMinutes INT NULL,
    DurationSeasons INT NULL,
    DateAdded DATETIME NULL,
	CONSTRAINT pk_fact_netflix_show PRIMARY KEY (ShowId)
);
INSERT INTO FactNetflixShow
SELECT DISTINCT
	ShowId, DurationMinutes, DurationSeasons, 
	CAST(DateAdded AS DATETIME) AS DateAdded_Converted
FROM NetflixTitles;


-- DimTitle
CREATE TABLE DimTitle(
    ShowId NVARCHAR(20) NOT NULL,
    [Type] NVARCHAR(255) NOT NULL,
    Title NVARCHAR(255) NOT NULL,
    ReleaseYear INT NOT NULL,
    Rating NVARCHAR(255) NULL,
    [Description] NVARCHAR(2000) NOT NULL,
	CONSTRAINT pk_dim_title PRIMARY KEY (ShowId)
);
INSERT INTO DimTitle
SELECT DISTINCT
	ShowId, [Type], Title, ReleaseYear, Rating, [Description]
FROM NetflixTitles;


-- DimDirector
CREATE TABLE DimDirector(
    ShowId NVARCHAR(20) NOT NULL,
    Director NVARCHAR(100) NOT NULL,
    CONSTRAINT pk_dim_director PRIMARY KEY (ShowId, Director)
);
INSERT INTO DimDirector
SELECT DISTINCT
	ShowId, Director
FROM NetflixTitlesDirectors;


-- DimCountry
CREATE TABLE DimCountry(
    ShowId NVARCHAR(20) NOT NULL,
    Country NVARCHAR(100) NOT NULL,
	CONSTRAINT pk_dim_country PRIMARY KEY (ShowId, Country)
);
INSERT INTO DimCountry
SELECT DISTINCT
	ShowId, Country
FROM NetflixTitlesCountries;


-- DimCast
CREATE TABLE DimCast(
    ShowId NVARCHAR(20) NOT NULL,
    [Cast] NVARCHAR(100) NOT NULL,
	CONSTRAINT pk_dim_cast PRIMARY KEY (ShowId, [Cast])
);
INSERT INTO DimCast
SELECT DISTINCT
	ShowId, [Cast]
FROM NetflixTitlesCast;


-- DimCategory
CREATE TABLE DimCategory(
	ShowId NVARCHAR(20) NOT NULL,
    ListedIn NVARCHAR(100) NOT NULL    
	CONSTRAINT pk_dim_category PRIMARY KEY (ShowId, ListedIn)
);
INSERT INTO DimCategory
SELECT DISTINCT
	ShowId, ListedIn
FROM NetflixTitlesCategory;
