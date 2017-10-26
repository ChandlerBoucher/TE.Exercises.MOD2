-- The following queries utilize the "dvdstore" database.

USE DvdStore;

-- 1. All of the films that Nick Stallone has appeared in
-- (30 rows)

SELECT (first_name + ' ' + last_name) AS "full_name", film.title
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film.film_id = film_actor.film_id
WHERE (first_name + ' ' + last_name) = 'Nick Stallone';

-- 2. All of the films that Rita Reynolds has appeared in
-- (20 rows)

SELECT (first_name + ' ' + last_name) AS "full_name", film.title
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film.film_id = film_actor.film_id
WHERE (first_name + ' ' + last_name) = 'Rita Reynolds';

-- 3. All of the films that Judy Dean or River Dean have appeared in
-- (46 rows)

SELECT (first_name + ' ' + last_name) AS "full_name", film.title
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON  film.film_id = film_actor.film_id
WHERE (first_name + ' ' + last_name) = 'Judy Dean' OR (first_name + ' ' + last_name) = 'River Dean';

-- 4. All of the the ‘Documentary’ films
-- (68 rows)

SELECT category.name, film.title
FROM film 
JOIN film_category ON  film.film_id = film_category.film_id
JOIN category ON category.category_id = film_category.category_id
WHERE category.name = 'Documentary';

-- 5. All of the ‘Comedy’ films
-- (58 rows)

SELECT category.name, film.title
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON category.category_id = film_category.category_id
WHERE category.name = 'Comedy'; 

-- 6. All of the ‘Children’ films that are rated ‘G’
-- (10 rows)

SELECT category.name, film.title
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON category.category_id = film_category.category_id
WHERE category.name = 'Children' AND film.rating = 'G'; 

-- 7. All of the ‘Family’ films that are rated ‘G’ and are less than 2 hours in length
-- (3 rows)

SELECT category.name, film.title
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON category.category_id = film_category.category_id
WHERE category.name = 'Family' AND film.rating = 'G' AND length < 120;


-- 8. All of the films featuring actor Matthew Leigh that are rated ‘G’
-- (9 rows)

SELECT (first_name + ' ' + last_name) AS "full_name", film.title
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film.film_id = film_actor.film_id
WHERE (first_name + ' ' + last_name) = 'Matthew Leigh' AND rating = 'G'; 

-- 9. All of the ‘Sci-Fi’ films released in 2006
-- (61 rows)

SELECT title, release_year 
FROM film AS F
JOIN film_category AS FC ON F.film_id = FC.film_id
JOIN category AS C ON FC.category_id = C.category_id
WHERE C.name = 'Sci-Fi' AND release_year = '2006';

-- 10. All of the ‘Action’ films starring Nick Stallone
-- (2 rows)

SELECT (first_name + ' ' + last_name) AS "full_name", title
FROM actor AS A
JOIN film_actor AS FA ON A.actor_id = FA.actor_id
JOIN film AS F ON F.film_id = FA.film_id
JOIN film_category AS FC ON F.film_id = FC.film_id
JOIN category AS C ON FC.category_id = C.category_id
WHERE (first_name + ' ' + last_name) = 'Nick Stallone' AND C.name = 'Action';

-- 11. The address of all stores, including street address, city, district, and country
-- (2 rows)

SELECT store_id, A.address, A.address2, C.city, A.district, CTRY.country
FROM address AS A 
JOIN store AS S ON S.address_id = A.address_id
JOIN city AS C ON A.city_id = C.city_id
JOIN country AS CTRY ON C.country_id = CTRY.country_id;


-- 12. A list of all stores by ID, the store’s street address, and the name of the store’s manager
-- (2 rows)

SELECT S.store_id, A.address, A.address2, (STF.first_name + ' ' + STF.last_name)
FROM address AS A
JOIN store AS S ON A.address_id = S.address_id
JOIN staff AS STF ON S.manager_staff_id = STF.staff_id


