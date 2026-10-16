-- =====================================================================
-- Online Bookstore - SQL Fundamentals Assignment
-- Database : MySQL 8.0
-- =====================================================================

-- ---------------------------------------------------------------------
-- Database Setup
-- ---------------------------------------------------------------------
CREATE DATABASE bookstore;
USE bookstore;

-- ---------------------------------------------------------------------
-- Table: Authors
-- ---------------------------------------------------------------------
CREATE TABLE Authors (
    author_id   INT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    country     VARCHAR(50)
);

-- ---------------------------------------------------------------------
-- Table: Books
-- ---------------------------------------------------------------------
CREATE TABLE Books (
    book_id        INT PRIMARY KEY,
    title          VARCHAR(100) NOT NULL,
    author_id      INT,
    category       VARCHAR(50),
    price          DECIMAL(10,2),
    published_year INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- ---------------------------------------------------------------------
-- Sample Data: Authors (6 authors from 6 different countries)
-- Paulo Coelho has no books, which shows up in the LEFT JOIN (Task 16).
-- ---------------------------------------------------------------------
INSERT INTO Authors (author_id, author_name, country) VALUES
(1, 'Robert C. Martin',  'USA'),
(2, 'Chetan Bhagat',     'India'),
(3, 'Yuval Noah Harari', 'Israel'),
(4, 'J.K. Rowling',      'United Kingdom'),
(5, 'Haruki Murakami',   'Japan'),
(6, 'Paulo Coelho',      'Brazil');

-- ---------------------------------------------------------------------
-- Sample Data: Books (12 books across 4 categories)
-- ---------------------------------------------------------------------
INSERT INTO Books (book_id, title, author_id, category, price, published_year) VALUES
(1,  'Clean Code',                                1, 'Programming', 899.00, 2008),
(2,  'Clean Architecture',                        1, 'Programming', 749.00, 2017),
(3,  'Clean Craftsmanship',                       1, 'Programming', 999.00, 2021),
(4,  'Sapiens',                                   3, 'History',     650.00, 2014),
(5,  'Homo Deus',                                 3, 'History',     599.00, 2016),
(6,  'Nexus',                                     3, 'History',     799.00, 2024),
(7,  'Five Point Someone',                        2, 'Fiction',     199.00, 2004),
(8,  '400 Days',                                  2, 'Fiction',     299.00, 2021),
(9,  'Harry Potter and the Philosopher''s Stone', 4, 'Fantasy',     499.00, 1997),
(10, 'The Christmas Pig',                         4, 'Fantasy',     699.00, 2021),
(11, 'Norwegian Wood',                            5, 'Fiction',     450.00, 1987),
(12, 'South of the Border, West of the Sun',      5, 'Fiction',     399.00, 1992);


-- =====================================================================
-- Section 1: Basic Queries
-- =====================================================================

-- Task 1: Display all books.
SELECT * FROM Books;

-- Task 2: Display only the book title and price.
SELECT title, price FROM Books;

-- Task 3: Display the book title as Book Name and price as Book Price.
SELECT title AS `Book Name`,
       price AS `Book Price`
FROM Books;

-- Task 4: Display all unique book categories.
SELECT DISTINCT category FROM Books;


-- =====================================================================
-- Section 2: Filtering Data
-- =====================================================================

-- Task 5: Display books priced above 700.
SELECT * FROM Books
WHERE price > 700;

-- Task 6: Display books priced between 500 and 800 (inclusive).
SELECT * FROM Books
WHERE price BETWEEN 500 AND 800;

-- Task 7: Display books that belong to the Programming category.
SELECT * FROM Books
WHERE category = 'Programming';

-- Task 8: Display books whose titles start with the letter S.
SELECT * FROM Books
WHERE title LIKE 'S%';

-- Task 9: Display books published after 2020.
SELECT * FROM Books
WHERE published_year > 2020;


-- =====================================================================
-- Section 3: Sorting and Limiting Results
-- =====================================================================

-- Task 10: Display books sorted by price in descending order.
SELECT * FROM Books
ORDER BY price DESC;

-- Task 11: Display the top 3 most expensive books.
SELECT * FROM Books
ORDER BY price DESC
LIMIT 3;


-- =====================================================================
-- Section 4: Aggregate Functions
-- =====================================================================

-- Task 12: Total number of books, total price, average price,
--          highest price and lowest price.
SELECT COUNT(*)             AS `Total Books`,
       SUM(price)           AS `Total Price`,
       ROUND(AVG(price), 2) AS `Average Price`,
       MAX(price)           AS `Highest Price`,
       MIN(price)           AS `Lowest Price`
FROM Books;


-- =====================================================================
-- Section 5: GROUP BY and HAVING
-- =====================================================================

-- Task 13: Display the average book price for each category.
SELECT category,
       ROUND(AVG(price), 2) AS `Average Price`
FROM Books
GROUP BY category;

-- Task 14: Display only those categories whose average price is greater than 650.
SELECT category,
       ROUND(AVG(price), 2) AS `Average Price`
FROM Books
GROUP BY category
HAVING AVG(price) > 650;


-- =====================================================================
-- Section 6: Joins
-- =====================================================================

-- Task 15: Display each book along with its author's name (INNER JOIN).
SELECT b.book_id,
       b.title,
       a.author_name
FROM Books b
INNER JOIN Authors a
        ON b.author_id = a.author_id;

-- Task 16: Display all authors along with the books they have written (LEFT JOIN).
--          Authors without books still appear, with NULL for the book columns.
SELECT a.author_id,
       a.author_name,
       b.title
FROM Authors a
LEFT JOIN Books b
       ON a.author_id = b.author_id;

-- Task 17: Display all books along with their author details (RIGHT JOIN).
SELECT b.book_id,
       b.title,
       a.author_id,
       a.author_name,
       a.country
FROM Authors a
RIGHT JOIN Books b
        ON a.author_id = b.author_id;


-- =====================================================================
-- Section 7: Data Manipulation
-- =====================================================================

-- Task 18: Insert a new book into the Books table.
INSERT INTO Books (book_id, title, author_id, category, price, published_year)
VALUES (13, 'Clean Agile', 1, 'Programming', 650.00, 2019);

SELECT * FROM Books WHERE book_id = 13;

-- Task 19: Update the price of the book inserted above.
UPDATE Books
SET price = 725.00
WHERE book_id = 13;

SELECT * FROM Books WHERE book_id = 13;

-- Task 20: Delete the book record inserted above.
DELETE FROM Books
WHERE book_id = 13;

SELECT * FROM Books WHERE book_id = 13;


-- =====================================================================
-- Section 8: Creating Tables and Constraints
-- =====================================================================

-- Task 21: Create the Publishers table with PRIMARY KEY, NOT NULL,
--          UNIQUE and DEFAULT constraints.
CREATE TABLE Publishers (
    publisher_id     INT          PRIMARY KEY,
    publisher_name   VARCHAR(100) NOT NULL UNIQUE,
    country          VARCHAR(50)  NOT NULL DEFAULT 'India',
    established_year INT
);

DESCRIBE Publishers;

INSERT INTO Publishers (publisher_id, publisher_name, country, established_year) VALUES
(1, 'Penguin Random House', 'USA', 2013);

-- country is omitted here, so it takes the DEFAULT value 'India'.
INSERT INTO Publishers (publisher_id, publisher_name, established_year) VALUES
(2, 'Rupa Publications', 1936);

SELECT * FROM Publishers;
