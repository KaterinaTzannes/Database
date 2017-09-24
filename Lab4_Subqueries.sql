-- Katerina Tzannes
-- Lab 4
-- Professor Labouseur

-- 1. cities of agents booking order whose cid = c006
SELECT city
FROM agents
WHERE aid in (SELECT aid
	      FROM orders
	      WHERE cid = 'c006');

-- 2. distinct cid of products ordered through any agent
--    who takes at least one order from a customer in 
--    Beijing, sorted by pid from highest to lowest
SELECT distinct pid
FROM orders
WHERE aid in (SELECT aid
              FROM orders
              WHERE cid in (SELECT cid
                            FROM customers
                            WHERE city = 'Beijing'
                           )
              ) ORDER BY pid DESC;

-- 3. ids and names of customers who did not place an order through agent a03
SELECT cid, name
FROM customers
WHERE cid not in (SELECT distinct cid
                  FROM orders
                  WHERE aid = 'a03'
                 );

-- 4. ids of customers who ordered both product p01 and p07
SELECT cid
FROM customers
WHERE cid in (SELECT distinct cid
	      FROM orders
	      WHERE pid = 'p01' 
	      AND cid in (SELECT cid
			  FROM orders
			  WHERE pid = 'p07'
			  )
		);

-- 5. ids of products not ordered by any customers who placed any order
--    through agents a02 or a03, in pid order from highest to lowest
SELECT distinct pid 
FROM products 
WHERE pid not in (SELECT pid
		  FROM orders
		  WHERE aid = 'a02'
		  )
		  AND pid not in (SELECT pid
				  FROM orders
				  WHERE aid = 'a03'
				  ) ORDER BY pid DESC;

-- 6. name, discount, and city for all customers who place orders 
--    through agents in Tokyo or New York	
-- even though Tokyo isn't listed it should still be included for future		  
SELECT name, discountPct, city
FROM customers
WHERE cid in (SELECT distinct cid
	      FROM orders
              WHERE aid in (SELECT aid
			     FROM agents
                            WHERE city = 'Tokyo' or city = 'New York'
			    )
	      );    

-- 7. all customers who have the same discount as that of any customers in Duluth or London
-- since nobody has the same discount(curretly) only those in Dallas(or London) are listed
SELECT *
FROM customers
WHERE discountPct IN (
	SELECT discountPct
	FROM Customers
	WHERE Customers.city = 'Dallas' OR Customers.city = 'London'
);

-- 8. Constraints
-- According to Professor Algozzine, the 4 constraints of computer hardware are heat, power, noise, and space (money can also be included)
-- Check constraints (a completly different topic) is a SQL query that allows one to put limits on the values that are accepted into a column and/or table.
-- If the value entered doesn't satisfy the condition the value will not be inserted into the database.
-- An advantage would be if you did not want users under the age of 21 a check constraint may be used in the age column
-- A bad use of check constraints would be useing it in the name column to limit the amount of character in ones name. 
--      Good Use
--		CREATE TABLE users(
--			id int,
--			f_name text,
--			l_name text,
--			age int,
--			CHECK (age > 20) 
--		);
--	 Bad Use
--		CREATE TABLE users(
--			id int,
--			f_name text,
--			l_name text,
--			age int,
--			CHECK (f_name < 10) 
--		);
	      







	      


