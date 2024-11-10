 --TASK 1

 create database SISDB
 --1.students table
 create table Students (
    student_id int primary key identity(1,1),
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    date_of_birth date not null,
    email varchar(100) not null unique,
    phone_number varchar(15)
);
--2.teacher table
create table Teacher(
 teacher_id int Primary Key identity(1,1),
 first_name varchar(50) not null,
 last_name varchar(50) not null,
email varchar(50) not null unique);

--3.courses table
create table Courses (
course_id int Primary Key identity(1,1),
 course_name varchar(50) not null,
  credits int,
 teacher_id int,
 foreign key (teacher_id) references Teacher(teacher_id))

--4.enrollment table
 create table Enrollments(
  enrollment_id int Primary Key identity(1,1),
  student_id int,
  course_id int,
  enrollment_date date,
  foreign key (student_id) references Students (student_id),
  foreign key (course_id) references Courses (course_id),
  )
 
 --5.payment table
 create table Payments(
payment_id int Primary Key identity(1,1),
student_id int,
amount int,
payment_date date,
foreign key (student_id) references Students(student_id))


insert into Students(first_name, last_name, date_of_birth, email, phone_number) values
('fiza', 'saleem', '2000-01-15', 'fiza@gmail.com', '9876543210'),
('swetha', 'saravanan', '1999-05-22', 'swetha@gmail.com', '8765432109'),
('arjun', 'reddy', '2001-03-12', 'arjun@gmail.com', '7654321098'),
('vignesh', 'palanisamy', '2000-07-30', 'vignesh@gmail.com', '6543210987'),
('abinaya','sri', '1998-12-01', 'abinaya@gmail.com', '5432109876'),
('anusha', 'anand', '1997-09-14', 'anusha@yahoo.com', '4321098765'),
('fathima', 'fazluna', '2002-06-28', 'fathima@yahoo.com', '3210987654'),
('pranav', 'verma', '1996-11-11', 'pranav@gmail.com', '2109876543'),
('kavya', 'madhav', '1995-08-04', 'kavya@yahoo.com', '1098765432'),
('aditya', 'roy', '2003-02-22', 'aditya@yahoo.com', '0987654321');

insert into Teacher(first_name, last_name, email) values
('vani', 'shree', 'vani@gmail.com'),
('neetu', 'verma', 'neetu@gmail.com'),
('karen', 'mary', 'karen@gmail.com'),
('asha', 'jasmine', 'asha@gmail.com'),
('krishna', 'kumar', 'krishna@gmail.com'),
('mathi', 'vanan', 'mathivanan@gmail.com'),
('prince', 'brighty', 'prince@yahoo.com'),
('nitya', 'sri', 'nitya@yahoo.com'),
('isman', 'khan', 'isman@yahoo.com'),
('vishnu', 'durai', 'vishnu@yahoo.com');

insert into Courses(course_name, credits, teacher_id) values
('mathematics', 3, 1),
('science', 4, 2),
('history', 3, 3),
('economics', 2, 4),
('computer science', 4, 5),
('geography', 2, 6),
('robotics', 3, 7),
('physics', 4, 8),
('chemistry', 4, 9),
('biology', 2, 10);

insert into Enrollments (student_id, course_id, enrollment_date) values
(1, 1, '2024-09-03'),
(1, 2, '2024-09-01'),
(2, 1, '2024-09-02'),
(2, 3, '2024-09-12'),
(3, 4, '2024-09-08'),
(4, 5, '2024-09-01'),
(5, 6, '2024-09-01'),
(6, 7, '2024-09-02'),
(7, 8, '2024-09-03'),
(8, 9, '2024-09-08')

insert into Payments(student_id, amount, payment_date) values
(1, 1500, '2024-10-05'),
(2, 2000, '2024-10-06'),
(3, 1200, '2024-10-07'),
(4, 1800, '2024-10-08'),
(5, 2000, '2024-10-09'),
(6, 1500, '2024-10-10'),
(7, 1700, '2024-10-11'),
(8, 1600, '2024-10-12'),
(9, 1400, '2024-10-13'),
(10, 1300, '2024-10-14');

--TASK2

--1.Write an SQL query to insert a new student into the "Students" table with the following details:
insert into Students(first_name,last_name,date_of_birth,email,phone_number) values
('john','doe','1995-08-15','john.doe@example.com','1234567890');
select * from Students

