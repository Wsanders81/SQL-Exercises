
DROP DATABASE IF EXISTS med_center; 
CREATE DATABASE med_center; 
\c med_center ;

CREATE TABLE doctors 
(
    id SERIAL PRIMARY KEY, 
    doctor_name TEXT NOT NULL 
     

); 

CREATE TABLE patients
(
    id SERIAL PRIMARY KEY, 
    first_name TEXT NOT NULL, 
    last_name TEXT NOT NULL, 
    address TEXT

); 

CREATE TABLE diseases 
(
    id SERIAL PRIMARY KEY, 
    disease_name VARCHAR(15) UNIQUE NOT NULL, 
    is_contagious BOOLEAN DEFAULT false
); 

CREATE TABLE visits 
(
    id SERIAL PRIMARY KEY, 
    doctor_id INTEGER REFERENCES doctors ON DELETE SET NULL, 
    patient_id INTEGER REFERENCES patients ON DELETE SET NULL, 
    date DATE NOT NULL

); 

CREATE TABLE outcomes 
(
    id SERIAL PRIMARY KEY, 
    visit_id INTEGER REFERENCES visits, 
    disease_id INTEGER REFERENCES diseases
);

INSERT INTO doctors (doctor_name)
VALUES 
('Dr. Zhivago'), 
('Dr. Strange'), 
('Dr. Watson'), 
('Dr. Jekyll'); 

INSERT INTO patients (first_name, last_name, address)
VALUES
('Big', 'Bird', '123 1/2 Sesame Street'), 
('Harry', 'Potter', '4 Privet Drive'), 
('Sherlock', 'Holmes', '123B Baker Street'), 
('Peter', 'Griffin', '31 Spooner Street'); 

INSERT INTO diseases (disease_name, is_contagious)
VALUES
('Amyloidosis', false), 
('Sarcoidosis', false), 
('COVID', true), 
('E.Coli', true); 

INSERT INTO visits (doctor_id, patient_id, date)
VALUES 
(1,4,'2012-08-10'),
(2,1,'2012-08-10'),
(1,2,'2012-08-10'),
(4,4,'2012-08-10'),
(3,3,'2012-08-10'),
(2,4,'2012-08-10'),
(1,2,'2012-08-10');

INSERT INTO outcomes (visit_id, disease_id)
VALUES 
(1,1), 
(2,4), 
(3,3), 
(4,4), 
(5,2), 
(6,2), 
(7,1); 

--****** Query ********
-- SELECT date, doctor_name, first_name, last_name, disease_name, is_contagious
-- FROM doctors 
-- JOIN visits 
-- ON doctors.id = visits.doctor_id
-- JOIN patients
-- ON patients.id = visits.patient_id
-- JOIN outcomes 
-- ON visits.id = outcomes.visit_id
-- JOIN diseases
-- ON diseases.id = outcomes.disease_id
-- ORDER BY date DESC; 