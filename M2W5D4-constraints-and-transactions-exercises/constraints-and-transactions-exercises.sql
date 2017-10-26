-- Write queries to return the following:
-- The following changes are applied to the "pagila" database.**
use pagila;

BEGIN TRANSACTION
-- 1. Add actors, Hampton Avenue, and Lisa Byway to the actor table.

INSERT INTO actor
(first_name, last_name)
VALUES
('Hampton', 'Avenue'), ('Lisa','Byway');

-- 2. Add "Euclidean PI", "The epic story of Euclid as a pizza delivery boy in 
-- ancient Greece", to the film table. The movie was released in 2008 in English. 
-- Since its an epic, the run length is 3hrs and 18mins. There are no special 
-- features, the film speaks for itself, and doesn't need any gimmicks.	

INSERT INTO film
(title, description, release_year, language_id, length)
VALUES
('Euclidian PI', 'The epic story of Euclid as a pizza delivery boy in 
-- ancient Greece', 2008, 1, 198);

UPDATE film
SET title = 'Euclidean PI'
WHERE film_id = 1001;

-- 3. Hampton Avenue plays Euclid, while Lisa Byway plays his slightly 
-- overprotective mother, in the film, "Euclidean PI". Add them to the film.

INSERT INTO film_actor
(actor_id, film_id)
VALUES
(201, 1001), (202, 1001);

-- 4. Add Mathmagical to the category table.

INSERT INTO category
(name)
VALUES
('Mathmagical');
-- 5. Assign the Mathmagical category to the following films, "Euclidean PI", 
-- "EGG IGBY", "KARATE MOON", "RANDOM GO", and "YOUNG LANGUAGE"

SELECT title, film_id FROM film WHERE title IN ('Euclidean PI', 'EGG IGBY', 'KARATE MOON', 'RANDOM GO', 'YOUNG LANGUAGE')

INSERT INTO film_category
(category_id, film_id)
VALUES
(17, 1001);

UPDATE film_category
SET category_id = '17'
WHERE film_id IN (996, 714, 494, 274);

-- 6. Mathmagical films always have a "G" rating, adjust all Mathmagical films 
-- accordingly.
-- (5 rows affected)
BEGIN TRANSACTION

UPDATE film
SET rating = 'G'
WHERE title IN (
SELECT F.title
FROM film AS F
JOIN film_category AS FC ON FC.film_id = F.film_id 
JOIN category AS C ON C.category_id = FC.category_id
WHERE C.category_id = 17);

ROLLBACK TRANSACTION
-- 7. Add a copy of "Euclidean PI" to all the stores.

INSERT INTO inventory
(film_id, store_id)
VALUES
(1001, 1), (1001, 2);

-- 8. The Feds have stepped in and have impounded all copies of the pirated film, 
-- "Euclidean PI". The film has been seized from all stores, and needs to be 
-- deleted from the film table. Delete "Euclidean PI" from the film table. 
-- (Did it succeed? Why?)

BEGIN TRANSACTION

DELETE 
FROM film
WHERE title = 'Euclidean PI';


--It does not succeed because other tables rely on the data, deleting the record would then violate a reference constraint
--which causes the statement to terminate  

-- 9. Delete Mathmagical from the category table. 
-- (Did it succeed? Why?)
BEGIN TRANSACTION

DELETE 
FROM category
WHERE name = 'Mathmagical';

--It does not succeed for the same reason as the last, restraint conflict.

-- 10. Delete all links to Mathmagical in the film_category tale. 
-- (Did it succeed? Why?)
BEGIN TRANSACTION

DELETE 
FROM film_category
WHERE category_id = 17;

--It succeeded, because other table's keys did not rely on it.

-- 11. Retry deleting Mathmagical from the category table, followed by retrying
-- to delete "Euclidean PI". 
-- (Did either deletes succeed? Why?)

BEGIN TRANSACTION

DELETE 
FROM category
WHERE name = 'Mathmagical';

DELETE 
FROM film
WHERE title = 'Euclidean PI';

--deleting the category is successful because we deleted the table entries in film_category that referenced it

-- 12. Check database metadata to determine all constraints of the film id, and 
-- describe any remaining adjustments needed before the film "Euclidean PI" can 
-- be removed from the film table.

--We have to remove the entries in film_actor that reference the film Euclidean PI