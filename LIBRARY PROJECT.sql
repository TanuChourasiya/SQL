create database library_db;

USE library_db;

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(50),
    genre VARCHAR(30),
    total_copies INT,
    available_copies INT
);

CREATE TABLE members (
    member_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    join_date DATE
);

CREATE TABLE borrow (
    borrow_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    due_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO books VALUES
(1, 'Harry Potter', 'J.K. Rowling', 'Fantasy', 10, 7),
(2, 'Atomic Habits', 'James Clear', 'Self-Help', 5, 2),
(3, 'The Alchemist', 'Paulo Coelho', 'Fiction', 8, 8),
(4, 'Rich Dad Poor Dad', 'Robert Kiyosaki', 'Finance', 6, 1);

INSERT INTO members VALUES
(101, 'Tanu Chourasiya', 'tanu@example.com', '9876543210', '2024-01-12'),
(102, 'Riya Sharma', 'riya@example.com', '8855332211', '2024-01-13'),
(103, 'Aman Gupta', 'aman@example.com', '7999324567', '2024-01-14');

INSERT INTO borrow VALUES
(1001, 101, 1, '2024-02-01', NULL, '2024-02-10'),
(1002, 102, 4, '2024-02-03', '2024-02-12', '2024-02-11'),
(1003, 103, 2, '2024-02-05', NULL, '2024-02-15');

#Show all books
select * from books;

#Show all library members
select * from members;

#Show the titles of all books only
select title from books;

#Show books written by author "Paulo Coelho"
select * from books
where author = "Paulo Coelho";

#Show books that still have available copies
select * from books
where available_copies > 0;

#Sort books in alphabetical order
select * from books
order by title ASC;

#Count number of books in library
select count(*) as total_books
from books;

#Count how many books are currently borrowed
select count(*) as borrowed_books
from borrow
where return_date Is null;

#Change phone number of a member
update members
set phone = '9999999999'
where member_id = 102;

use library_db;

#List members who joined in February 2024.
SELECT *
FROM members
WHERE MONTH(join_date) = 2 AND YEAR(join_date) = 2024;


#Show details of members who have not returned any books yet (return_date IS NULL).
select m.member_id,m.name,b.book_id,b.borrow_date,b.due_date
from members m
join borrow b
ON m.member_id=m.member_id
where return_date IS null;

#Find the total number of books borrowed by each member.
select m.member_id,m.name,count(b.borrow_id)as total_borrow
from members m
join borrow b
ON m.member_id=b.member_id
group by m.member_id,m.name;

use library_db;

#Show which member borrowed which book
select m.name,b.title,br.borrow_date
from borrow br
join members m on br.member_id = m.member_id
join books b on br.book_id = b.book_id;


#Count how many books each member borrowed
select m.name, count(br.borrow_id) as borrowed_book
from members m
left join  borrow br
on m.member_id=br.member_id
group by m.member_id;


#Books that have less than average available copies
SELECT title, available_copies
FROM books
WHERE available_copies < (
    SELECT AVG(available_copies) FROM books
);
#Create a view of complete borrowing details
CREATE VIEW borrow_details_view AS
SELECT br.borrow_id, m.name, b.title, br.borrow_date, br.return_date, br.due_date
FROM borrow br
JOIN members m ON br.member_id = m.member_id
JOIN books b ON br.book_id = b.book_id;

SELECT * FROM borrow_details_view;




