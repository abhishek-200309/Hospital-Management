                                    -- Patient & Demographic Analysis

-- How many patients registered in the hospital each month?

SELECT 
DATE_FORMAT(registration_date,'%Y-%m') AS month,
COUNT(patient_id) AS patients_registered
FROM patient
GROUP BY month
ORDER BY month;

-- What is the gender distribution of patients?

select Gender,count(patient_id) As Total_Patients from patient group by Gender;

-- What is the average age of patients in the hospital?

select avg(TIMESTAMPdiff(year,date_of_birth,curdate())) as Avg_Age
from patient;

-- Which age group visits the hospital the most?

select
case
WHEN 
TIMESTAMPdiff(year,date_of_birth,curdate()) <=18 then 'Teenager'
when
TIMESTAMPdiff
(year,date_of_birth,curdate()) <=35 then 'Young'
when
TIMESTAMPdiff
(year,date_of_birth,curdate()) <=50 then 'Adult'
else 'Senior'
end
as Age_Group, count(patient_id) as Total_Patients
from patient
group by Age_Group
order by Total_Patients desc;

-- How many patients have visited more than one doctor?

Select Concat_ws(" ",p.First_name,P.Last_Name) As Patient_Name,count(DISTINCT a.doctor_id) As Doctors_Visited
from patient p join appointment a on p.Patient_Id=a.Patient_Id
group by Patient_Name;


                                    -- Appointment Analysis

-- How many appointments were scheduled, completed, and cancelled?

select status,count(appointment_id) As Total_Appointments from appointment group by status;

-- Which doctor has the highest number of appointments?

select concat_ws(" ",d.First_name,D.Last_Name) As Doctor_Name, count(a.appointment_id) as Total_Appointments
from doctor d join appointment a on d.doctor_id=a.doctor_id
group by Doctor_Name
order by Total_Appointments desc
LIMIT 1;

-- Which department receives the most appointments?

select d.Department_Name, count(a.appointment_id) As Total_Appointments from Department
d join doctor doc on d.department_id=doc.department_id join appointment a on doc.doctor_id=a.doctor_id
group by d.department_id
ORDER BY Total_Appointments DESC;

-- What day of the week has the highest number of appointments?

SELECT 
DAYNAME(appointment_date) AS day_of_week,
COUNT(appointment_id) AS total_appointments
FROM appointment
GROUP BY day_of_week
ORDER BY total_appointments DESC
LIMIT 1;



-- Which patients have the most appointments?

SELECT 
CONCAT_WS(" ", p.first_name, p.last_name) AS patient_name,
COUNT(a.appointment_id) AS total_appointments
FROM patient p
JOIN appointment a ON p.patient_id = a.patient_id
GROUP BY p.patient_id
HAVING COUNT(a.appointment_id)>1;




select patient_id,count(appointment_id) as total_appointments from appointment group by patient_id order by total_appointments desc;


select * from appointment limit 4;

                                    -- Admission Analysis

-- How many patients were admitted to the hospital?

select count(patient_id) as Total_Patients from admission;

-- Which department has the highest number of admissions?

select d.Department_Name, count(DISTINCT a.admission_id) As Total_Admissions
from department d
    join admission a on d.department_id=a.department_id
GROUP BY d.department_id
ORDER BY Total_Admissions DESC
limit 1;

-- What is the average hospital stay duration?

select avg(timestampdiff(day,admission_date,discharge_date)) as Stay_Duration from admission;

-- Which patients stayed in the hospital the longest?

select concat_ws(" ",p.First_name,P.Last_Name) As Patient_Name, max(timestampdiff(day,admission_date,discharge_date)) As Stay_Duration
from patient p join admission a on p.patient_id=a.patient_id
GROUP BY a.patient_id
order by Stay_Duration desc
limit 1;

-- What percentage of admitted patients are still admitted vs discharged?

