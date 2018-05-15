-- Simple Inner Join, returns subscribers who subscribed both to newspaper and online version of magazine.
-- Inner Join basically returns records that have matching values in both tables
SELECT COUNT(*)
FROM newspaper
JOIN online ON newspaper.id = online.id;


-- Simple Inner Join with foreign key, extends classes table with students of each class
SELECT * FROM classes
JOIN students ON classes.id = students.class_id;


-- Left (Outer) Join, returns subscribers who does not subscribed to online version.
-- Basically Left (Outer) Join returns all rows from left table
-- and rows from the right table that follows certain condition
SELECT *
FROM newspaper
LEFT JOIN online
  ON newspaper.id = online.id
WHERE online.id IS NULL;


-- Right (Outer) Join, returns subscribers who does not subscribed to newspaper version.
-- Basically Right (Outer) Join returns all rows from !right table
-- and rows from the left table that follows certain condition
SELECT *
FROM newspaper
RIGHT JOIN online ON newspaper.id = online.id
WHERE newspaper.id IS NULL;


-- Full (Outer) Join return all records when there is a match in either left (newspaper)
-- or right (online) table records. In this case ordered by newspaper id.
SELECT *
FROM newspaper
FULL JOIN online ON newspaper.id = online.id
ORDER BY newspaper.id;


-- Cross Join, returns month and count of this month from crossed table of newspaper
-- and month where start_month > month < end_month
-- Cross Join basically multiply 2 tables
SELECT month, COUNT(*) FROM newspaper
CROSS JOIN months
WHERE month > start_month
	AND month < end_month
GROUP BY month;


-- Union combines two tables, second table rows starts where first table rows ends
SELECT * FROM newspaper
UNION
SELECT * FROM online;


-- Returns customers names and calculated value of their subscriptions
-- WITH helps to combine two tables, where one of the tables is the result of another calculation.
WITH previous_query AS (
  SELECT customer_id,
  COUNT(subscription_id) as subscriptions
  FROM orders
  GROUP BY customer_id
  )
SELECT customers.customer_name,
previous_query.subscriptions
FROM previous_query
JOIN customers
	ON customers.customer_id = previous_query.customer_id;