--2.Write an SQL query to enroll a student in a course. Choose an existing student and course and insert a record into the "Enrollments" table with the enrollment date.
insert into Enrollments(student_id, course_id, enrollment_date) values
(11,10,'2024-09-11')
select * from Enrollments


--3.Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and
--modify their email address
update Teacher
set email='durai@gmail.com'
where first_name='vishnu'

--4.Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select
--an enrollment record based on the student and course.
delete from Enrollments 
where student_id=1 and course_id=2;

--5.Update the "Courses" table to assign a specific teacher to a course. Choose any course and
--teacher from the respective tables.
update Courses
set teacher_id=6
where course_name='physics'

/*6.Delete a specific student from the "Students" table and remove all their enrollment records
from the "Enrollments" table. Be sure to maintain referential integrity*/

alter table Enrollments
add constraint FK_Enrollments_Students
foreign key (student_id) references Students(student_id) on delete cascade;

 delete from Enrollments
 where student_id=2
 select * from Enrollments

 drop constraint FK_Enrollments_Students

 SELECT constraint_name 
FROM information_schema.table_constraints 
WHERE table_name = 'Enrollments' 
  AND constraint_type = 'FOREIGN KEY';

 

/*7.Update the payment amount for a specific payment record in the "Payments" table. Choose any
--payment record and modify the payment amount.*/

update Payments
set amount=1600
where student_id=2;

select *from Payments


--TASK3 

/*1. Write an SQL query to calculate the total payments made by a specific student. You will need to
join the "Payments" table with the "Students" table based on the student's ID*/

select concat_ws(' ',first_name,last_name)as Student_Name, sum(amount) as total_payment
from Students join Payments
on Students.student_id = Payments.student_id
--where Students.student_id=8
group by
 Students.first_name,Students.last_name,Students.student_id;


/*2. Write an SQL query to retrieve a list of courses along with the count of students enrolled in each
course. Use a JOIN operation between the "Courses" table and the "Enrollments" table */
select course_name, count(student_id) as student_count
from Courses join Enrollments
on Courses.course_id = Enrollments.course_id
group by Courses.course_name;


/*3.Write an SQL query to find the names of students who have not enrolled in any course. Use a
LEFT JOIN between the "Students" table and the "Enrollments" table to identify students
without enrollments.*/

select concat_ws(' ',first_name,last_name)as Student_Name
from Students 
left join Enrollments 
on Students.student_id = Enrollments.student_id
where course_id is null

     
/*4.Write an SQL query to retrieve the first name, last name of students, and the names of the
courses they are enrolled in. Use JOIN operations between the "Students" table and the
"Enrollments" and "Courses" tables.*/

select first_name , last_name , course_name 
from Students 
join Enrollments on Students.student_id = Enrollments.student_id
join Courses on Enrollments.course_id = Courses.course_id

/*5.Create a query to list the names of teachers and the courses they are assigned to. Join the
"Teacher" table with the "Courses" table  */

select concat_ws(' ',first_name,last_name)as Teacher_name, course_name
from Teacher join Courses
on teacher.teacher_id = Courses.teacher_id

/*6. Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the
"Students" table with the "Enrollments" and "Courses" tables.  */

select concat_ws(' ',first_name,last_name)as Student_Name, enrollment_date
from Students join Enrollments on 
Students.student_id = Enrollments.student_id
join Courses on Enrollments.course_id = Courses.course_id
where course_name='biology'

/* 7. Find the names of students who have not made any payments. Use a LEFT JOIN between the
"Students" table and the "Payments" table and filter for students with NULL payment records.*/ 

select concat_ws(' ',first_name,last_name)as Student_Name , payment_id from 
Students s left join Payments p on
s.student_id = p.student_id
where p.payment_id is null

/*8. Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN
between the "Courses" table and the "Enrollments" table and filter for courses with NULL
enrollment records */

select c.course_id , course_name , enrollment_id 
from Courses c left join Enrollments e
on c.course_id = e.course_id 
where enrollment_id is null

/* 9. Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments"
table to find students with multiple enrollment records. */

INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 3, '2024-09-15'),  
(2, 4, '2024-09-16');  

select* from Enrollments

select e.student_id from  
Enrollments e join Enrollments en
on e.student_id= en.student_id
group by e.student_id
having count(e.course_id)> 1 
--alternate 
select student_id from Enrollments
group by student_id
having count(distinct course_id)>1


