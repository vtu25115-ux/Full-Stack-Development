use products;
-- =========================
-- CREATE TABLE (SAFE)
-- =========================
CREATE TABLE IF NOT EXISTS sales (
    sale_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    sale_date DATE,
    sale_amount INT
);

-- =========================
-- INSERT DATA (SAFE)
-- =========================
INSERT IGNORE INTO sales (sale_id, product_name, sale_date, sale_amount) VALUES
(1, 'Widget A', '2024-08-01', 100),
(2, 'Widget B', '2024-08-05', 150),
(3, 'Widget C', '2024-08-07', 200),
(4, 'Widget A', '2024-08-10', 120),
(5, 'Widget B', '2024-08-15', 180),
(6, 'Widget C', '2024-08-20', 250);

-- =========================
-- DATE FUNCTIONS
-- =========================
SELECT sale_id, product_name,
       DATE(sale_date) AS sale_date_only
FROM sales;

SELECT sale_id, product_name,
       EXTRACT(YEAR FROM sale_date) AS sale_year
FROM sales;

SELECT sale_id, product_name,
       DATE_ADD(sale_date, INTERVAL 7 DAY) AS sale_date_plus_7_days
FROM sales;

-- =========================
-- MATHEMATICAL FUNCTIONS
-- =========================
SELECT
    ABS(-25) AS abs_value,
    ROUND(12.678, 2) AS rounded_value,
    POWER(2, 5) AS power_value,
    MOD(17, 5) AS modulus_value;

-- =========================
-- STRING FUNCTIONS
-- =========================
SELECT
    UPPER('database') AS upper_text,
    LOWER('SQL') AS lower_text,
    LENGTH('Computer') AS text_length,
    SUBSTRING('FullStack', 1, 4) AS sub_text,
    CONCAT('My', 'SQL') AS combined_text;

-- =========================
-- VIEW TABLE ANYTIME
-- =========================

desc sales;