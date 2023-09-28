{\rtf1\ansi\ansicpg1252\cocoartf2638
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;\f1\fswiss\fcharset0 ArialMT;\f2\froman\fcharset0 TimesNewRomanPSMT;
}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;\red82\green99\blue113;\red254\green251\blue254;
}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;\cssrgb\c39216\c46275\c51765;\cssrgb\c99608\c98824\c99608;
}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs32 \cf2 \expnd0\expndtw0\kerning0
--
\f1\fs36 \cf3 \cb4  Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)
\f0\fs32 \cf2 \cb1 \
\'a0\
SELECT\
\'a0 patient_id,\
\'a0 first_name,\
\'a0 last_name\
FROM patients P\
WHERE patient_id NOT IN(\
\'a0\'a0\'a0 SELECT patient_id\
\'a0\'a0\'a0 FROM admissions\
\'a0 )\
\'a0\
\'a0\
--
\f1\fs36 \cf3 \cb4  Display patient's full name,\cb1 \uc0\u8232 \cb4 height in the units feet rounded to 1 decimal,\cb1 \uc0\u8232 \cb4 weight in the unit pounds rounded to 0 decimals,\cb1 \uc0\u8232 \cb4 birth_date,\cb1 \uc0\u8232 \cb4 gender non abbreviated.\cb1 \uc0\u8232 \u8232 \cb4 Convert CM to feet by dividing by 30.48.\cb1 \uc0\u8232 \cb4 Convert KG to pounds by multiplying by 2.205.
\f0\fs32 \cf2 \cb1 \
\'a0\
SELECT\
\'a0 CONCAT(first_name, ' ', last_name) AS full_name,\
\'a0 ROUND(height / 30.48, 1) AS height_f,\
\'a0 ROUND(weight * 2.205, 0) as wiehgt_p,\
\'a0 birth_Date,\
\'a0 CASE\
\'a0\'a0\'a0 WHEN gender = 'F' THEN 'Female'\
\'a0\'a0\'a0 ELSE 'Male'\
\'a0 END AS 'gender_type'\
FROM patients\
\'a0\
-- 
\f1\fs36 \cf3 \cb4 display the number of duplicate patients based on their first_name and last_name.
\f0\fs32 \cf2 \cb1 \

\f1\fs36 \cf3 \cb4 \'a0
\f0\fs32 \cf2 \cb1 \
\pard\pardeftab720\partightenfactor0

\f2 \cf2 SELECT first_name, last_name,number
\f0 \

\f2 FROM patients P
\f0 \

\f2 JOIN(SELECT
\f0 \

\f2 \'a0 patient_id, CONCAT(first_name,' ', last_name) AS full_name,COUNT(*) AS number
\f0 \

\f2 FROM patients
\f0 \

\f2 GROUP BY full_name
\f0 \

\f2 HAVING number >1) AS S
\f0 \

\f2 ON S.patient_id = P.patient_id
\f0 \

\f2 \'a0
\f0 \

\f2 select
\f0 \

\f2 \'a0 first_name,
\f0 \

\f2 \'a0 last_name,
\f0 \

\f2 \'a0 count(*) as num_of_duplicates
\f0 \

\f2 from patients
\f0 \

\f2 group by
\f0 \

\f2 \'a0 first_name,
\f0 \

\f2 \'a0 last_name
\f0 \

\f2 having count(*) > 1
\f0 \

\f2 \'a0
\f0 \

\f2 --
\f1\fs36 \cf3 \cb4  For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
\f0\fs32 \cf2 \cb1 \

\f2 \'a0
\f0 \

\f2 SELECT
\f0 \

\f2 \'a0 CONCAT(P.first_name,' ', P.last_name) AS p_full_name,
\f0 \

\f2 \'a0 CONCAT(D.first_name,' ', D.last_name) AS d_full_name,
\f0 \

\f2 \'a0 A.diagnosis
\f0 \

\f2 FROM patients P
\f0 \

\f2 JOIN admissions A ON P.patient_id = A.patient_id
\f0 \

\f2 JOIN doctors D on D.doctor_id = A.attending_doctor_id
\f0 \

\f2 \'a0
\f0 \

