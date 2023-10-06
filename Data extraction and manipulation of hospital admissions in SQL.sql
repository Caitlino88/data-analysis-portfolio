-- Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)

SELECT
  patient_id,
  first_name,
  last_name
FROM patients P
WHERE patient_id NOT IN(
    SELECT patient_id
    FROM admissions
  )


-- Display patient's full name,
-- height in the units feet rounded to 1 decimal,
-- weight in the unit pounds rounded to 0 decimals,birth_date,gender non abbreviated. Convert CM to feet by dividing by 30.48. Convert KG to pounds by multiplying by 2.205.

SELECT
  CONCAT(first_name, ' ', last_name) AS full_name,
  ROUND(height / 30.48, 1) AS height_f,
  ROUND(weight * 2.205, 0) as wiehgt_p,
  birth_Date,
  CASE
    WHEN gender = 'F' THEN 'Female'
    ELSE 'Male'
  END AS 'gender_type'
FROM patients

-- display the number of duplicate patients based on their first_name and last_name.

SELECT first_name, last_name,number
FROM patients P
JOIN(SELECT
  patient_id, CONCAT(first_name,' ', last_name) AS full_name,COUNT(*) AS number
FROM patients
GROUP BY full_name
HAVING number >1) AS S
ON S.patient_id = P.patient_id

select
  first_name,
  last_name,
  count(*) as num_of_duplicates
from patients
group by
  first_name,
  last_name
having count(*) > 1

-- For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.

SELECT
  CONCAT(P.first_name,' ', P.last_name) AS p_full_name,
  CONCAT(D.first_name,' ', D.last_name) AS d_full_name,
  A.diagnosis
FROM patients P
JOIN admissions A ON P.patient_id = A.patient_id
JOIN doctors D on D.doctor_id = A.attending_doctor_id

-- Display the total amount of patients for each province. Order by descending.


SELECT
  PN.province_name,count(*) as total_amount
FROM patients P
JOIN province_names PN ON P.province_id = PN.province_id
GROUP BY PN.province_name
ORDER BY total_amount DESC

-- Show first_name, last_name, and the total number of admissions attended for each doctor. Every admission has been attended by a doctor.

SELECT
  D.first_name, 
  D.last_name,
  COUNT(A.attending_doctor_id) AS total_number
FROM doctors D
JOIN admissions A ON D.doctor_id = A.attending_doctor_id
GROUP BY D.doctor_id

-- Show all columns for patient_id 542's most recent admission_date.
SELECT*
FROM admissions
WHERE patient_id = 542 
GROUP BY patient_id
HAVING 
 admission_date = max(admission_date)

-- Show all allergies ordered by popularity. Remove NULL values from query.

SELECT
 allergies, COUNT(*) AS popularity
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY popularity DESC


-- Show how many patients have a birth_date with 2010 as the birth year.
SELECT COUNT(*) AS total_patients
FROM patients
WHERE YEAR(birth_date) = 2010;

-- Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.

SELECT
DAY(admission_date) AS date,COUNT(*) AS admission_count
FROM admissions
GROUP BY date
order by admission_count DESC

-- Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'

SELECT
 MAX(weight) - MIN(weight) AS difference
FROM patients
WHERE last_name = 'Maroni'

-- Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.

SELECT
 province_id,SUM(height) AS sum_hei
FROM patients
GROUP BY province_id
HAVING sum_hei >= 7000

-- Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.

SELECT
  patient_id,
  attending_doctor_id,
  diagnosis
FROM admissions
WHERE
  (
    patient_id % 2 != 0
    AND attending_doctor_id IN (1, 5, 19)
  )
  OR (
    attending_doctor_id LIKE '%2%'
    AND LEN(patient_id) = 3
  )

-- We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order. EX: SMITH,jane

SELECT
 CONCAT(UPPER(last_name),',',LOWER(first_name)) AS full_name
FROM patients
ORDER BY first_name DESC

