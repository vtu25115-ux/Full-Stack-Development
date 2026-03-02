-- ===============================
-- Transaction-Based Payment Simulation
-- ===============================

-- Create Database
CREATE DATABASE IF NOT EXISTS paymentdb;
USE paymentdb;

-- Drop tables if already exist
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS merchants;

-- Create Users Table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    balance DECIMAL(10,2)
);

-- Create Merchants Table
CREATE TABLE merchants (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    balance DECIMAL(10,2)
);

-- Insert Sample Data
INSERT INTO users (name, balance) VALUES ('Sai', 5000.00);
INSERT INTO merchants (name, balance) VALUES ('Amazon', 10000.00);

-- ==========================================
-- SUCCESSFUL TRANSACTION (COMMIT)
-- ==========================================

START TRANSACTION;

-- Deduct 1000 from User
UPDATE users
SET balance = balance - 1000
WHERE id = 1;

-- Add 1000 to Merchant
UPDATE merchants
SET balance = balance + 1000
WHERE id = 1;

COMMIT;

-- Check Balances After Commit
SELECT * FROM users;
SELECT * FROM merchants;

-- ==========================================
-- FAILED TRANSACTION (ROLLBACK)
-- ==========================================

START TRANSACTION;

-- Try deducting 2000
UPDATE users
SET balance = balance - 2000
WHERE id = 1;

-- Simulate failure
ROLLBACK;

-- Check Balances After Rollback
SELECT * FROM users;
SELECT * FROM merchants;