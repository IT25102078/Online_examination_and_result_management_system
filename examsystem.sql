USE mydb;

DELETE FROM students;
INSERT INTO students (student_name, email, password, contact)
VALUES ('Ravi', 'ravi@gmail.com', '1234', '0771234567');

INSERT INTO students (student_name, email, password, contact)
VALUES ('Kamal', 'kamal@gmail.com', 'abcd', '0771111111');
SELECT * FROM students;
SELECT * FROM students WHERE student_id = 1;
SELECT * FROM students WHERE student_name = 'Ravi';
UPDATE students
SET student_name = 'Ravi Kumar',
    contact = '0779999999'
WHERE student_id = 1;
SELECT * FROM students;
DELETE FROM students
WHERE student_id = 2;
SELECT * FROM students;
DELETE FROM students;