--creating database
CREATE DATABASE hospitaldata;

--creating table
DROP TABLE hospitals;
Create table hospitals(
        hospital_name VARCHAR(100),
		location Varchar(50),
		department varchar(50),
		doctors_count INT,
		patients_count INT,
		admission_date DATE,
		discharge_date DATE,
		medical_expenses NUMERIC(10,2)
);

SELECT * FROM hospitals;

--copying data from csv file
COPY hospitals(hospital_name, location, department, doctors_count, patients_count, admission_date, discharge_date, medical_expenses)
FROM 'D:\Postgre SQL\ST - SQL ALL PRACTICE FILES SD61\ST - SQL ALL PRACTICE FILES-2\All Excel Practice Files\Hospital_Data.csv'
CSV HEADER;

--1. Write an SQL query to find the total number of patients across all hospitals. 
SELECT hospital_name, SUM(patients_count) FROM hospitals
GROUP BY hospital_name;

--2. Retrieve the average count of doctors available in each hospital.
SELECT hospital_name, AVG(doctors_count) AS doctors_average FROM hospitals
GROUP BY hospital_name;

--3. Find the top 3 hospital departments that have the highest number of patients.
SELECT department, SUM(patients_count) AS total_patients
FROM hospitals
GROUP BY department
ORDER BY total_patients DESC 
LIMIT 3;

--4. Identify the hospital that recorded the highest medical expenses. 
SELECT hospital_name, SUM(medical_expenses) AS total_expenses
FROM hospitals
GROUP BY hospital_name
ORDER BY total_expenses DESC
LIMIT 1;

--5. Calculate the average medical expenses per day for each hospital.
SELECT hospital_name,
    AVG(medical_expenses / (discharge_date - admission_date)) AS avg_medical_expenses_per_day
FROM hospitals
GROUP BY hospital_name;

--6. Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date.
SELECT hospital_name, patients_count, (discharge_date-admission_date) AS stay_dates
FROM hospitals

ORDER BY stay_dates DESC
LIMIT 1;

--7. Count the total number of patients treated in each city. 
SELECT location, SUM(patients_count) AS Total_patients_treated
FROM hospitals
GROUP BY location
ORDER BY Total_patients_treated DESC;

--8. Calculate the average number of days patients spend in each department.
SELECT department, AVG(discharge_date-admission_date) AS average_stay_days 
FROM hospitals
GROUP BY department
ORDER BY average_stay_days DESC;

--9. Find the department with the least number of patients.
SELECT department, SUM(patients_count) AS total_patients
FROM hospitals
GROUP BY department
ORDER BY total_patients ASC
LIMIT 1;

--10. Group the data by month and calculate the total medical expenses for each month. 
SELECT 
    TO_CHAR(DATE_TRUNC('month', admission_date), 'Mon-YYYY') AS month,
    SUM(medical_expenses) AS total_medical_expenses
FROM hospitals
GROUP BY DATE_TRUNC('month', admission_date)
ORDER BY DATE_TRUNC('month', admission_date);





