-- Katerina Tzannes
-- Lab 3

select ordno, totalUSD
from orders;

select name, city
from agents where name = 'Smith';

select pid, name, priceUSD
from products where qty > 200010;

select name, city
from agents where city = 'Duluth';

select name, city
from agents where city != 'New York' AND city != 'Duluth';

select *
from products where city != 'Dallas' AND city != 'Duluth' AND priceUSD > 1.00;

select *
from orders where month = 'Mar' OR month = 'May';

select *
from orders where month = 'Feb' AND totalUSD > 500;

select *
from customers where cid = 'c005';