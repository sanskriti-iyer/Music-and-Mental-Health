-- create a new database
CREATE DATABASE mmh;

-- select database
USE mmh;

-- incase of an error with table format 
DROP TABLE music_therapy_data;

-- create table
CREATE TABLE music_therapy_data (
UniqueID int,
Age int,
Primary_streaming_service VARCHAR(100),
Hours_per_day VARCHAR(20),
While_working BOOLEAN,
Instrumentalist BOOLEAN,
Composer BOOLEAN,
Fav_genre VARCHAR(20),
Exploratory BOOLEAN,
Foreign_languages BOOLEAN,
BPM int,
Frequency_Classical VARCHAR(20),
Frequency_Country VARCHAR(20),
Frequency_EDM VARCHAR(20),
Frequency_Folk VARCHAR(20),
Frequency_Gospel VARCHAR(20),
Frequency_Hip_hop VARCHAR(20),
Frequency_Jazz VARCHAR(20),
Frequency_Kpop VARCHAR(20),
Frequency_Latin VARCHAR(20),
Frequency_Lofi VARCHAR(20),
Frequency_Metal VARCHAR(20),
Frequency_Pop VARCHAR(20),
Frequency_RnB VARCHAR(20),
Frwquency_Rap VARCHAR(20),
Frequency_Rock VARCHAR(20),
Frequency_Video_gamme_music VARCHAR(20),
Anxiety int,
Depression int,
Insomnia int,
OCD int,
Music_effects VARCHAR(20),
Permissions VARCHAR(20)
);

-- dealing with potential empty spaces in every column
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/mxmh_survey_results.csv'
INTO TABLE music_therapy_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    @UniqueID,
    @Age,
    @Primary_streaming_service,
    @Hours_per_day,
    @While_working,
    @Instrumentalist,
    @Composer,
    @Fav_genre,
    @Exploratory,
    @Foreign_languages,
    @BPM,
    @Frequency_Classical,
    @Frequency_Country,
    @Frequency_EDM,
    @Frequency_Folk,
    @Frequency_Gospel,
    @Frequency_Hip_hop,
    @Frequency_Jazz,
    @Frequency_Kpop,
    @Frequency_Latin,
    @Frequency_Lofi,
    @Frequency_Metal,
    @Frequency_Pop,
    @Frequency_RnB,
    @Frwquency_Rap,
    @Frequency_Rock,
    @Frequency_Video_gamme_music,
    @Anxiety,
    @Depression,
    @Insomnia,
    @OCD,
    @Music_effects,
    @Permissions
)
SET
    UniqueID = NULLIF(@UniqueID, ''),
    Age = NULLIF(@Age, ''),
    Primary_streaming_service = NULLIF(@Primary_streaming_service, ''),
    Hours_per_day = NULLIF(@Hours_per_day, ''),
    While_working = NULLIF(@While_working, ''),
    Instrumentalist = NULLIF(@Instrumentalist, ''),
    Composer = NULLIF(@Composer, ''),
    Fav_genre = NULLIF(@Fav_genre, ''),
    Exploratory = NULLIF(@Exploratory, ''),
    Foreign_languages = NULLIF(@Foreign_languages, ''),
    BPM = NULLIF(@BPM, ''),
    Frequency_Classical = NULLIF(@Frequency_Classical, ''),
    Frequency_Country = NULLIF(@Frequency_Country, ''),
    Frequency_EDM = NULLIF(@Frequency_EDM, ''),
    Frequency_Folk = NULLIF(@Frequency_Folk, ''),
    Frequency_Gospel = NULLIF(@Frequency_Gospel, ''),
    Frequency_Hip_hop = NULLIF(@Frequency_Hip_hop, ''),
    Frequency_Jazz = NULLIF(@Frequency_Jazz, ''),
    Frequency_Kpop = NULLIF(@Frequency_Kpop, ''),
    Frequency_Latin = NULLIF(@Frequency_Latin, ''),
    Frequency_Lofi = NULLIF(@Frequency_Lofi, ''),
    Frequency_Metal = NULLIF(@Frequency_Metal, ''),
    Frequency_Pop = NULLIF(@Frequency_Pop, ''),
    Frequency_RnB = NULLIF(@Frequency_RnB, ''),
    Frwquency_Rap = NULLIF(@Frwquency_Rap, ''),
    Frequency_Rock = NULLIF(@Frequency_Rock, ''),
    Frequency_Video_gamme_music = NULLIF(@Frequency_Video_gamme_music, ''),
    Anxiety = NULLIF(@Anxiety, ''),
    Depression = NULLIF(@Depression, ''),
    Insomnia = NULLIF(@Insomnia, ''),
    OCD = NULLIF(@OCD, ''),
    Music_effects = NULLIF(@Music_effects, ''),
    Permissions = NULLIF(@Permissions, '');
    
