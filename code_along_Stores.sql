/*
How many female customers do we have from the state of Oregon (OR) and New York (NY)
*/

SELECT COUNT(customerid) FROM "public"."customers" 
WHERE state='OR' AND gender='F' 
OR state='NY' AND gender='F';

SELECT firstname, lastname, gender FROM "public"."customers" 
WHERE state='OR' AND gender='F' 
OR state='NY' AND gender='F';

-- or with parentheses (boolean algebra)...
SELECT firstname, lastname, gender FROM "public"."customers" 
WHERE (state='OR' OR state='NY') AND gender='F'; -- AND gets applied for both cases (states)

-- How many customers aren't 55?
SELECT COUNT(customerid) FROM "public"."customers"
WHERE NOT age = '55'; 

SELECT age FROM "public"."customers"
WHERE NOT age = '55';

/*
Comparison Operators:
Who over the age of 44 has an income of 100,000
*/
SELECT customerid 
FROM "public"."customers"
WHERE age > 44 AND income >= 100000;

/*
Comparison Operators:
Who between the ages of 30 and 50 has an income of less than 50,000?
*/
SELECT customerid 
FROM "public"."customers"
WHERE age >= 30 AND age <=50 AND income <= 50000;

/*
Comparison Operators:
What is the average income between the ages of 20 and 50?
*/
SELECT AVG(income) FROM "public"."customers"
WHERE age > 20 AND age < 50;

-- Multiple filters
SELECT income, gender, state, age FROM "public"."customers"
WHERE 
(
income > 10000 AND state = 'NY'
OR (
    (age > 20 AND age < 30)
    AND income <= 20000
    )
)
AND gender = 'F'; -- of the set of results from above have to be female
/*
Filter 1: income > 10000, from NY and female
Filter 2: age between 21 and 29, salary lower than 20000 and female
*/

-- EXERCISES

-- Display the null values as 'No Adress'
SELECT COALESCE(address2, 'No Adress') FROM "customers";

-- Fix query to proper 3VL
SELECT * FROM customers WHERE address2 IS NOT NULL;

-- Fix query to proper 3VL
SELECT COALESCE(lastname, 'Empty'), * FROM customers WHERE age IS NULL;

-- who between ages 30 and 50 has an income less than 50000?
SELECT * FROM customers 
WHERE (age BETWEEN 30 AND 50) 
AND income < 50000;

-- what is the average income between the ages of 20 and 50, including 20 and 50?
SELECT AVG(income) FROM customers 
WHERE age BETWEEN 20 AND 50;

SELECT COUNT(orderid) FROM orders
WHERE customerid IN (7888,1082,12808,9623);

/* exercise: How many orders were made in January 2004?
select the total number of orders from orders 
where the trunc (round down) of the month in the column orderdate is round down to date '2004-01-01'.
all dates with january as month bill be trunc/rounded down to 01-01. So this is the sum of orders in Jan
*/
SELECT COUNT(orderid) FROM orders
WHERE date_trunc ('month', orderdate) = DATE '2004-01-01';

-- Exercises
-- Get all orders from customers who live in Ohio (OH), New York (NY) or Oregon (OR) state
-- ordered by orderid

-- my solution:
SELECT c.customerid, c.state, o.orderid
FROM customers AS c
INNER JOIN orders AS o
ON c.customerid = o.customerid
WHERE c.state IN ('OH','NY','OR')
ORDER BY o.orderid ASC;

-- MoBinnis solution:
SELECT c.customerid, c.state, o.orderid
FROM orders AS o
INNER JOIN customers AS c
ON c.customerid = o.customerid
WHERE c.state IN ('OH','NY','OR')
ORDER BY o.orderid ASC;

-- Show the inventory for each product
SELECT products.prod_id, inventory.quan_in_stock
FROM products
INNER JOIN inventory
ON products.prod_id = inventory.prod_id;