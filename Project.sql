-- PROJECT TITLE
-- Hospital Patient Management and Medical Analytics System

-- PROJECT OBJECTIVE
-- Design and implement a relational database system to manage:
-- - Patients
-- - Doctors
-- - Departments
-- - Appointments
-- - Admissions
-- - Treatments
-- - Medical Tests
-- - Billing
-- Also generate medical analytics reports using SQL.


-- STEP 1 - CREATE DATABASE

CREATE DATABASE IF NOT EXISTS Hospital_Management;
USE Hospital_Management;


-- STEP 2 - CREATE TABLES

CREATE TABLE IF NOT EXISTS department (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS doctor (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT,
    specialization VARCHAR(100),
    contact_number VARCHAR(15),
    email VARCHAR(100),
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);

CREATE TABLE IF NOT EXISTS patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(10),
    contact_number VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(255),
    registration_date DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE IF NOT EXISTS appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    reason VARCHAR(255),
    status VARCHAR(20) DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

CREATE TABLE IF NOT EXISTS admission (
    admission_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    department_id INT,
    admission_date DATETIME,
    discharge_date DATETIME,
    reason VARCHAR(255),
    status VARCHAR(20) DEFAULT 'Admitted',
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);

CREATE TABLE IF NOT EXISTS treatment (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    admission_id INT,
    doctor_id INT,
    treatment_description VARCHAR(255),
    treatment_date DATETIME,
    diagnosis VARCHAR(255),
    treatment_cost DECIMAL(10, 2),
    FOREIGN KEY (admission_id) REFERENCES admission(admission_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

CREATE TABLE IF NOT EXISTS medical_test (
    test_id INT AUTO_INCREMENT PRIMARY KEY,
    admission_id INT,
    doctor_id INT,
    patient_id INT,
    test_name VARCHAR(255),
    test_date DATETIME,
    results VARCHAR(255),
    test_cost DECIMAL(10, 2),
    FOREIGN KEY (admission_id) REFERENCES admission(admission_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE IF NOT EXISTS billing (
    billing_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    admission_id INT,
    total_amount DECIMAL(10, 2),
    billing_date DATETIME DEFAULT (CURRENT_DATE),
    payment_status VARCHAR(20) DEFAULT 'Unpaid',
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (admission_id) REFERENCES admission(admission_id)
);


-- STEP 3 - INSERT SAMPLE DATA

-- Insert sample data into department table
INSERT INTO department (name, location) VALUES
('Cardiology', 'Building A'),
('Neurology', 'Building B'),
('Orthopedics', 'Building C'),
('Pediatrics', 'Building D'),
('Oncology', 'Building E'),
('Gastroenterology', 'Building F'),
('Dermatology', 'Building G'),
('Psychiatry', 'Building H'),
('Radiology', 'Building I'),
('Emergency', 'Building J'),
('Urology', 'Building K'),
('Ophthalmology', 'Building L'),
('ENT', 'Building M'),
('Endocrinology', 'Building N'),
('Nephrology', 'Building O'),
('Rheumatology', 'Building P'),
('Hematology', 'Building Q'),
('Infectious Diseases', 'Building R'),
('Pulmonology', 'Building S'),
('Gynecology', 'Building T');

-- Insert 20 doctors
INSERT INTO doctor (first_name, last_name, department_id, specialization, contact_number, email) VALUES
('Amit', 'Sharma', 1, 'Cardiologist', '9876543210', 'amit.sharma@hospital.com'),
('Neha', 'Verma', 2, 'Neurologist', '9876543211', 'neha.verma@hospital.com'),
('Ravi', 'Kumar', 3, 'Orthopedic Surgeon', '9876543212', 'ravi.kumar@hospital.com'),
('Priya', 'Singh', 4, 'Pediatrician', '9876543213', 'priya.singh@hospital.com'),
('Anil', 'Gupta', 5, 'Oncologist', '9876543214', 'anil.gupta@hospital.com'),
('Suman', 'Das', 6, 'Gastroenterologist', '9876543215', 'suman.das@hospital.com'),
('Rina', 'Patel', 7, 'Dermatologist', '9876543216', 'rina.patel@hospital.com'),
('Vikram', 'Mehta', 8, 'Psychiatrist', '9876543217', 'vikram.mehta@hospital.com'),
('Karan', 'Singh', 9, 'Radiologist', '9876543218', 'karan.singh@hospital.com'),
('Sonia', 'Kaur', 10, 'Emergency Medicine Specialist', '9876543219', 'sonia.kaur@hospital.com'),
('Rahul', 'Shah', 11, 'Urologist', '9876543220', 'rahul.shah@hospital.com'),
('Anjali', 'Reddy', 12, 'Ophthalmologist', '9876543221', 'anjali.reddy@hospital.com'),
('Vijay', 'Nair', 13, 'ENT Specialist', '9876543222', 'vijay.nair@hospital.com'),
('Sushma', 'Iyer', 14, 'Endocrinologist', '9876543223', 'sushma.iyer@hospital.com'),
('Rohit', 'Desai', 15, 'Nephrologist', '9876543224', 'rohit.desai@hospital.com'),
('Pooja', 'Sharma', 16, 'Rheumatologist', '9876543225', 'pooja.sharma@hospital.com'),
('Arjun', 'Kapoor', 17, 'Hematologist', '9876543226', 'arjun.kapoor@hospital.com'),
('Sanya', 'Malhotra', 18, 'Infectious Diseases Specialist', '9876543227', 'sanya.malhotra@hospital.com'),
('Kunal', 'Singh', 19, 'Pulmonologist', '9876543228', 'kunal.singh@hospital.com'),
('Neelam', 'Joshi', 20, 'Gynecologist', '9876543229', 'neelam.joshi@hospital.com');

-- Insert 200 patients (deterministic synthetic data)
INSERT INTO patient (first_name, last_name, date_of_birth, gender, contact_number, email, address)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM seq
    WHERE n < 200
)
SELECT
    ELT(((n - 1) % 20) + 1,
        'Aarav', 'Vivaan', 'Aditya', 'Vihaan', 'Arjun',
        'Sai', 'Krishna', 'Rohan', 'Karan', 'Ishaan',
        'Ananya', 'Diya', 'Aadhya', 'Myra', 'Saanvi',
        'Ira', 'Kiara', 'Meera', 'Riya', 'Naina'
    ) AS first_name,
    ELT(((n - 1) % 20) + 1,
        'Sharma', 'Verma', 'Gupta', 'Patel', 'Singh',
        'Reddy', 'Nair', 'Iyer', 'Joshi', 'Mehta',
        'Das', 'Kapoor', 'Chopra', 'Malhotra', 'Bose',
        'Kulkarni', 'Mishra', 'Saxena', 'Agarwal', 'Pillai'
    ) AS last_name,
    DATE_ADD('1965-01-01', INTERVAL ((n * 97) % 18000) DAY) AS date_of_birth,
    CASE WHEN MOD(n, 2) = 0 THEN 'Female' ELSE 'Male' END AS gender,
    CONCAT('9', LPAD(800000000 + n, 9, '0')) AS contact_number,
    LOWER(CONCAT(
        ELT(((n - 1) % 20) + 1,
            'Aarav', 'Vivaan', 'Aditya', 'Vihaan', 'Arjun',
            'Sai', 'Krishna', 'Rohan', 'Karan', 'Ishaan',
            'Ananya', 'Diya', 'Aadhya', 'Myra', 'Saanvi',
            'Ira', 'Kiara', 'Meera', 'Riya', 'Naina'
        ),
        '.',
        ELT(((n - 1) % 20) + 1,
            'Sharma', 'Verma', 'Gupta', 'Patel', 'Singh',
            'Reddy', 'Nair', 'Iyer', 'Joshi', 'Mehta',
            'Das', 'Kapoor', 'Chopra', 'Malhotra', 'Bose',
            'Kulkarni', 'Mishra', 'Saxena', 'Agarwal', 'Pillai'
        ),
        n,
        '@hospital.com'
    )) AS email,
    CONCAT(
        100 + n, ' ',
        ELT(((n - 1) % 10) + 1, 'Lake', 'River', 'Hill', 'Garden', 'Market', 'Temple', 'School', 'Park', 'Station', 'Fort'),
        ' Road, City ',
        LPAD(((n - 1) % 25) + 1, 2, '0')
    ) AS address
FROM seq;

-- Insert 320 appointments
INSERT INTO appointment (patient_id, doctor_id, appointment_date, reason, status)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM seq
    WHERE n < 320
)
SELECT
    ((n - 1) % 200) + 1 AS patient_id,
    ((n - 1) % 20) + 1 AS doctor_id,
    DATE_ADD('2025-01-01 09:00:00', INTERVAL (n * 5) HOUR) AS appointment_date,
    ELT(((n - 1) % 8) + 1,
        'Routine Checkup',
        'Follow-up Visit',
        'Fever and Weakness',
        'Chest Pain',
        'Headache',
        'Joint Pain',
        'Skin Allergy',
        'Breathing Difficulty'
    ) AS reason,
    CASE
        WHEN MOD(n, 10) = 0 THEN 'Cancelled'
        WHEN MOD(n, 6) = 0 THEN 'Completed'
        ELSE 'Scheduled'
    END AS status
FROM seq;

-- Insert 140 admissions
INSERT INTO admission (patient_id, doctor_id, department_id, admission_date, discharge_date, reason, status)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM seq
    WHERE n < 140
)
SELECT
    ((n - 1) % 200) + 1 AS patient_id,
    ((n - 1) % 20) + 1 AS doctor_id,
    ((n - 1) % 20) + 1 AS department_id,
    DATE_ADD('2025-01-01 08:00:00', INTERVAL n DAY) AS admission_date,
    CASE
        WHEN MOD(n, 5) = 0 THEN NULL
        ELSE DATE_ADD(DATE_ADD('2025-01-01 08:00:00', INTERVAL n DAY), INTERVAL (MOD(n, 6) + 1) DAY)
    END AS discharge_date,
    ELT(((n - 1) % 8) + 1,
        'Post-surgery care',
        'Severe infection',
        'Respiratory distress',
        'Cardiac monitoring',
        'Trauma management',
        'Renal complications',
        'Neurological observation',
        'Oncology treatment cycle'
    ) AS reason,
    CASE
        WHEN MOD(n, 5) = 0 THEN 'Admitted'
        ELSE 'Discharged'
    END AS status
FROM seq;

-- Insert 260 treatments
INSERT INTO treatment (admission_id, doctor_id, treatment_description, treatment_date, diagnosis, treatment_cost)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM seq
    WHERE n < 260
)
SELECT
    a.admission_id,
    a.doctor_id,
    ELT(((s.n - 1) % 7) + 1,
        'IV Medication',
        'Minor Procedure',
        'Physiotherapy Session',
        'Oxygen Support',
        'Wound Dressing',
        'Dialysis Session',
        'Post-Op Monitoring'
    ) AS treatment_description,
    DATE_ADD(a.admission_date, INTERVAL MOD(s.n, 4) DAY) AS treatment_date,
    ELT(((s.n - 1) % 8) + 1,
        'Hypertension',
        'Migraine',
        'Type 2 Diabetes',
        'Viral Fever',
        'Fracture',
        'Asthma',
        'Gastritis',
        'Kidney Disorder'
    ) AS diagnosis,
    ROUND(1500 + MOD((s.n * 37), 8500), 2) AS treatment_cost
FROM seq s
JOIN admission a
    ON a.admission_id = ((s.n - 1) % 140) + 1;

-- Insert 300 medical tests
INSERT INTO medical_test (admission_id, doctor_id, patient_id, test_name, test_date, results, test_cost)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM seq
    WHERE n < 300
)
SELECT
    a.admission_id,
    a.doctor_id,
    a.patient_id,
    ELT(((s.n - 1) % 8) + 1,
        'CBC',
        'LFT',
        'KFT',
        'X-Ray',
        'CT Scan',
        'MRI',
        'Blood Sugar',
        'ECG'
    ) AS test_name,
    DATE_ADD(a.admission_date, INTERVAL MOD(s.n + 1, 3) DAY) AS test_date,
    ELT(((s.n - 1) % 8) + 1,
        'Normal',
        'Slightly Elevated',
        'Needs Follow-up',
        'Critical Observation',
        'Stable',
        'Abnormal Finding',
        'Within Range',
        'Improving'
    ) AS results,
    ROUND(500 + MOD((s.n * 23), 4500), 2) AS test_cost
