-- ==================================================
-- DATABASE CREATION
-- ==================================================
CREATE DATABASE IF NOT EXISTS fullstack;
USE fullstack;

-- ==================================================
-- TABLE CREATION
-- ==================================================
CREATE TABLE IF NOT EXISTS Student (
    VTU_Number VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Department VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Course (
    Course_Code VARCHAR(10) PRIMARY KEY,
    Course_Name VARCHAR(100),
    Faculty_Id INT,
    Student_ID VARCHAR(20),
    Faculty_Email VARCHAR(100),
    FOREIGN KEY (Student_ID) REFERENCES Student(VTU_Number)
);

-- ==================================================
-- INSERT RECORDS
-- ==================================================
INSERT IGNORE INTO Student VALUES
('1MS23CS001', 'Arjun Kumar', 'arjun@mail.com', '9845011223', 'CSE'),
('1MS23CS002', 'Sneha Rao', 'sneha@mail.com', '9845022334', 'IT'),
('1MS23CS003', 'Rahul Nair', 'rahul@mail.com', '9845033445', 'CSE'),
('1MS23CS004', 'Priya Das', 'priya@mail.com', '9845044556', 'ECE'),
('1MS23CS005', 'Amit Singh', 'amit@mail.com', '9845055667', 'IT');

INSERT IGNORE INTO Course VALUES
('CS101', 'Database Management', 101, '1MS23CS001', 'prof_smith@vtu.edu'),
('IS202', 'Data Structures', 102, '1MS23CS002', 'prof_jones@vtu.edu'),
('CS103', 'Operating Systems', 101, '1MS23CS003', 'prof_smith@vtu.edu'),
('EC301', 'Digital Electronics', 103, '1MS23CS004', 'prof_kumar@vtu.edu'),
('IS204', 'Web Programming', 104, '1MS23CS005', 'prof_leila@vtu.edu');

-- ==================================================
-- BASIC SELECT QUERIES
-- ==================================================
SELECT * FROM Student;
SELECT * FROM Course;

-- ==================================================
-- AGGREGATE FUNCTIONS
-- ==================================================
SELECT COUNT(*) AS Total_Students FROM Student;
SELECT COUNT(DISTINCT Department) AS Department_Count FROM Student;
SELECT MAX(Faculty_Id) AS Highest_Faculty_ID FROM Course;

-- ==================================================
-- SORTING
-- ==================================================
SELECT * FROM Student ORDER BY VTU_Number ASC;
SELECT * FROM Student ORDER BY VTU_Number DESC;

-- ==================================================
-- WHERE CLAUSE
-- ==================================================
SELECT * FROM Student WHERE Department = 'CSE';

-- ==================================================
-- JOINS
-- ==================================================
-- INNER JOIN
SELECT s.VTU_Number, s.Name, c.Course_Name, c.Faculty_Id
FROM Student s
INNER JOIN Course c ON s.VTU_Number = c.Student_ID;

-- LEFT JOIN
SELECT s.VTU_Number, s.Name, c.Course_Name
FROM Student s
LEFT JOIN Course c ON s.VTU_Number = c.Student_ID;

-- RIGHT JOIN
SELECT s.Name, c.Course_Code, c.Course_Name
FROM Student s
RIGHT JOIN Course c ON s.VTU_Number = c.Student_ID;

-- FULL OUTER JOIN (MySQL using UNION)
SELECT s.Name, c.Course_Name
FROM Student s
LEFT JOIN Course c ON s.VTU_Number = c.Student_ID
UNION
SELECT s.Name, c.Course_Name
FROM Student s
RIGHT JOIN Course c ON s.VTU_Number = c.Student_ID;

-- CROSS JOIN
SELECT s.Name, c.Course_Name
FROM Student s
CROSS JOIN Course c;

-- ==================================================
-- CRT QUESTIONS
-- ==================================================

-- 1. Select set of students based on course & count
SELECT 
    c.Course_Code,
    c.Course_Name,
    COUNT(c.Student_ID) AS Student_Count
FROM Course c
GROUP BY c.Course_Code, c.Course_Name;

-- 2. Select courses handled by a faculty and insert into new table
CREATE TABLE IF NOT EXISTS Faculty_Courses (
    Faculty_Id INT,
    Course_Code VARCHAR(10),
    Course_Name VARCHAR(100),
    Faculty_Email VARCHAR(100)
);

INSERT INTO Faculty_Courses
SELECT Faculty_Id, Course_Code, Course_Name, Faculty_Email
FROM Course
WHERE Faculty_Id = 101;

SELECT * FROM Faculty_Courses;

-- 3. Select top 5 students from same department and update phone with country code
UPDATE Student
SET Phone = CONCAT('+91', Phone)
WHERE VTU_Number IN (
    SELECT VTU_Number FROM (
        SELECT VTU_Number
        FROM Student
        WHERE Department = 'CSE'
        ORDER BY VTU_Number
        LIMIT 5
    ) AS temp
);

SELECT VTU_Number, Name, Phone FROM Student WHERE Department = 'CSE';

desc Student;
