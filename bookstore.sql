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
