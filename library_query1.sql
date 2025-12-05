USE student_system;
  

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    gender VARCHAR(10),
    dob DATE,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50) DEFAULT 'Unknown'
);
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    duration INT,    
    fees FLOAT
);

CREATE TABLE enrollments (
    enroll_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    enroll_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
INSERT INTO students (first_name, last_name, gender, dob, email, phone, city)
VALUES
('Asha', 'Kumar', 'Female', '2000-06-18', 'asha@example.com', '9988776655', 'Delhi'),
('Ravi', 'Patel', 'Male', '1999-03-11', 'ravi@example.com', '8877665544', 'Mumbai'),
('Neha', 'Shah', 'Female', '2001-01-20', NULL, '7788996655', 'Pune'),
('Aman', 'Singh', 'Male', '1998-09-25', 'aman@example.com', '8899776655', NULL);

INSERT INTO courses (course_name, duration, fees)
VALUES
('Python', 60, 9000.50),
('Data Science', 90, 15000.75),
('Web Development', 75, 12000.00);


INSERT INTO enrollments (student_id, course_id, enroll_date)
VALUES
(1, 1, '2024-02-01'),
(2, 2, '2024-04-05'),
(3, 1, '2024-03-15'),
(4, 3, '2024-05-20');

select * from students;
select * from courses;
select * from enrollments;

#Display student first name and city.
select first_name, city 
from students;

#Show all course names and their duration.
select course_name, duration
from courses;

#Students who live in Delhi.
select first_name, last_name,city
from students
where city = 'Delhi';

#Courses with fees greater than 10,000.
select course_name, fees
from Courses
where fees> 10000;

#Courses with duration between 70 and 100 days.
select course_name,fees
from courses
where duration between 70 and 100;

#Female students from Pune.
select *
from students
where gender = 'female' and city = 'pune';

#Students from Mumbai OR Delhi.
select * from students
where city = 'Mumbai' or  city = 'Delhi';

#Students NOT from Mumbai.
select * from students
WHERE NOT city = 'Mumbai';

#List all courses from highest to lowest fees.
select * from courses order by fees desc;

#Show top 2 most expensive courses.
select * from courses
order by fees desc limit 2;

#Students without email.
select * from students
where email is null;

#Update Neha’s city to 'Bangalore'.
update students
set city = 'Bangalore'
where student_id =3

#List students with their enrolled course name