-- Descriptive Analysis
-- 1. Number of records
SELECT COUNT(*) AS total_responses FROM music_therapy_data;
    
-- 2. Age Statistics
SELECT 
  AVG(Age) AS avg_age,
  MIN(Age) AS youngest,
  MAX(Age) AS oldest
FROM music_therapy_data;

-- 3. Most common streaming platforms
SELECT 
  Primary_streaming_service, 
  COUNT(*) AS users
FROM music_therapy_data
GROUP BY Primary_streaming_service
ORDER BY users DESC;

-- 4. Avergae hour of music per day
SELECT 
  AVG(CAST(Hours_per_day AS DECIMAL(4,2))) AS avg_hours_per_day
FROM music_therapy_data;

-- 5. Boolean Counts
SELECT
  SUM(While_working = 1) AS while_working_yes,
  SUM(While_working = 0) AS while_working_no,
  
  SUM(Instrumentalist = 1) AS instrumentalist_yes,
  SUM(Instrumentalist = 0) AS instrumentalist_no,

  SUM(Composer = 1) AS composer_yes,
  SUM(Composer = 0) AS composer_no,

  SUM(Exploratory = 1) AS exploratory_yes,
  SUM(Exploratory = 0) AS exploratory_no,

  SUM(Foreign_languages = 1) AS foreign_languages_yes,
  SUM(Foreign_languages = 0) AS foreign_languages_no
FROM music_therapy_data;

-- 6. Average of all disorders
SELECT 
  AVG(Anxiety) AS avg_anxiety,
  AVG(Depression) AS avg_depression,
  AVG(Insomnia) AS avg_insomnia,
  AVG(OCD) AS avg_ocd
FROM music_therapy_data;

-- Comprative Analysis
-- 1. avg mental scores as per streaming service
SELECT 
    Primary_streaming_service,
    AVG(Anxiety) AS Avg_Anxiety,
    AVG(Depression) AS Avg_Depression,
    AVG(Insomnia) AS Avg_Insomnia,
    AVG(OCD) AS Avg_OCD
FROM music_therapy_data
GROUP BY Primary_streaming_service;

-- 2. Compare mental health by favorite genre
SELECT 
    Fav_genre,
    AVG(Anxiety) AS Avg_Anxiety,
    AVG(Depression) AS Avg_Depression,
    AVG(Insomnia) AS Avg_Insomnia,
    AVG(OCD) AS Avg_OCD
FROM music_therapy_data
GROUP BY Fav_genre
ORDER BY Avg_Anxiety DESC;

-- 3. Music effect on mental health
SELECT 
    Music_effects,
    COUNT(*) AS Count,
    AVG(Anxiety) AS Avg_Anxiety,
    AVG(Depression) AS Avg_Depression,
    AVG(Insomnia) AS Avg_Insomnia,
    AVG(OCD) AS Avg_OCD
FROM music_therapy_data
GROUP BY Music_effects;

-- 4. Mental health vs BPM
SELECT
  CASE
    WHEN BPM BETWEEN 0 AND 79 THEN '0–79'
    WHEN BPM BETWEEN 80 AND 99 THEN '80–99'
    WHEN BPM BETWEEN 100 AND 119 THEN '100–119'
    WHEN BPM BETWEEN 120 AND 139 THEN '120–139'
    WHEN BPM BETWEEN 140 AND 159 THEN '140–159'
    WHEN BPM BETWEEN 160 AND 179 THEN '160–179'
    WHEN BPM >= 180 THEN '180+'
    ELSE 'Unknown'
  END AS BPM_Range,
  COUNT(*) AS Count,
  AVG(Anxiety) AS Avg_Anxiety,
  AVG(Depression) AS Avg_Depression,
  AVG(OCD) AS Avg_OCD,
  AVG(Insomnia) AS Avg_Insomnia
