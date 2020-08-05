--Day 3 SQL Assignment

--1. List all customers who live in Texas
SELECT first_name, last_name, address_id
FROM customer
WHERE address_id in(
	SELECT address_id 
	FROM address
	WHERE district LIKE 'Texas'
);

--2. Get all payments above 6.99 with the customers full name
SELECT customer.customer_id, first_name, last_name, payment.amount 
FROM customer
RIGHT JOIN payment 
ON customer.customer_id = payment.customer_id
WHERE payment.amount > 6.99

--3. Show all customers names who have made payments over 175.00 - subqueries

SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id in (
	SELECT customer_id 
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175.00
);

--4. Show all customers that live in Nepal( use the city table

SELECT customer.address_id, first_name, last_name
FROM customer
FULL JOIN address ON customer.address_id = address.address_id
FULL JOIN city ON address.city_id = city.city_id
FULL JOIN country ON city.country_id = country.country_id
WHERE country LIKE 'Nepal' ;


--5. Which staff member had the most trancactions

SELECT staff.staff_id, staff.first_name, staff.last_name, COUNT(rental.staff_id)
FROM staff
INNER JOIN rental ON staff.staff_id =  rental.staff_id
GROUP BY staff.staff_id
ORDER BY Count(*) DESC
LIMIT 1;


--6. How many movies of each rating are there?

SELECT film.rating, count(inventory.film_id) as inv_num_per_rating
FROM film
INNER JOIN inventory ON film.film_id  = inventory.film_id
GROUP BY film.rating
ORDER BY COUNT(inventory.film_id) DESC


--7.Show all customers who have made a single payment above 6.99 - subquery
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id in (	
	SELECT distinct(customer_id) 
	FROM payment
	where amount > 6.99
	Group BY customer_id	
	Having Count(customer_id) = 1
	
)	

--Result check query
---select customer_id, amount from payment
---where amount > 6.99
---order by customer_id


--8. How many free rentals did our stores give away
SELECT COUNT(payment_id) as num_zero_payments
FROM payment
WHERE amount = 0

--Result check query
--select * from payment
--where amount = 0

