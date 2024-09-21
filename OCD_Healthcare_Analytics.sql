CREATE DATABASE ocd_health_data;
USE ocd_health_data;

-- Q1. Count & Pct of F vs M that have OCD & -- Average Obsession Score by Gender
WITH data AS (
SELECT Gender,
COUNT(`Patient ID`) as patient_count,
ROUND(AVG(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score

FROM ocd_Patient_dataset
GROUP BY 1
ORDER BY 2
)
SELECT 
	SUM(CASE WHEN Gender = 'Female' THEN patient_count ELSE 0 END) AS count_female,
	sum(CASE WHEN Gender = 'Male' THEN patient_count ELSE 0 END) AS count_male,

	ROUND(SUM(CASE WHEN Gender = 'Female' THEN patient_count ELSE 0 END)/
	(SUM(CASE WHEN Gender = 'Female' THEN patient_count ELSE 0 END)+SUM(CASE WHEN Gender = 'Male' THEN patient_count ELSE 0 END)) *100,2)
	 AS pct_female,

    ROUND(SUM(CASE WHEN Gender = 'Male' THEN patient_count ELSE 0 END)/
	(SUM(CASE WHEN Gender = 'Female' THEN patient_count ELSE 0 END)+SUM(CASE WHEN Gender = 'Male' THEN patient_count ELSE 0 END)) *100,2)
	 AS pct_male

FROM data
;

-- Q2. Count of Patients by Ethnicity and their respective Average Obsession Score
SELECT
	Ethnicity,
	COUNT(`Patient ID`) AS patient_count,
	AVG(`Y-BOCS Score (Obsessions)`) AS obs_score
From ocd_patient_dataset
GROUP BY 1
ORDER BY 2;

-- Q3: Number of people diagnosed with OCD MoM
ALTER TABLE ocd_patient_dataset
MODIFY `OCD Diagnosis Date` date;

SELECT
date_format(`OCD Diagnosis Date`, '%Y-%m-01 00:00:00') as month,
-- `OCD Diagnosis Date`
COUNT(`Patient ID`) patient_count
FROM ocd_patient_dataset
GROUP BY 1
ORDER BY 1
;

-- Q4: What is the most common Obsession Type (Count) & it's respective Average Obsession Score
SELECT
`Obsession Type`,
COUNT(`Patient ID`) AS patient_count,
ROUND(AVG(`Y-BOCS Score (Obsessions)`),2) AS obs_score
FROM ocd_patient_dataset
GROUP BY 1
ORDER BY 2
;

-- Q5: 5. What is the most common Compulsion type (Count) & it's respective Average Obsession Score
SELECT
`Compulsion Type`,
COUNT(`Patient ID`) as patient_count,
ROUND(AVG(`Y-BOCS Score (Obsessions)`),2) AS obs_score
FROM ocd_patient_dataset
GROUP BY 1
ORDER BY 2
;