/*10. Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher"
table and the "Courses" table and filter for teachers with NULL course assignments.*/

select t.teacher_id, concat_ws(' ',first_name,last_name) as Teacher_name , c.course_id
from Teacher t  left join courses c
on t.teacher_id = c.teacher_id
where course_id is  null;

--TASK4

/*1.Write an SQL query to calculate the average number of students enrolled in each course. Use
aggregate functions and subqueries to achieve this */

select course_name , (select count (student_id) from Enrollments e where e.course_id = c.course_id) as student_count
from Courses c 

/*2.Identify the student(s) who made the highest payment. Use a subquery to find the maximum
payment amount and then retrieve the student(s) associated with that amount*/

select student_id , concat_ws(' ',first_name,last_name) from Students where student_id in
(select student_id from payments where amount=(select max(amount)from payments));
--alt
select student_id,amount from Payments
where amount =(select max(amount) from payments)


/*. 3. Retrieve a list of courses with the highest number of enrollments. Use subqueries to find the 
course(s) with the maximum enrollment count */

select top 1 course_id as cid, count(enrollment_id) as maxeid
from Enrollments
group by course_id
order by maxeid desc


/*4. Calculate the total payments made to courses taught by each teacher. Use subqueries to sum
payments for each teacher's courses. */

select t.teacher_id , concat_ws(' ',first_name,last_name)  as Teacher_name ,
(select sum(p.amount) 
from Payments p 
join Enrollments e 
on p.student_id=e.student_id 
join Courses c
on e.course_id = c.course_id
where c.teacher_id = t.teacher_id
)as total_payment from  Teacher t

/* 5. Identify students who are enrolled in all available courses. Use subqueries to compare a
student's enrollments with the total number of courses.*/

select s.student_id , CONCAT_WS(' ',s.first_name,s.last_name)
from Students s 
where(select count(*) from enrollments e where e.student_id = s.student_id) = (select count(c.course_id) from courses c)

/*6. Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to
find teachers with no course assignments. */

select t.teacher_id , CONCAT_WS(' ',t.first_name, t.last_name)
from Teacher t
where t.teacher_id not in (select c.teacher_id from  Courses c )


/* 7. Calculate the average age of all students. Use subqueries to calculate the age of each student
based on their date of birth.*/

select avg(age) as average_age from (
select s.student_id , datediff(year, s.date_of_birth, GETDATE()) as  age from students  s) as studentsage

/*8. Identify courses with no enrollments. Use subqueries to find courses without enrollment
records */

select course_id ,course_name from courses 
where  course_id not in
(select course_id from Enrollments)

/*9. Calculate the total payments made by each student for each course they are enrolled in. Use
subqueries and aggregate functions to sum payments.*/
select s.student_id, CONCAT_WS(' ',s.first_name, s.last_name) as Student_name, course_name,
(select sum(amount) from Payments p
  where p.student_id =s.student_id ) as total_payment
  from Students s 
  join Enrollments e 
  on s.student_id = e.student_id
  join Courses c
  on e.course_id = c.course_id;

  /* 10. Identify students who have made more than one payment. Use subqueries and aggregate
functions to count payments per student and filter for those with counts greater than one.*/

select s.student_id , CONCAT_WS(' ',s.first_name, s.last_name) as Student_name from 
students s where s.student_id in(select p.student_id from Payments p group by p.student_id having count(p.student_id)>1)


/* 11. Write an SQL query to calculate the total payments made by each student. Join the "Students"
table with the "Payments" table and use GROUP BY to calculate the sum of payments for each
student.*/

select s.student_id , CONCAT_WS(' ',first_name,last_name)as Student_name, sum(p.amount)as totalamount
from 
Students s inner join Payments p
on s.student_id = p.student_id 
group by s.student_id, s.first_name, s.last_name


/*12. Retrieve a list of course names along with the count of students enrolled in each course. Use
JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to
count enrollments */

select course_name,  count(student_id) as student_count from 
Courses join Enrollments
on Courses.course_id = Enrollments.course_id
group by course_name

/* 13. Calculate the average payment amount made by students. Use JOIN operations between the
"Students" table and the "Payments" table and GROUP BY to calculate the average.*/

select s.student_id , avg(amount) as average_amount 
from students s join Payments p
on s.student_id = p.student_id 
group  by s.student_id