\f2 --
\f1\fs36 \cf3 \cb4  Display the total amount of patients for each province. Order by descending.
\f0\fs32 \cf2 \cb1 \

\f2 \'a0
\f0 \

\f2 \'a0
\f0 \

\f2 SELECT
\f0 \

\f2 \'a0 PN.province_name,count(*) as total_amount
\f0 \

\f2 FROM patients P
\f0 \

\f2 JOIN province_names PN ON P.province_id = PN.province_id
\f0 \

\f2 GROUP BY PN.province_name
\f0 \

\f2 ORDER BY total_amount DESC
\f0 \
\'a0\
\'a0\
--
\f1\fs36 \cf3 \cb4  Display the total amount of patients for each province. Order by descending.
\f0\fs32 \cf2 \cb1 \
\'a0\
SELECT\
\'a0 D.doctor_id,\
\'a0 CONCAT(D.first_name,' ',D.last_name) AS full_name,\
\'a0 MIN(admission_date),\
\'a0 MAX(admission_date)\
FROM doctors D\
JOIN admissions A ON D.doctor_id = A.attending_doctor_id\
GROUP BY D.doctor_id\
\'a0\
-- 
\f1\fs36 \cf3 \cb4 Show first_name, last_name, and the total number of admissions attended for each doctor.\cb1 \uc0\u8232 \u8232 \cb4 Every admission has been attended by a doctor.
\f0\fs32 \cf2 \cb1 \
SELECT\
\'a0 D.first_name, \
\'a0 D.last_name,\
\'a0 COUNT(A.attending_doctor_id) AS total_number\
FROM doctors D\
JOIN admissions A ON D.doctor_id = A.attending_doctor_id\
GROUP BY D.doctor_id\
\'a0\
--
\f1\fs36 \cf3 \cb4  Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:\cb1 \uc0\u8232 \cb4 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.\cb1 \uc0\u8232 \cb4 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
\f0\fs32 \cf2 \cb1 \
\'a0\
SELECT\
\'a0 patient_id,\
\'a0 attending_doctor_id,\
\'a0 diagnosis\
FROM admissions\
WHERE\
\'a0 (\
\'a0\'a0 \'a0patient_id % 2 != 0\
\'a0\'a0\'a0 AND attending_doctor_id IN (1, 5, 19)\
\'a0 )\
\'a0 OR (\
\'a0\'a0\'a0 attending_doctor_id LIKE '%2%'\
\'a0\'a0\'a0 AND LEN(patient_id) = 3\
\'a0 )\
\'a0\
-- 
\f1\fs36 \cf3 \cb4 Show all columns for patient_id 542's most recent admission_date.
\f0\fs32 \cf2 \cb1 \

\f2 SELECT*
\f0 \

\f2 FROM admissions
\f0 \

\f2 WHERE patient_id = 542 
\f0 \

\f2 GROUP BY patient_id
\f0 \

\f2 HAVING 
\f0 \

\f2 \'a0admission_date = max(admission_date)
\f0 \

\f2 \'a0
\f0 \

\f2 --
\f1\fs36 \cf3 \cb4  Show all allergies ordered by popularity. Remove NULL values from query.
\f0\fs32 \cf2 \cb1 \

\f2 \'a0
\f0 \

\f2 SELECT
\f0 \

\f2 \'a0allergies, COUNT(*) AS popularity
\f0 \

\f2 FROM patients
\f0 \

\f2 WHERE allergies IS NOT NULL
\f0 \

\f2 GROUP BY allergies
\f0 \

\f2 ORDER BY popularity DESC
\f0 \
\'a0\
\'a0\
--\
\'a0\
--
\f1\fs36 Show patient_id, first_name, last_name, and attending doctor's specialty.\uc0\u8232 Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
\f0\fs32 \
\'a0\
SELECT\
\'a0 pat.patient_id,\
\'a0 pat.first_name,\
\'a0 pat.last_name\
FROM patients pat\
\'a0 JOIN admissions ad ON pat.patient_id = ad.patient_id\
\'a0 JOIN doctors doc ON doc.doctor_id = ad.attending_doctor_id\
WHERE\
\'a0 doc.first_name = 'Lisa'\
\'a0 AND ad.diagnosis = 'Epilepsy'\
\'a0\
\'a0\
--\'ad\'ad
\f1\fs36 \cf3 \cb4  All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.\cb1 \uc0\u8232 \u8232 \cb4 The password must be the following, in order:\cb1 \uc0\u8232 \cb4 1. patient_id\cb1 \uc0\u8232 \cb4 2. the numerical length of patient's last_name\cb1 \uc0\u8232 \cb4 3. year of patient's birth_date
\f0\fs32 \cf2 \cb1 \
\'a0\
\pard\pardeftab720\partightenfactor0

