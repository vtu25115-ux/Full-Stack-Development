-- ===============================
-- 1. CREATE DATABASE
-- ===============================
CREATE DATABASE IF NOT EXISTS fullstack1;
USE fullstack1;

-- ===============================
-- 2. CREATE TABLES
-- ===============================

-- Student Table
CREATE TABLE IF NOT EXISTS Student (
    VTU_Number VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Department VARCHAR(50)
);

-- Course Table
CREATE TABLE IF NOT EXISTS Course (
    Course_Code VARCHAR(10) PRIMARY KEY,
    Course_Name VARCHAR(100),
    Faculty_Id INT,
    Student_ID VARCHAR(20),
    Faculty_Email VARCHAR(100),
    FOREIGN KEY (Student_ID) REFERENCES Student(VTU_Number)
);

-- ===============================
-- 3. INSERT RECORDS
-- ===============================

-- Inserting into Student Table
INSERT IGNORE INTO Student VALUES 
('1MS23CS001', 'Arjun Kumar', 'arjun@mail.com', '9845011223', 'CSE'),
('1MS23CS002', 'Sneha Rao', 'sneha@mail.com', '9845022334', 'IT'),
('1MS23CS003', 'Rahul Nair', 'rahul@mail.com', '9845033445', 'CSE'),
('1MS23CS004', 'Priya Das', 'priya@mail.com', '9845044556', 'ECE'),
('1MS23CS005', 'Amit Singh', 'amit@mail.com', '9845055667', 'IT');

-- Inserting into Course Table
INSERT IGNORE INTO Course VALUES 
('CS101', 'Database Management', 101, '1MS23CS001', 'prof_smith@vtu.edu'),
('IS202', 'Data Structures', 102, '1MS23CS002', 'prof_jones@vtu.edu'),
('CS103', 'Operating Systems', 101, '1MS23CS003', 'prof_smith@vtu.edu'),
('EC301', 'Digital Electronics', 103, '1MS23CS004', 'prof_kumar@vtu.edu'),
('IS204', 'Web Programming', 104, '1MS23CS005', 'prof_leila@vtu.edu');

-- ===============================
-- 4. SELECT QUERIES USING CLAUSES
-- ===============================

-- i. WHERE Clause
SELECT * FROM Student 
WHERE Department = 'CSE';

-- ii. ORDER BY Clause
SELECT * FROM Course 
ORDER BY Course_Name ASC;

-- iii. LIKE Clause
SELECT Name, Email 
FROM Student 
WHERE Email LIKE '%@mail.com';

-- iv. LIMIT Clause
SELECT * FROM Student 
LIMIT 3;

-- v. GROUP BY & HAVING Clause
SELECT Department, COUNT(*) AS Total_Students
FROM Student
GROUP BY Department
HAVING COUNT(*) > 1;