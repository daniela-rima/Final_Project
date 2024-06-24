USE inspections;

SELECT * FROM inspections.inspections;

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


SELECT violation_category, COUNT(*) AS num_violations
FROM inspections
GROUP BY violation_category
ORDER BY num_violations DESC
LIMIT 10;

SELECT inspection_year, ROUND(AVG(score),2) AS avg_inspection_score 
FROM inspections 
GROUP BY inspection_year 
ORDER BY inspection_year;

SELECT inspection_year, violation_code, COUNT(violation_code) as num_violations 
FROM inspections 
GROUP BY inspection_year, violation_code 
ORDER BY inspection_year, violation_code;

SELECT cuisine_description, violation_code, violation_category, COUNT(violation_code) as num_violations 
FROM inspections 
GROUP BY cuisine_description, violation_code, violation_category 
ORDER BY num_violations DESC 
LIMIT 20;

SELECT cuisine_description, violation_code, violation_category, COUNT(violation_code) as num_violations 
FROM inspections 
GROUP BY cuisine_description, violation_code, violation_category 
ORDER BY num_violations;

SELECT inspection_year, violation_code, violation_category, COUNT(violation_code) as num_violations 
FROM inspections 
GROUP BY inspection_year, violation_code, violation_category 
ORDER BY num_violations DESC 
LIMIT 20;

SELECT inspection_year, violation_code, violation_category, COUNT(violation_code) as num_violations 
FROM inspections 
GROUP BY inspection_year, violation_code, violation_category 
ORDER BY inspection_year, num_violations DESC;

SELECT grade, violation_category, ROUND(AVG(score),2) AS average_score 
FROM inspections 
GROUP BY grade, violation_category 
ORDER BY grade;

SELECT grade, violation_category, violation_code, ROUND(AVG(score),2) AS average_score 
FROM inspections 
GROUP BY grade, violation_category, violation_code 
ORDER BY grade, violation_category, average_score;

SELECT violation_code, COUNT(violation_code) as code_count 
FROM inspections 
GROUP BY violation_code 
ORDER BY code_count ASC;

SELECT violation_code, COUNT(violation_code) as code_count, critical_flag, violation_category 
FROM inspections 
GROUP BY violation_code, critical_flag, violation_category 
ORDER BY violation_code;

SELECT violation_code, COUNT(violation_code) as code_count, critical_flag, violation_category, score 
FROM inspections 
GROUP BY violation_code, critical_flag, violation_category, score 
ORDER BY violation_code, score;