\f1\fs36 \cf3 \cb4 \'a0
\f0\fs32 \cf2 \cb1 \

\f1\fs36 \cf3 \cb4 -- Show how many patients have a birth_date with 2010 as the birth year.
\f0\fs32 \cf2 \cb1 \
SELECT COUNT(*) AS total_patients\
FROM patients\
WHERE YEAR(birth_date) = 2010;\
\'a0\
--
\f1\fs36 \cf3 \cb4  Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
\f0\fs32 \cf2 \cb1 \
\'a0\
SELECT\
DAY(admission_date) AS date,COUNT(*) AS admission_count\
FROM admissions\
GROUP BY date\
order by admission_count DESC\
\'a0\
--
\f1\fs36 \cf3 \cb4  Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
\f0\fs32 \cf2 \cb1 \
\'a0\
SELECT\
\'a0MAX(weight) - MIN(weight) AS difference\
FROM patients\
WHERE last_name = 'Maroni'\
\'a0\
--
\f1\fs36 \cf3 \cb4  Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
\f0\fs32 \cf2 \cb1 \
\'a0\
SELECT\
\'a0province_id,SUM(height) AS sum_hei\
FROM patients\
GROUP BY province_id\
HAVING sum_hei >= 7000\
\'a0\
--
\f1\fs36 \cf3 \cb4  Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:\cb1 \uc0\u8232 \cb4 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.\cb1 \uc0\u8232 \cb4 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
\f0\fs32 \cf2 \cb1 \
\pard\pardeftab720\partightenfactor0

\f2 \cf2 SELECT
\f0 \

\f2 \'a0 patient_id,
\f0 \

\f2 \'a0 attending_doctor_id,
\f0 \

\f2 \'a0 diagnosis
\f0 \

\f2 FROM admissions
\f0 \

\f2 WHERE
\f0 \

\f2 \'a0 (
\f0 \

\f2 \'a0\'a0\'a0 patient_id % 2 != 0
\f0 \

\f2 \'a0\'a0\'a0 AND attending_doctor_id IN (1, 5, 19)
\f0 \

\f2 \'a0 )
\f0 \

\f2 \'a0 OR (
\f0 \

\f2 \'a0\'a0\'a0 attending_doctor_id LIKE '%2%'
\f0 \

\f2 \'a0\'a0\'a0 AND LEN(patient_id) = 3
\f0 \