select 
round(100.00*sum(case when lower(status)='admitted' then 1 else 0 end)/count(*),2) As Admitted_Percentage,
round(100.00*sum(case when lower(status)='discharged' then 1 else 0 end)/count(*),2) as Discharged_Percentage
from admission;



                                    -- Doctor Performance

-- Which doctor treated the highest number of patients?

SELECT
    CONCAT_WS(" ", d.first_name, d.last_name) AS doctor_name,
    COUNT(DISTINCT a.patient_id) AS total_patients_treated
FROM doctor d
JOIN treatment t
    ON d.doctor_id = t.doctor_id
JOIN admission a
    ON t.admission_id = a.admission_id
GROUP BY d.doctor_id, d.first_name, d.last_name
ORDER BY total_patients_treated DESC
LIMIT 1;

-- Which doctor generated the most revenue from treatments?

SELECT
    CONCAT_WS(" ", d.first_name, d.last_name) AS doctor_name,
    ROUND(SUM(t.treatment_cost), 2) AS treatment_revenue
FROM doctor d
JOIN treatment t
    ON d.doctor_id = t.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name
ORDER BY treatment_revenue DESC
LIMIT 1;

-- Which doctor ordered the most medical tests?

select concat_ws(" ",d.First_name,D.Last_Name) As Doctor_Name, count(m.test_id) As Total_Medical_Tests
from doctor d join medical_test m on d.doctor_id=m.doctor_id
group by Doctor_Name
order by Total_Medical_Tests desc
limit 1;

-- Which department has the highest performing doctor by revenue?

select d.Department_Name,
    concat_ws(" ",doc.First_name,doc.Last_Name) As Doctor_Name , sum(test_cost) as Total_Revenue
from department d join doctor doc ON
d.department_id=doc.department_id join medical_test m on doc.doctor_id=m.doctor_id
group by doc.doctor_id
order by Total_revenue desc;



                                -- Treatment Analysis

-- What is the most common diagnosis?

SELECT
    t.diagnosis,
    COUNT(t.diagnosis) AS total_diagnoses
FROM treatment t
GROUP BY t.diagnosis
ORDER BY total_diagnoses DESC
limit 1;


-- What is the average treatment cost?

SELECT AVG(treatment_cost) AS avg_treatment_cost
FROM treatment t;

-- Which diagnosis has the highest average treatment cost?

select Diagnosis, round(avg(Treatment_cost),2) as Avg_treatment_cost from treatment
group by Diagnosis
ORDER BY Avg_treatment_cost DESC
limit 1;

-- Which treatment type is performed the most?

SELECT
    treatment_description AS treatment_type,
    COUNT(*) AS total_performed
FROM treatment
GROUP BY treatment_description
ORDER BY total_performed DESC
LIMIT 1;


-- What is the total treatment cost per department?

desc treatment;
select d.Department_Name, sum(t.Treatment_cost) As Total_Treatment_Cost
from department d join doctor doc on d.department_id=doc.department_id 
join treatment t on doc.doctor_id=t.doctor_id
group by d.department_id
order by Total_Treatment_Cost desc; 

                                -- Medical Test Analysis

-- Which medical test is ordered most frequently?

select Test_name, count(Test_id) as Total_test from 
Medical_test
group by 
Test_name
order by Total_test desc;

-- What is the average cost of each medical test?

select Test_Name, round(avg(Test_cost),2) as Avg_test_cost from Medical_test
group by Test_name;

-- Which doctor ordered the most tests?

select concat_ws(" ",d.First_name,D.Last_Name) As Doctor_Name, count(m.test_id) As Total_Medical_Tests
from doctor d join medical_test m on d.doctor_id=m.doctor_id
group by
d.doctor_id
order by Total_Medical_Tests desc
limit 1
;

-- What is the total revenue generated from medical tests?

select sum(medical_test.Test_cost) as Total_Revenue from Medical_test;  

                                -- Billing & Revenue Analysis

