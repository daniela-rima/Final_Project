USE inspections;

SELECT * FROM inspections;

-- Number of Inspections
SELECT COUNT(*) AS num_inspections
FROM inspections;
-- Total 210560 or Number of Rows 
-- Not necessarily accurate because there could be multiple violation codes from the same inspection

-- Average Inspection Scores
SELECT ROUND(AVG(score),2) AS avg_inspection_score
FROM inspections;
-- Average Score: 20.89

-- Average Score by Borough and Cuisine Category
SELECT borough, cuisine_description, ROUND(AVG(score),2) AS avg_inspection_score
FROM inspections
GROUP BY borough, cuisine_description
ORDER BY avg_inspection_score;
-- Lowest score Vegan/Vegetarian in Staten Island 
-- Highest score Southeast Asian in Bronx

-- Number of Violations by Violation Category
SELECT violation_category, COUNT(*) AS num_violations
FROM inspections
GROUP BY violation_category
ORDER BY num_violations DESC;

-- Average Inspection Score per Year
SELECT inspection_year, ROUND(AVG(score),2) AS avg_inspection_score 
FROM inspections 
GROUP BY inspection_year 
ORDER BY inspection_year;
-- Scores seem to have gotten higher but the number of inspections increased significantly

-- Number of Violations by Year and by Violation Code
SELECT inspection_year, violation_code, COUNT(violation_code) as num_violations 
FROM inspections 
GROUP BY inspection_year, violation_code 
ORDER BY inspection_year, violation_code;

-- Number of Violations by Cuisine Type, Violation Code and Violation Category
SELECT cuisine_description, violation_code, violation_category, COUNT(violation_code) as num_violations 
FROM inspections 
GROUP BY cuisine_description, violation_code, violation_category 
ORDER BY num_violations DESC;
-- LIMIT 20;

-- Number of Violations by Year and by Violation Code and Category
SELECT inspection_year, violation_code, violation_category, COUNT(violation_code) as num_violations 
FROM inspections 
GROUP BY inspection_year, violation_code, violation_category 
ORDER BY num_violations DESC;
-- LIMIT 20;

-- Same Output as before but different order
SELECT inspection_year, violation_code, violation_category, COUNT(violation_code) as num_violations 
FROM inspections 
GROUP BY inspection_year, violation_code, violation_category 
ORDER BY inspection_year, num_violations DESC;

-- Average Score by Grade, Violation Category and Code
SELECT grade, violation_category, violation_code, ROUND(AVG(score),2) AS average_score 
FROM inspections 
GROUP BY grade, violation_category, violation_code 
ORDER BY grade, violation_category, violation_code, average_score;

-- Violation Code Count
SELECT violation_code, COUNT(violation_code) as code_count 
FROM inspections 
GROUP BY violation_code 
ORDER BY code_count DESC;

-- Number of Violation Codes by Category and Critical Flag
-- NOTE! Code 09A has both critical and not critical flag!!
SELECT critical_flag, violation_code, violation_category, COUNT(violation_code) as code_count
FROM inspections 
GROUP BY critical_flag, violation_code, violation_category
ORDER BY violation_code, violation_category;

-- Average Score and Code Count by Critical Flag and Violation Category
SELECT violation_code, COUNT(violation_code) as code_count, critical_flag, violation_category, ROUND(AVG(score),2) AS average_score 
FROM inspections 
GROUP BY violation_code, critical_flag, violation_category
ORDER BY violation_code, average_score;

-- Average Score and Code Count by Critical Flag and Violation Category/Description   
SELECT 
    COUNT(i.violation_code) AS code_count,
    i.violation_code,
    i.violation_category,
    ir.violation_description,
    i.critical_flag,
    ROUND(AVG(i.score), 2) AS average_score 
FROM inspections AS i
JOIN inspections_raw AS ir ON i.violation_code = ir.violation_code
                          AND i.establishment_name = ir.establishment_name
GROUP BY 
    i.violation_code,
    i.violation_category,
    ir.violation_description,
    i.critical_flag
ORDER BY code_count DESC;

-- ANALYSIS OF inspections_raw DATASET

SELECT COUNT(DISTINCT establishment_id) AS num_establishments
FROM inspections_raw;
-- There are 26,263 unique ids ONLY 
-- Why? There could be establishments with multiple violation codes, multiple inspections from different years, etc.

-- CONFIMATION! Reasons for the repeated ids: 
-- Each violation code creates a new column (from the same inspection)
-- Same establishment has inspections from different years
SELECT *
FROM inspections_raw
WHERE establishment_id IN (
    SELECT establishment_id
    FROM inspections_raw
    GROUP BY establishment_id
    HAVING COUNT(establishment_id) > 10)
ORDER BY establishment_id, establishment_name;

-- Number of IDs for each Establishment Name
-- Some establishments have different variations of names (Ex. DUNIKIN vs. DUNKIN' vs. 'DUNKIN'','' BASKIN ROBBINS')
SELECT establishment_name, COUNT(DISTINCT establishment_id) as unique_id
FROM inspections_raw
GROUP BY establishment_name
ORDER BY unique_id DESC
LIMIT 10;

-- Correlation between the Average Score and Number of Violation in an Inspection
DROP TABLE IF EXISTS violation_analysis;

CREATE TABLE violation_analysis (
    establishment_id INT,
    establishment_name VARCHAR(255),
    inspection_date DATE,
    average_score INT,
    num_violations INT);

INSERT INTO violation_analysis (establishment_id, establishment_name, inspection_date, average_score, num_violations)    
SELECT establishment_id, establishment_name, inspection_date, ROUND(AVG(score),2) AS average_score, COUNT(violation_code) AS num_violations
FROM inspections_raw
GROUP BY establishment_name, establishment_id,  inspection_date
ORDER BY establishment_id DESC;

SELECT * 
FROM violation_analysis;

RENAME TABLE violation_analysis TO establishment_analysis;

-- Join inspectiosn and inspections raw tables
USE inspections;

DROP TABLE IF EXISTS violation_cat_establishment;

CREATE TABLE violation_cat_establishment (
	establishment_id INT,
    establishment_name VARCHAR(255),
    violation_category VARCHAR(255),
    violation_code VARCHAR(255),
    violation_description VARCHAR(3000),
    score INT);
    
INSERT INTO violation_cat_establishment (establishment_id, establishment_name, violation_category, violation_code, violation_description, score)
SELECT ir.establishment_id, i.establishment_name, i.violation_category, i.violation_code, ir.violation_description, i.score
FROM inspections i
JOIN inspections_raw ir
ON i.establishment_name = ir.establishment_name
AND i.longitude = ir.longitude
AND i.latitude = ir.latitude
AND i.violation_code = ir.violation_code
AND i.borough = ir.borough
AND i.score = ir.score
AND i.inspection_year = ir.inspection_year
AND i.cuisine_description = ir.cuisine_description;

SELECT *
FROM violation_cat_establishment;