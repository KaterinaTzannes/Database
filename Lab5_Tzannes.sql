-- Katerina Tzannes
-- October 9,2017
-- Lab 5

-- 1.Show the cities of agents booking an order for a customer whose id is 'c006'
SELECT DISTINCT city
FROM agents a INNER JOIN orders o ON a.aid = o.aid
WHERE cid = 'c006';

-- 2.ids of products ordered through any agent who makes at least one order for a customer in Beijing, ASC
SELECT DISTINCT o2.pid
FROM Orders o INNER JOIN Customers c ON o.cid = c.cid
	INNER JOIN Agents ON c.city = 'Beijing'
	INNER JOIN Orders o2 ON o2.aid = o.aid
ORDER BY pid ASC;

--3.(subquery)Show the names of customers who have never placed an order.
SELECT DISTINCT name
FROM customers
WHERE cid NOT IN (SELECT cid
		  FROM orders
		  );

--4.(outer join)Show the names of customers who have never placed an order.
SELECT DISTINCT name
FROM customers
WHERE cid NOT IN (SELECT customers.cid
                  FROM customers RIGHT OUTER JOIN orders ON orders.cid = customers.cid
                  );

--5.customers name who placed an order through an agent in their own city + agent name
SELECT DISTINCT c.name, a.name
FROM Customers c INNER JOIN Orders o ON o.cid = c.cid
	INNER JOIN Agents a ON o.aid = a.aid
WHERE c.city = a.city;

--6.customers and agents living in the same city, along with the name of the shared city
SELECT DISTINCT c.name, a.name, c.city, a.city
FROM customers c INNER JOIN agents a ON c.city = a.city;

--7.name and city of customers who live in the city that makes the fewest different kinds of products\
SELECT DISTINCT c.name, c.city
FROM customers c INNER JOIN products p ON c.city = p.city
WHERE p.city IN (SELECT city
		FROM products
		GROUP BY city
		ORDER BY count(city) ASC
		Limit 1
		);