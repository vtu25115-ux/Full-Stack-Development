use Student;
-- ==================================================
--  TABLE SETUP
-- ==================================================
CREATE TABLE IF NOT EXISTS Student (
    VTU_Number VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Department VARCHAR(50)
);

INSERT IGNORE INTO Student VALUES
('1MS23CS001', 'Arjun Kumar', 'arjun@mail.com', '9845011223', 'CSE'),
('1MS23CS002', 'Sneha Rao', 'sneha@mail.com', '9845022334', 'IT'),
('1MS23CS003', 'Rahul Nair', 'rahul@mail.com', '9845033445', 'CSE');

-- ==================================================
-- 1. INITIATE AND COMMIT A TRANSACTION
-- ==================================================
START TRANSACTION;

INSERT INTO Student VALUES
('1MS23CS004', 'Priya Das', 'priya@mail.com', '9845044556', 'ECE');

COMMIT;

-- ==================================================
-- 2. SAVEPOINT, TRANSACTIONS & ROLLBACK
-- ==================================================
START TRANSACTION;

UPDATE Student
SET Phone = '9999999999'
WHERE VTU_Number = '1MS23CS001';

SAVEPOINT sp1;

UPDATE Student
SET Phone = '8888888888'
WHERE VTU_Number = '1MS23CS002';

-- Rollback to savepoint (undo second update only)
ROLLBACK TO sp1;

COMMIT;

-- ==================================================
-- 3. USER-DEFINED FUNCTION
--    Simple Mathematical Calculation
-- ==================================================
DELIMITER $$

CREATE FUNCTION calc_result(a INT, b INT, op CHAR)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE result INT;

    IF op = '+' THEN
        SET result = a + b;
    ELSEIF op = '-' THEN
        SET result = a - b;
    ELSEIF op = '*' THEN
        SET result = a * b;
    ELSE
        SET result = a / b;
    END IF;

    RETURN result;
END$$

DELIMITER ;

-- Function call
SELECT calc_result(10, 5, '+') AS Addition;
SELECT calc_result(10, 5, '*') AS Multiplication;

-- ==================================================
-- 4. USER-DEFINED FUNCTION
--    Return value using SELECT query
-- ==================================================
DELIMITER $$

CREATE FUNCTION get_student_count(dept_name VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(*)
    INTO total
    FROM Student
    WHERE Department = dept_name;

    RETURN total;
END$$

DELIMITER ;

-- Function call
SELECT get_student_count('CSE') AS CSE_Students;
SELECT get_student_count('IT') AS IT_Students;

-- ==================================================
-- END OF FILE
-- ==================================================