FROM music_therapy_data
WHERE BPM IS NOT NULL AND BPM < 500 -- exclude outliers like 999999999
GROUP BY BPM_Range
ORDER BY FIELD(BPM_Range, '0–79', '80–99', '100–119', '120–139', '140–159', '160–179', '180+');

-- 5. mental health scores vs instrumentalist
SELECT 
    Instrumentalist,
    COUNT(*) AS Respondents,
    ROUND(AVG(Anxiety), 2) AS Avg_Anxiety,
    ROUND(AVG(Depression), 2) AS Avg_Depression,
    ROUND(AVG(Insomnia), 2) AS Avg_Insomnia,
    ROUND(AVG(OCD), 2) AS Avg_OCD
FROM music_therapy_data
GROUP BY Instrumentalist;

-- 6. Average hours per day vs mental health
SELECT 
    CASE 
        WHEN Hours_per_day < 1 THEN '<1 hour'
        WHEN Hours_per_day BETWEEN 1 AND 3 THEN '1-3 hours'
        WHEN Hours_per_day BETWEEN 4 AND 6 THEN '4-6 hours'
        ELSE '>6 hours'
    END AS Listening_Hours_Group,
    COUNT(*) AS Respondents,
    ROUND(AVG(Anxiety), 2) AS Avg_Anxiety,
    ROUND(AVG(Depression), 2) AS Avg_Depression,
    ROUND(AVG(Insomnia), 2) AS Avg_Insomnia,
    ROUND(AVG(OCD), 2) AS Avg_OCD
FROM music_therapy_data
GROUP BY Listening_Hours_Group
ORDER BY Listening_Hours_Group;

-- 7. Top 3 Genres by Average Anxiety
SELECT 'Anxiety' AS Disorder, genre, AVG_score
FROM (
    SELECT 'Classical' AS genre, AVG(Anxiety) AS AVG_score FROM music_therapy_data WHERE Frequency_Classical != 'Never'
    UNION ALL SELECT 'Country', AVG(Anxiety) FROM music_therapy_data WHERE Frequency_Country != 'Never'
    UNION ALL SELECT 'EDM', AVG(Anxiety) FROM music_therapy_data WHERE Frequency_EDM != 'Never'
    UNION ALL SELECT 'Folk', AVG(Anxiety) FROM music_therapy_data WHERE Frequency_Folk != 'Never'
    UNION ALL SELECT 'Gospel', AVG(Anxiety) FROM music_therapy_data WHERE Frequency_Gospel != 'Never'
    UNION ALL SELECT 'Hip_hop', AVG(Anxiety) FROM music_therapy_data WHERE Frequency_Hip_hop != 'Never'
    UNION ALL SELECT 'Jazz', AVG(Anxiety) FROM music_therapy_data WHERE Frequency_Jazz != 'Never'
    UNION ALL SELECT 'Kpop', AVG(Anxiety) FROM music_therapy_data WHERE Frequency_Kpop != 'Never'
    UNION ALL SELECT 'Latin', AVG(Anxiety) FROM music_therapy_data WHERE Frequency_Latin != 'Never'
    UNION ALL SELECT 'Lofi', AVG(Anxiety) FROM music_therapy_data WHERE Frequency_Lofi != 'Never'
    UNION ALL SELECT 'Metal', AVG(Anxiety) FROM music_therapy_data WHERE Frequency_Metal != 'Never'
    UNION ALL SELECT 'Pop', AVG(Anxiety) FROM music_therapy_data WHERE Frequency_Pop != 'Never'
    UNION ALL SELECT 'RnB', AVG(Anxiety) FROM music_therapy_data WHERE Frequency_RnB != 'Never'
    UNION ALL SELECT 'Rap', AVG(Anxiety) FROM music_therapy_data WHERE Frwquency_Rap != 'Never'
    UNION ALL SELECT 'Rock', AVG(Anxiety) FROM music_therapy_data WHERE Frequency_Rock != 'Never'
    UNION ALL SELECT 'Video_game_music', AVG(Anxiety) FROM music_therapy_data WHERE Frequency_Video_gamme_music != 'Never'
) AS genre_scores
ORDER BY AVG_score DESC
LIMIT 3;