-- We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.

SELECT
  doctor_id,
  CONCAT(first_name, ' ', last_name) AS doctor_full_name,
  specialty,
  year(admission_date) AS Select_year,
  COUNT(*) AS total_admissions
from doctors D
  LEFT JOIN admissions A ON D.doctor_id = A.attending_doctor_id
GROUP BY
  doctor_id,
  Select_year

-- Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.

select province_name
from province_names
order by
  (case when province_name = 'Ontario' then 0 else 1 end),
  province_name

-- For each day display the total amount of admissions on that day. Display the amount changed from the previous date.
SELECT
 admission_date,
 count(admission_date) as admission_day,
 count(admission_date) - LAG(count(admission_date)) OVER(ORDER BY admission_date) AS admission_count_change 
FROM admissions
 group by admission_date

-- Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.

SELECT CONCAT(
    ROUND(
      (
        SELECT COUNT(*)
        FROM patients
        WHERE gender = 'M'
      ) / CAST(COUNT(*) as float),
      4
    ) * 100,
    '%'
  ) as percent_of_male_patients
FROM patients;

 -- We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
 -- First_name contains an 'r' after the first two letters.
 -- Identifies their gender as 'F'
 -- Born in February, May, or December
 -- Their weight would be between 60kg and 80kg
 -- Their patient_id is an odd number
 -- They are from the city 'Kingston'

SELECT *
FROM patients
WHERE
  first_name LIKE '__r%'
  AND gender = 'F'
  AND MONTH(birth_date) IN (2, 5, 12)
  AND weight BETWEEN 60 AND 80
  AND patient_id % 2 = 1
  AND city = 'Kingston';

 -- Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name

SELECT pr.province_name
FROM patients AS pa
  JOIN province_names AS pr ON pa.province_id = pr.province_id
GROUP BY pr.province_name
HAVING
  COUNT( CASE WHEN gender = 'M' THEN 1 END) > COUNT( CASE WHEN gender = 'F' THEN 1 END);

 -- Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance. Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.

SELECT 
CASE WHEN patient_id % 2 = 0 Then 
    'Yes'
ELSE 
    'No' 
END as has_insurance,
SUM(CASE WHEN patient_id % 2 = 0 Then 
    10
ELSE 
    50 
END) as cost_after_insurance
FROM admissions 
GROUP BY has_insurance;

 -- All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
 -- The password must be the following, in order: 1. patient_id 2. the numerical length of patient's last_name 3. year of patient's birth_date

SELECT
  DISTINCT P.patient_id,
  CONCAT(
    P.patient_id,
    LEN(last_name),
    YEAR(birth_date)
  ) AS temp_password
FROM patients P
  JOIN admissions A ON A.patient_id = P.patient_id

 -- Show patient_id, first_name, last_name, and attending doctor's specialty.Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'. 

SELECT
  p.patient_id,
  p.first_name AS patient_first_name,
  p.last_name AS patient_last_name,
  ph.specialty AS attending_doctor_specialty
FROM patients p
  JOIN admissions a ON a.patient_id = p.patient_id
  JOIN doctors ph ON ph.doctor_id = a.attending_doctor_id
WHERE
  ph.first_name = 'Lisa' and
a.	diagnosis = 'Epilepsy'

 -- Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1.vObese is defined as weight(kg)/(height(m)2) >= 30.
-- weight is in units kg. height is in units cm.

SELECT patient_id, weight, height, 
  (CASE 
      WHEN weight/(POWER(height/100.0,2)) >= 30 THEN
          1
      ELSE
          0
      END) AS isObese
FROM patients;

SELECT
  patient_id,
  weight,
  height,
  weight / power(CAST(height AS float) / 100, 2) >= 30 AS obese
FROM patients

 --Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group.
 -- Order the list by the weight group decending. For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.

SELECT
  count(patient_id),
  weight - weight % 10 AS weight_group
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC