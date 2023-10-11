SHOW DATABASES;

USE pubs;

SHOW TABLES;

DESCRIBE authors;

SELECT * FROM authors;

SELECT au_fname AS `First Name`, au_lname AS `Last Name` FROM authors
WHERE city='Palo Alto';

SELECT CONCAT(au_fname, ' ', au_lname) AS `Name` FROM authors
WHERE city='Palo Alto';

DESCRIBE titles;

SELECT * FROM titles;

SELECT COUNT(*) AS `Total number of books that cost more than $10`
FROM titles
WHERE price > 10.00;

SELECT title, price FROM titles
ORDER BY price DESC;

-- Select the title and price from the Titles table with the max price --
SELECT title as `Most Expensive Book`, price as `Price` FROM titles
WHERE price IS NOT NULL
ORDER BY price DESC
LIMIT 1;

-- Select the title and price from the Titles table with the min price --
SELECT title as `Cheapest Book`, price as `Price` FROM titles
WHERE price IS NOT NULL
ORDER BY price ASC
LIMIT 1;

-- Select the total price of all the books in the Titles table --
SELECT SUM(price) AS `Total price of all books` 
FROM titles;

-- Select the publishers with a city of 'Camden' and a state of 'NJ' from the Publishers table --
SELECT DISTINCT pub_name as `Publisher`
FROM publishers
WHERE city = 'Camden' AND state = 'NJ';

-- Select the publishers with a city of 'Camden' or 'Dallas' from the Publishers table --
SELECT DISTINCT pub_name as `Publisher`
FROM publishers
WHERE city = 'Camden' OR city = 'Dallas';

-- Update the previous query to use the IN keyword --
SELECT *
FROM publishers
WHERE city IN ('Camden', 'Dallas');

-- Select the publishers with a name like 'Pub'. --
-- Notice there are no results, that is because we don't use the wildcard symbol so the query is looking for names = 'Pub' --
SELECT * 
FROM publishers
WHERE pub_name = 'Pub';

-- Select the publishers with a name between 'A' and 'F'. --
-- Notice the publisher with the name 'F' is returned but the publisher 'Five Lakes Publishing' is not returned. That's because between works like a dictionary where the word 'Five' comes after the letter 'F' --
SELECT *
FROM publishers
WHERE pub_name BETWEEN 'A' AND 'F';

SELECT * FROM publishers;

-- Select the state and the number of publishers in each of those states --
-- from the Publishers table --
SELECT state as `State`, COUNT(state) as `Number of publishers in state` 
FROM publishers
WHERE state IS NOT NULL
GROUP BY state;

-- Select the distinct states from the Publishers table --
SELECT DISTINCT state 
FROM publishers
WHERE state IS NOT NULL;

-- Select the distinct states in ascending order of state name from the Publishers table --
SELECT DISTINCT state
FROM publishers
WHERE state IS NOT NULL
ORDER BY state ASC;

-- Select the publisher ID and total sales for each publisher in the Titles table --
-- where the publisher has more than 4 titles (if you're feeling bold --
-- you can join with the publisher table to get the publisher name rather than the ID) --
SELECT titles.pub_id, pub_name as `Publisher`, SUM(ytd_sales) as `Total Sales`
FROM titles
INNER JOIN publishers
ON titles.pub_id = publishers.pub_id
WHERE ytd_sales IS NOT NULL
GROUP BY pub_id
HAVING COUNT(*) > 4;

-- Write a query on the Titles table that shows the type with the highest total YTD sales --
SELECT * FROM titles;

SELECT `type` as `type of book`, SUM(ytd_sales) as `Total sales` 
FROM titles
WHERE ytd_sales IS NOT NULL
GROUP BY `type`
ORDER BY `Total sales` DESC
LIMIT 1;

SELECT * FROM authors;

-- Write a query on the number of Authors that are in each City in the state 'CA' --
SELECT city, COUNT(city)
FROM authors
WHERE state = 'CA'
GROUP BY city;

-- Write a query that returns a role of 'Publisher', 
-- the name of the publisher and the address of the publisher. 
-- note there are no extra spaces or commas when the city and state are null): --
SELECT * FROM publishers;

SELECT 'Publisher' as `Role`, pub_name as `Name`, 
CONCAT_WS(', ', city, state, country)
FROM publishers;
