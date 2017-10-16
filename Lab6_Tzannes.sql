-- Katerina Tzannes
-- Lab 6

--1.display name/city who live in any city and make the most products
SELECT DISTINCT c.name, c.city
FROM customers c INNER JOIN products p ON c.city = p.city
WHERE p.city IN (SELECT city
		 FROM products
		 GROUP BY city
		 ORDER BY count(city) DESC
		 Limit 1);

--2. names of products whose priceUSD is at or above the average priceUSD, in reverse-alphabetical order
SELECT name
FROM products
WHERE priceUSD >= (SELECT avg(priceUSD)
		  FROM products)
		  ORDER BY name DESC;

--3. customer name, pid ordered, and the total for all orders, sorted by total from low to high
SELECT customers.name, orders.pid, orders.totalUSD
FROM customers, orders
WHERE orders.cid = customers.cid
ORDER by orders.totalUSD DESC;

--4.all customer names DESC and their total ordered (coalesce to avoid Null)
SELECT DISTINCT c.name , coalesce(totalsum, 0)
FROM customers c, (SELECT o.cid as ordercid, sum(o.totalUSD) as totalsum
		   FROM orders o 
		   GROUP BY o.cid) as innert 
		   WHERE ordercid=c.cid
		   ORDER BY c.name DESC;

--5.names of all customers who bought products from agents based in Newark along with the names of the products they ordered, and the names of the agents who sold it to them
SELECT c.name, p.name, a.name
FROM customers c, agents a, products p, orders o
WHERE o.cid = c.cid
   AND o.aid = a.aid
   AND p.pid = o.pid
   AND a.city = 'Newark';

--6.check the accuracy of the totalUSD column in the Orders table
SELECT *
FROM customers , orders , products 
WHERE orders.pid = products.pid
  AND orders.cid = customers.cid
  AND orders.totalUSD != (orders.quantity * products.priceUSD - ((orders.quantity * products.priceUSD) * (customers.discountPct/100)));

-- 7.  difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN
-- A LEFT OUTER JOIN  allows you take the rows from the left table and join them with the rows of the right table.
-- Similarly, a RIGHT OUTER JOIN allows you to take the rows from the right side and join them with the left table.
-- The difference between a left and right outer join is which table values get displayed, when theres no match.
-- For example, the left side on the "on" predicate of the join will display ALL the results of the left table wheather a match was found or not.
-- The FULL OUTER JOIN shows everything

-- I'm loving easy SQL statements, not so much complicated ones yet though... one day 