\f2 \'a0 )
\f0 \
\'a0\
-- 
\f1\fs36 \cf3 \cb4 We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order\cb1 \uc0\u8232 \cb4 EX: SMITH,jane
\f0\fs32 \cf2 \cb1 \
\'a0\
SELECT\
\'a0CONCAT(UPPER(last_name),',',LOWER(first_name)) AS full_name\
FROM patients\
ORDER BY first_name DESC\
\'a0\
--
\f1\fs36 \cf3 \cb4  We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.
\f0\fs32 \cf2 \cb1 \
\'a0\
SELECT\
\'a0 doctor_id,\
\'a0 CONCAT(first_name, ' ', last_name) AS doctor_full_name,\
\'a0 specialty,\
\'a0 year(admission_date) AS Select_year,\
\'a0 COUNT(*) AS total_admissions\
from doctors D\
\'a0 LEFT JOIN admissions A ON D.doctor_id = A.attending_doctor_id\
GROUP BY\
\'a0 doctor_id,\
\'a0\'a0Select_year\
\'a0\
--
\f1\fs36 \cf3 \cb4  Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.
\f0\fs32 \cf2 \cb1 \
\'a0\
select province_name\
from province_names\
order by\
\'a0 (case when province_name = 'Ontario' then 0 else 1 end),\
\'a0 province_name\
\'a0\
-- 
\f1\fs36 \cf3 \cb4 For each day display the total amount of admissions on that day. Display the amount changed from the previous date.
\f0\fs32 \cf2 \cb1 \
SELECT\
\'a0admission_date,\
\'a0count(admission_date) as admission_day,\
\'a0count(admission_date) - LAG(count(admission_date)) OVER(ORDER BY admission_date) AS admission_count_change \
FROM admissions\
\'a0group by admission_date\
\'a0\
--
\f1\fs36 \cf3 \cb4  Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.
\f0\fs32 \cf2 \cb1 \
\'a0\
SELECT CONCAT(\
\'a0\'a0\'a0 ROUND(\
\'a0\'a0\'a0\'a0\'a0 (\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 SELECT COUNT(*)\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 FROM patients\
\'a0\'a0\'a0\'a0\'a0\'a0\'a0 WHERE gender = 'M'\
\'a0\'a0\'a0\'a0\'a0 ) / CAST(COUNT(*) as float),\
\'a0\'a0\'a0\'a0\'a0 4\
\'a0\'a0\'a0 ) * 100,\
\'a0\'a0\'a0 '%'\
\'a0 ) as percent_of_male_patients\
FROM patients;\
\'a0\
--
\f1\fs36 \cf3 \cb4  We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:\cb1 \uc0\u8232 \cb4 - First_name contains an 'r' after the first two letters.\cb1 \uc0\u8232 \cb4 - Identifies their gender as 'F'\cb1 \uc0\u8232 \cb4 - Born in February, May, or December\cb1 \uc0\u8232 \cb4 - Their weight would be between 60kg and 80kg\cb1 \uc0\u8232 \cb4 - Their patient_id is an odd number\cb1 \uc0\u8232 \cb4 - They are from the city 'Kingston'
\f0\fs32 \cf2 \cb1 \
\'a0\
SELECT *\
FROM patients\
WHERE\
\'a0 first_name LIKE '__r%'\
\'a0 AND gender = 'F'\
\'a0 AND MONTH(birth_date) IN (2, 5, 12)\
\'a0 AND weight BETWEEN 60 AND 80\
\'a0 AND patient_id % 2 = 1\
\'a0 AND city = 'Kingston';\
\'a0\
--
\f1\fs36 \cf3 \cb4  Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name
\f0\fs32 \cf2 \cb1 \
\'a0\
SELECT pr.province_name\
FROM patients AS pa\
\'a0 JOIN province_names AS pr ON pa.province_id = pr.province_id\
GROUP BY pr.province_name\
HAVING\
\'a0 COUNT( CASE WHEN gender = 'M' THEN 1 END) > COUNT( CASE WHEN gender = 'F' THEN 1 END);\
\'a0\
--
\f1\fs36 \cf3 \cb4  Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.\cb1 \uc0\u8232 \u8232 \cb4 Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.
\f0\fs32 \cf2 \cb1 \
\'a0\
SELECT \
CASE WHEN patient_id % 2 = 0 Then \
\'a0\'a0\'a0 'Yes'\
ELSE \
\'a0\'a0\'a0 'No' \
END as has_insurance,\
SUM(CASE WHEN patient_id % 2 = 0 Then \
\'a0\'a0\'a0 10\
ELSE \
\'a0\'a0\'a0 50 \
END) as cost_after_insurance\
FROM admissions \
GROUP BY has_insurance;\
\'a0\
--
\f1\fs36 \cf3 \cb4  All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.\cb1 \uc0\u8232 \u8232 \cb4 The password must be the following, in order:\cb1 \uc0\u8232 \cb4 1. patient_id\cb1 \uc0\u8232 \cb4 2. the numerical length of patient's last_name\cb1 \uc0\u8232 \cb4 3. year of patient's birth_date
\f0\fs32 \cf2 \cb1 \
\'a0\
SELECT\
\'a0 DISTINCT P.patient_id,\
\'a0 CONCAT(\
\'a0\'a0\'a0 P.patient_id,\
\'a0\'a0\'a0 LEN(last_name),\
\'a0\'a0\'a0 YEAR(birth_date)\
\'a0 ) AS temp_password\
FROM patients P\
\'a0 JOIN admissions A ON A.patient_id = P.patient_id\
\'a0\
--
\f1\fs36 \cf3 \cb4  Show patient_id, first_name, last_name, and attending doctor's specialty.\cb1 \uc0\u8232 \cb4 Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'\cb1 \uc0\u8232 \u8232 \cb4 Check patients, admissions, and doctors tables for required information.
\f0\fs32 \cf2 \cb1 \
\'a0\
SELECT\
\'a0 p.patient_id,\
\'a0 p.first_name AS patient_first_name,\
\'a0 p.last_name AS patient_last_name,\
\'a0 ph.specialty AS attending_doctor_specialty\
FROM patients p\
\'a0 JOIN admissions a ON a.patient_id = p.patient_id\
\'a0 JOIN doctors ph ON ph.doctor_id = a.attending_doctor_id\
WHERE\
\'a0 ph.first_name = 'Lisa' and\
\pard\pardeftab720\li613\fi-480\partightenfactor0
\cf2 a.
\f2\fs18\fsmilli9333 \'a0\'a0\'a0\'a0 
\f0\fs32 diagnosis = 'Epilepsy'\
\pard\pardeftab720\li133\partightenfactor0
\cf2 \'a0\
\pard\pardeftab720\partightenfactor0
\cf2 -- 
\f1\fs36 \cf3 \cb4 Show patient_id, weight, height, isObese from the patients table.\cb1 \uc0\u8232 \u8232 \cb4 Display isObese as a boolean 0 or 1.\cb1 \uc0\u8232 \u8232 \cb4 Obese is defined as weight(kg)/(height(m)
\fs26\fsmilli13333 \cb1 \super 2
\fs36 \cb4 \nosupersub ) >= 30.\cb1 \uc0\u8232 \u8232 \cb4 weight is in units kg.\cb1 \uc0\u8232 \u8232 \cb4 height is in units cm.
\f0\fs32 \cf2 \cb1 \

