USE studentdb1;

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    dob DATE,
    department VARCHAR(100),
    phone VARCHAR(15)
);