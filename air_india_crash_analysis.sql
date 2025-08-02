
-- Drop tables if they exist
DROP TABLE IF EXISTS passengers, incident_details, aircraft_details;

-- Table 1: Passengers
CREATE TABLE passengers (
    passenger_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    nationality VARCHAR(50)
);

-- Table 2: Incident Details
CREATE TABLE incident_details (
    incident_id INT PRIMARY KEY,
    passenger_id INT,
    seat_no VARCHAR(10),
    status VARCHAR(20),
    date_of_incident DATE,
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id)
);

-- Table 3: Aircraft Details
CREATE TABLE aircraft_details (
    aircraft_id INT PRIMARY KEY,
    aircraft_type VARCHAR(100),
    flight_no VARCHAR(10),
    departure VARCHAR(100),
    arrival VARCHAR(100),
    crash_location VARCHAR(255),
    crash_date DATE
);

-- Insert sample passengers
INSERT INTO passengers VALUES
(1, 'Rajesh Kumar', 34, 'Male', 'India'),
(2, 'Anita Sharma', 28, 'Female', 'India'),
(3, 'John Doe', 45, 'Male', 'USA');

-- Incident details
INSERT INTO incident_details VALUES
(101, 1, '12A', 'Deceased', '1976-01-01'),
(102, 2, '14B', 'Deceased', '1976-01-01'),
(103, 3, '16C', 'Deceased', '1976-01-01');

-- Aircraft details
INSERT INTO aircraft_details VALUES
(201, 'Boeing 707', 'AI171', 'Bombay', 'Dubai', 'Bandar Abbas, Iran', '1976-01-01');

-- Join passenger and incident data
SELECT 
    p.name,
    p.age,
    p.gender,
    p.nationality,
    i.seat_no,
    i.status,
    i.date_of_incident
FROM passengers p
JOIN incident_details i ON p.passenger_id = i.passenger_id;

-- Count of passengers by nationality
SELECT 
    nationality,
    COUNT(*) AS total_passengers
FROM passengers
GROUP BY nationality;

-- Age distribution of passengers
SELECT 
    CASE 
        WHEN age < 18 THEN 'Under 18'
        WHEN age BETWEEN 18 AND 35 THEN '18-35'
        WHEN age BETWEEN 36 AND 50 THEN '36-50'
        ELSE '51+'
    END AS age_group,
    COUNT(*) AS count
FROM passengers
GROUP BY age_group;

-- Status summary
SELECT 
    status,
    COUNT(*) AS total
FROM incident_details
GROUP BY status;

-- Full crash context with aircraft details
SELECT 
    a.flight_no,
    a.aircraft_type,
    a.departure,
    a.arrival,
    a.crash_location,
    a.crash_date,
    p.name,
    p.nationality,
    i.status
FROM aircraft_details a
JOIN incident_details i ON a.crash_date = i.date_of_incident
JOIN passengers p ON p.passenger_id = i.passenger_id;