-- What is the total hospital revenue?

select sum(total_amount) as Total_Revenue from billing;

-- What percentage of bills are paid vs unpaid?

select

round(100.00*sum(case when lower(payment_status)='paid' then 1 else 0 end)/count(*),2) As Paid_Percentage,
round(100.00*sum(case when lower(payment_status)='unpaid' then 1 else 0 end)/count(*),2) As Paid_Percentage
from billing;

-- Which patient has the highest medical bill?

select concat_ws(" ",p.First_name,P.Last_Name) As Patient_Name, sum(b.total_amount) As Total_Bill
from patient p join billing b on p.patient_id=b.patient_id
group by p.patient_id
order by Total_Bill desc
limit 1;

-- What is the average billing amount per patient?

SELECT ROUND(AVG(patient_total), 2) AS avg_billing_per_patient
FROM (
    SELECT patient_id, SUM(total_amount) AS patient_total
    FROM billing
    GROUP BY patient_id
) AS patient_bills;

-- Which month generated the highest hospital revenue?

SELECT monthname(billing_date) as Month,
sum(total_amount) as Revenue from billing
GROUP BY monthname(billing_date)
ORDER BY Revenue DESC;
                                -- Advanced Analytical Questions (Great for Portfolio)

-- Rank doctors based on revenue generated.

SELECT
    CONCAT_WS(" ", d.first_name, d.last_name) AS doctor_name,
    ROUND(SUM(t.treatment_cost), 2) AS treatment_revenue,
    RANK() OVER (ORDER BY SUM(t.treatment_cost) DESC) AS revenue_rank
FROM doctor d
JOIN treatment t
    ON d.doctor_id = t.doctor_id
GROUP BY d.doctor_id;

-- Find the top 5 departments by patient volume.

SELECT
    d.department_name,
    COUNT(DISTINCT a.patient_id) AS patient_volume
FROM department d
JOIN doctor doc
    ON d.department_id = doc.department_id
JOIN appointment a
    ON doc.doctor_id = a.doctor_id
GROUP BY d.department_id
ORDER BY patient_volume DESC
LIMIT 5;


-- Identify patients who had both treatments and medical tests.

SELECT
    p.patient_id,
    CONCAT_WS(" ", p.first_name, p.last_name) AS patient_name
FROM patient p
WHERE EXISTS (
    SELECT 1
    FROM admission a
    JOIN treatment t
        ON t.admission_id = a.admission_id
    WHERE a.patient_id = p.patient_id
)
AND EXISTS (
    SELECT 1
    FROM medical_test mt
    WHERE mt.patient_id = p.patient_id
)
ORDER BY p.patient_id;


-- Find patients who had more than one hospital admission.

SELECT
    p.patient_id,
    CONCAT_WS(" ", p.first_name, p.last_name) AS patient_name,
    COUNT(*) AS total_admissions
FROM patient p
JOIN admission a
    ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name
HAVING COUNT(*) > 1
ORDER BY total_admissions DESC, p.patient_id;

-- Calculate the average treatment cost per doctor.

SELECT
    d.doctor_id,
    CONCAT_WS(" ", d.first_name, d.last_name) AS doctor_name,
    ROUND(AVG(t.treatment_cost), 2) AS avg_treatment_cost
FROM doctor d
JOIN treatment t
    ON d.doctor_id = t.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name
ORDER BY avg_treatment_cost DESC;



-- Identify departments where patients stay the longest.

SELECT
    d.department_id,
    d.department_name,
    ROUND(
        AVG(
            TIMESTAMPDIFF(
                DAY,
                a.admission_date,
                COALESCE(a.discharge_date, CURDATE())
            )
        ),
        2
    ) AS avg_stay_days
FROM department d
JOIN admission a
    ON d.department_id = a.department_id
GROUP BY d.department_id, d.department_name
ORDER BY avg_stay_days DESC;