\f1\fs36 \cf3 \cb4 \'a0
\f0\fs32 \cf2 \cb1 \
\pard\pardeftab720\partightenfactor0

\f2 \cf2 SELECT patient_id, weight, height, 
\f0 \

\f2 \'a0 (CASE 
\f0 \

\f2 \'a0\'a0\'a0\'a0\'a0 WHEN weight/(POWER(height/100.0,2)) >= 30 THEN
\f0 \

\f2 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 1
\f0 \

\f2 \'a0\'a0\'a0\'a0\'a0 ELSE
\f0 \

\f2 \'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0\'a0 0
\f0 \

\f2 \'a0\'a0\'a0\'a0\'a0 END) AS isObese
\f0 \

\f2 FROM patients;
\f0 \

\f2 \'a0
\f0 \

\f2 SELECT
\f0 \

\f2 \'a0 patient_id,
\f0 \

\f2 \'a0 weight,
\f0 \

\f2 \'a0 height,
\f0 \

\f2 \'a0 weight / power(CAST(height AS float) / 100, 2) >= 30 AS obese
\f0 \

\f2 FROM patients
\f0 \
\'a0\
\pard\pardeftab720\partightenfactor0

\f1\fs36 \cf3 \cb4 --Show all of the patients grouped into weight groups.\cb1 \uc0\u8232 \cb4 Show the total amount of patients in each weight group.\cb1 \uc0\u8232 \cb4 Order the list by the weight group decending.\cb1 \uc0\u8232 \u8232 \cb4 For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
\f0\fs32 \cf2 \cb1 \

\f1\fs36 \cf3 \cb4 \'a0
\f0\fs32 \cf2 \cb1 \
\pard\pardeftab720\partightenfactor0

\f2 \cf2 SELECT
\f0 \

\f2 \'a0 count(patient_id),
\f0 \

\f2 \'a0 weight - weight % 10 AS weight_group
\f0 \

\f2 FROM patients
\f0 \

\f2 GROUP BY weight_group
\f0 \

\f2 ORDER BY weight_group DESC
\f0 \
\'a0\
\'a0\
}