-- 8. Top 3 Genres by Average Depression
SELECT 'Depression' AS Disorder, genre, AVG_score
FROM (
    SELECT 'Classical' AS genre, AVG(Depression) AS AVG_score FROM music_therapy_data WHERE Frequency_Classical != 'Never'
    UNION ALL SELECT 'Country', AVG(Depression) FROM music_therapy_data WHERE Frequency_Country != 'Never'
    UNION ALL SELECT 'EDM', AVG(Depression) FROM music_therapy_data WHERE Frequency_EDM != 'Never'
    UNION ALL SELECT 'Folk', AVG(Depression) FROM music_therapy_data WHERE Frequency_Folk != 'Never'
    UNION ALL SELECT 'Gospel', AVG(Depression) FROM music_therapy_data WHERE Frequency_Gospel != 'Never'
    UNION ALL SELECT 'Hip_hop', AVG(Depression) FROM music_therapy_data WHERE Frequency_Hip_hop != 'Never'
    UNION ALL SELECT 'Jazz', AVG(Depression) FROM music_therapy_data WHERE Frequency_Jazz != 'Never'
    UNION ALL SELECT 'Kpop', AVG(Depression) FROM music_therapy_data WHERE Frequency_Kpop != 'Never'
    UNION ALL SELECT 'Latin', AVG(Depression) FROM music_therapy_data WHERE Frequency_Latin != 'Never'
    UNION ALL SELECT 'Lofi', AVG(Depression) FROM music_therapy_data WHERE Frequency_Lofi != 'Never'
    UNION ALL SELECT 'Metal', AVG(Depression) FROM music_therapy_data WHERE Frequency_Metal != 'Never'
    UNION ALL SELECT 'Pop', AVG(Depression) FROM music_therapy_data WHERE Frequency_Pop != 'Never'
    UNION ALL SELECT 'RnB', AVG(Depression) FROM music_therapy_data WHERE Frequency_RnB != 'Never'
    UNION ALL SELECT 'Rap', AVG(Depression) FROM music_therapy_data WHERE Frwquency_Rap != 'Never'
    UNION ALL SELECT 'Rock', AVG(Depression) FROM music_therapy_data WHERE Frequency_Rock != 'Never'
    UNION ALL SELECT 'Video_game_music', AVG(Depression) FROM music_therapy_data WHERE Frequency_Video_gamme_music != 'Never'
) AS genre_scores
ORDER BY AVG_score DESC
LIMIT 3;

-- 9. Top 3 Genres by Average OCD
SELECT 'OCD' AS Disorder, genre, AVG_score
FROM (
    SELECT 'Classical' AS genre, AVG(OCD) AS AVG_score FROM music_therapy_data WHERE Frequency_Classical != 'Never'
    UNION ALL SELECT 'Country', AVG(OCD) FROM music_therapy_data WHERE Frequency_Country != 'Never'
    UNION ALL SELECT 'EDM', AVG(OCD) FROM music_therapy_data WHERE Frequency_EDM != 'Never'
    UNION ALL SELECT 'Folk', AVG(OCD) FROM music_therapy_data WHERE Frequency_Folk != 'Never'
    UNION ALL SELECT 'Gospel', AVG(OCD) FROM music_therapy_data WHERE Frequency_Gospel != 'Never'
    UNION ALL SELECT 'Hip_hop', AVG(OCD) FROM music_therapy_data WHERE Frequency_Hip_hop != 'Never'
    UNION ALL SELECT 'Jazz', AVG(OCD) FROM music_therapy_data WHERE Frequency_Jazz != 'Never'
    UNION ALL SELECT 'Kpop', AVG(OCD) FROM music_therapy_data WHERE Frequency_Kpop != 'Never'
    UNION ALL SELECT 'Latin', AVG(OCD) FROM music_therapy_data WHERE Frequency_Latin != 'Never'
    UNION ALL SELECT 'Lofi', AVG(OCD) FROM music_therapy_data WHERE Frequency_Lofi != 'Never'
    UNION ALL SELECT 'Metal', AVG(OCD) FROM music_therapy_data WHERE Frequency_Metal != 'Never'
    UNION ALL SELECT 'Pop', AVG(OCD) FROM music_therapy_data WHERE Frequency_Pop != 'Never'
    UNION ALL SELECT 'RnB', AVG(OCD) FROM music_therapy_data WHERE Frequency_RnB != 'Never'
    UNION ALL SELECT 'Rap', AVG(OCD) FROM music_therapy_data WHERE Frwquency_Rap != 'Never'
    UNION ALL SELECT 'Rock', AVG(OCD) FROM music_therapy_data WHERE Frequency_Rock != 'Never'
    UNION ALL SELECT 'Video_game_music', AVG(OCD) FROM music_therapy_data WHERE Frequency_Video_gamme_music != 'Never'
) AS genre_scores
ORDER BY AVG_score DESC
LIMIT 3;