-- 13. The first and last name of the top ten customers ranked by number of rentals 
-- (#1 should be “ELEANOR HUNT” with 46 rentals, #10 should have 39 rentals)

SELECT TOP 10 (C.first_name + ' ' + C.last_name) AS "full_name", COUNT(r.return_date) AS "rentals"
FROM customer AS C
JOIN rental AS R ON C.customer_id = R.customer_id
GROUP BY C.first_name, C.last_name
ORDER BY rentals DESC;

-- 14. The first and last name of the top ten customers ranked by dollars spent 
-- (#1 should be “KARL SEAL” with 221.55 spent, #10 should be “ANA BRADLEY” with 174.66 spent)

SELECT TOP 10 (C.first_name + ' ' + C.last_name) AS "full_name", SUM(P.amount) AS "spent"
FROM customer AS C
JOIN payment AS P ON C.customer_id = P.customer_id
GROUP BY C.first_name, C.last_name
ORDER BY spent DESC;

-- 15. The store ID, street address, total number of rentals, total amount of sales (i.e. payments), and average sale of each store 
-- (Store 1 has 7928 total rentals and Store 2 has 8121 total rentals)

SELECT S.store_ID, A.address, A.address2, 
(
	SELECT count(*) FROM rental
	JOIN inventory AS I ON s.store_id = I.store_id  
	WHERE rental.inventory_id = I.inventory_id AND I.store_id = S.store_id
) AS "rentals", SUM(P.amount) AS "sales", AVG(P.amount) AS "average_sales"
FROM store AS S
JOIN address AS A ON S.address_id = A.address_id
JOIN staff AS STF ON S.store_id = STF.staff_id
JOIN rental AS R ON STF.staff_id = R.staff_id
JOIN payment AS P ON R.rental_id = P.rental_id
GROUP BY S.store_id, A.address, A.address2

--Variance in answer because actual number of rentals is 16044 while there were 16049 payments made, assumedly all 
--in store 2? Variance begins @ rental.rental_id row 320

--SELECT COUNT(*) AS "rentals", SUM(P.amount) AS "sales", AVG(P.amount) AS "average_sales"
--FROM rental AS R 
--JOIN payment AS P ON R.rental_id = P.rental_id

--SELECT COUNT(*) FROM payment;
--SELECT COUNT(*) FROM rental; 

-- 16. The top ten film titles by number of rentals
-- (#1 should be “BUCKET BROTHERHOOD” with 34 rentals and #10 should have 31 rentals)

SELECT TOP 10 title, COUNT(R.rental_id) AS "rentals"
FROM film AS F
JOIN inventory AS I ON F.film_id = I.film_id
JOIN rental AS R ON I.inventory_id = R.inventory_id
GROUP BY title
ORDER BY rentals DESC;

-- 17. The top five film categories by number of rentals 
-- (#1 should be “Sports” with 1179 rentals and #5 should be “Family” with 1096 rentals)

SELECT TOP 5 C.name, COUNT(R.rental_id) AS "rentals"
FROM category AS C
JOIN film_category AS FC ON FC.category_id = C.category_id
JOIN film AS F ON FC.film_id = F.film_id
JOIN inventory AS I ON F.film_id = I.film_id
JOIN rental AS R ON I.inventory_id = R.inventory_id
GROUP BY C.name
ORDER BY rentals DESC;

-- 18. The top five Action film titles by number of rentals 
-- (#1 should have 30 rentals and #5 should have 28 rentals)

SELECT TOP 5 F.title, COUNT(R.rental_id) AS "rentals"
FROM category AS C
JOIN film_category AS FC ON FC.category_id = C.category_id
JOIN film AS F ON FC.film_id = F.film_id
JOIN inventory AS I ON F.film_id = I.film_id
JOIN rental AS R ON I.inventory_id = R.inventory_id
WHERE C.name = 'Action'
GROUP BY F.title
ORDER BY rentals DESC;

-- 19. The top 10 actors ranked by number of rentals of films starring that actor 
-- (#1 should be “GINA DEGENERES” with 753 rentals and #10 should be “SEAN GUINESS” with 599 rentals)

SELECT TOP 10 (A.first_name + ' ' + A.last_name) AS "full_name", COUNT(R.rental_id) AS "rentals"
FROM actor AS A
JOIN film_actor AS FA ON FA.actor_id = A.actor_id
JOIN film AS F ON FA.film_id = F.film_id
JOIN inventory AS I ON F.film_id = I.film_id
JOIN rental AS R ON I.inventory_id = R.inventory_id
GROUP BY (A.first_name + ' ' + A.last_name), A.actor_id
ORDER BY rentals DESC;

-- 20. The top 5 “Comedy” actors ranked by number of rentals of films in the “Comedy” category starring that actor 
-- (#1 should have 87 rentals and #5 should have 72 rentals)

SELECT TOP 5 (A.first_name + ' ' + A.last_name) AS "full_name", COUNT(R.rental_id) AS "rentals"
FROM actor AS A
JOIN film_actor AS FA ON FA.actor_id = A.actor_id
JOIN film_category AS FC ON FC.film_id = FA.film_id
JOIN film AS F ON FA.film_id = F.film_id
JOIN category AS C ON FC.category_id = C.category_id
JOIN inventory AS I ON F.film_id = I.film_id
JOIN rental AS R ON I.inventory_id = R.inventory_id
WHERE C.name = 'Comedy'
GROUP BY (A.first_name + ' ' + A.last_name)
ORDER BY rentals DESC;