-- ==========================================
-- Automated Logging using Triggers & Views
-- ==========================================

CREATE DATABASE IF NOT EXISTS auditdb;
USE auditdb;

-- Drop tables if exist
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS audit_log;

-- Main Table
CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    department VARCHAR(100),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Audit Log Table
CREATE TABLE audit_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    action_type VARCHAR(20),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- TRIGGER FOR INSERT
-- ==========================================

DELIMITER $$

CREATE TRIGGER after_student_insert
AFTER INSERT ON students
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (student_id, action_type)
    VALUES (NEW.id, 'INSERT');
END$$

-- ==========================================
-- TRIGGER FOR UPDATE
-- ==========================================

CREATE TRIGGER after_student_update
AFTER UPDATE ON students
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (student_id, action_type)
    VALUES (NEW.id, 'UPDATE');
END$$

DELIMITER ;

-- ==========================================
-- Insert Sample Data
-- ==========================================

INSERT INTO students (name, email, department)
VALUES ('Sai', 'sai@gmail.com', 'CSE');

UPDATE students
SET department = 'IT'
WHERE id = 1;

-- ==========================================
-- VIEW FOR DAILY ACTIVITY REPORT
-- ==========================================

CREATE OR REPLACE VIEW daily_activity_report AS
SELECT 
    DATE(action_time) AS activity_date,
    action_type,
    COUNT(*) AS total_actions
FROM audit_log
GROUP BY DATE(action_time), action_type;

-- View the Report
SELECT * FROM daily_activity_report;