-- 10. Top 3 Genres by Average Insomnia
SELECT 'Insomnia' AS Disorder, genre, AVG_score
FROM (
    SELECT 'Classical' AS genre, AVG(Insomnia) AS AVG_score FROM music_therapy_data WHERE Frequency_Classical != 'Never'
    UNION ALL SELECT 'Country', AVG(Insomnia) FROM music_therapy_data WHERE Frequency_Country != 'Never'
    UNION ALL SELECT 'EDM', AVG(Insomnia) FROM music_therapy_data WHERE Frequency_EDM != 'Never'
    UNION ALL SELECT 'Folk', AVG(Insomnia) FROM music_therapy_data WHERE Frequency_Folk != 'Never'
    UNION ALL SELECT 'Gospel', AVG(Insomnia) FROM music_therapy_data WHERE Frequency_Gospel != 'Never'
    UNION ALL SELECT 'Hip_hop', AVG(Insomnia) FROM music_therapy_data WHERE Frequency_Hip_hop != 'Never'
    UNION ALL SELECT 'Jazz', AVG(Insomnia) FROM music_therapy_data WHERE Frequency_Jazz != 'Never'
    UNION ALL SELECT 'Kpop', AVG(Insomnia) FROM music_therapy_data WHERE Frequency_Kpop != 'Never'
    UNION ALL SELECT 'Latin', AVG(Insomnia) FROM music_therapy_data WHERE Frequency_Latin != 'Never'
    UNION ALL SELECT 'Lofi', AVG(Insomnia) FROM music_therapy_data WHERE Frequency_Lofi != 'Never'
    UNION ALL SELECT 'Metal', AVG(Insomnia) FROM music_therapy_data WHERE Frequency_Metal != 'Never'
    UNION ALL SELECT 'Pop', AVG(Insomnia) FROM music_therapy_data WHERE Frequency_Pop != 'Never'
    UNION ALL SELECT 'RnB', AVG(Insomnia) FROM music_therapy_data WHERE Frequency_RnB != 'Never'
    UNION ALL SELECT 'Rap', AVG(Insomnia) FROM music_therapy_data WHERE Frwquency_Rap != 'Never'
    UNION ALL SELECT 'Rock', AVG(Insomnia) FROM music_therapy_data WHERE Frequency_Rock != 'Never'
    UNION ALL SELECT 'Video_game_music', AVG(Insomnia) FROM music_therapy_data WHERE Frequency_Video_gamme_music != 'Never'
) AS genre_scores
ORDER BY AVG_score DESC
LIMIT 3;

-- 11. Age vs Mental Scores
SELECT
  CASE
    WHEN Age BETWEEN 0 AND 17 THEN '0-17'
    WHEN Age BETWEEN 18 AND 24 THEN '18-24'
    WHEN Age BETWEEN 25 AND 34 THEN '25-34'
    WHEN Age BETWEEN 35 AND 44 THEN '35-44'
    WHEN Age BETWEEN 45 AND 54 THEN '45-54'
    WHEN Age BETWEEN 55 AND 64 THEN '55-64'
    WHEN Age >= 65 THEN '65+'
    ELSE 'Unknown'
  END AS Age_Range,
  COUNT(*) AS Count,
  ROUND(AVG(Anxiety), 2) AS Avg_Anxiety,
  ROUND(AVG(Depression), 2) AS Avg_Depression,
  ROUND(AVG(OCD), 2) AS Avg_OCD,
  ROUND(AVG(Insomnia), 2) AS Avg_Insomnia
FROM music_therapy_data
WHERE Age IS NOT NULL
GROUP BY Age_Range
ORDER BY Age_Range;