FROM seq s
JOIN admission a
    ON a.admission_id = ((s.n - 1) % 140) + 1;

-- Insert billing records (one bill per admission)
INSERT INTO billing (patient_id, admission_id, total_amount, billing_date, payment_status)
SELECT
    a.patient_id,
    a.admission_id,
    ROUND(COALESCE(t.total_treatment, 0) + COALESCE(mt.total_test, 0), 2) AS total_amount,
    COALESCE(a.discharge_date, DATE_ADD(a.admission_date, INTERVAL 7 DAY)) AS billing_date,
    CASE
        WHEN a.status = 'Discharged' AND MOD(a.admission_id, 4) <> 0 THEN 'Paid'
        ELSE 'Unpaid'
    END AS payment_status
FROM admission a
LEFT JOIN (
    SELECT admission_id, SUM(treatment_cost) AS total_treatment
    FROM treatment
    GROUP BY admission_id
) t ON a.admission_id = t.admission_id
LEFT JOIN (
    SELECT admission_id, SUM(test_cost) AS total_test
    FROM medical_test
    GROUP BY admission_id
) mt ON a.admission_id = mt.admission_id;


-- Data Insertion is completed.


select patient_id from patient;


WITH RECURSIVE nums AS (
    SELECT 2 AS n
    UNION ALL
    SELECT n + 1
    FROM nums
    WHERE n + 1 <= (SELECT FLOOR(SQRT(MAX(patient_id))) FROM patient)
)
SELECT p.*
FROM patient p
WHERE p.patient_id > 1
  AND NOT EXISTS (
      SELECT 1
      FROM nums
      WHERE nums.n <= FLOOR(SQRT(p.patient_id))
        AND p.patient_id % nums.n = 0
  )
ORDER BY p.patient_id;
