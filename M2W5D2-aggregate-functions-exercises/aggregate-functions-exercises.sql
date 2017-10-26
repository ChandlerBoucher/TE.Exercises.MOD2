-- The following queries utilize the "world" database.
-- Write queries for the following problems. 
-- Notes:
--   GNP is expressed in units of one million US Dollars
--   The value immediately after the problem statement is the expected number 
--   of rows that should be returned by the query.

<<<<<<< HEAD
USE world;

=======
>>>>>>> 9012ad2172576f682314ff0b2440295279543aa4
-- 1. The name and state plus population of all cities in states that border Ohio 
-- (i.e. cities located in Pennsylvania, West Virginia, Kentucky, Indiana, and 
-- Michigan).  
-- The name and state should be returned as a single column called 
-- name_and_state and should contain values such as ‘Detroit, Michigan’.  
-- The results should be ordered alphabetically by state name and then by city 
-- name. 
-- (19 rows)

<<<<<<< HEAD
SELECT (name + ', ' + district) AS "name_and_state", population FROM city 
WHERE district IN ('Pennsylvania', 'West Virginia', 'Kentucky', 'Indiana', 'Michigan')
ORDER BY district ASC, name ASC;

=======
>>>>>>> 9012ad2172576f682314ff0b2440295279543aa4
-- 2. The name, country code, and region of all countries in Africa.  The name and
-- country code should be returned as a single column named country_and_code 
-- and should contain values such as ‘Angola (AGO)’ 
-- (58 rows)

<<<<<<< HEAD
SELECT (name + ' ' + '(' + code + ')') AS "country_and_code", region FROM country
WHERE continent = 'Africa'
ORDER BY region ASC; 

=======
>>>>>>> 9012ad2172576f682314ff0b2440295279543aa4
-- 3. The per capita GNP (i.e. GNP multipled by 1000000 then divided by population) of all countries in the 
-- world sorted from highest to lowest. Recall: GNP is express in units of one million US Dollars 
-- (highest per capita GNP in world: 37459.26)

<<<<<<< HEAD
SELECT name, CAST((gnp * 1000000 / population )AS DECIMAL(38, 2)) AS "per_capita_gnp" FROM country 
WHERE population > 0
ORDER BY per_capita_gnp DESC;

--SELECT  CAST(AVG((gnp * 1000000 / population ))AS DECIMAL(38, 2)) AS "per_capita_gnp" FROM country
--WHERE population > 0;

-- 4. The average life expectancy of countries in South America.
-- (average life expectancy in South America: 70.9461)

SELECT continent, AVG(lifeexpectancy) AS "avg_life_expectancy" FROM country 
WHERE continent = 'South America'
GROUP BY continent;

-- 5. The sum of the population of all cities in California.
-- (total population of all cities in California: 16716706)

SELECT district, SUM(population) AS "total_population" FROM city
WHERE district = 'California'
GROUP BY district;

-- 6. The sum of the population of all cities in China.
-- (total population of all cities in China: 175953614)

SELECT country.name, SUM(city.population) AS "total_population" FROM city, country
WHERE countrycode = 'CHN' AND country.name = 'China'
GROUP BY country.name;

-- 7. The maximum population of all countries in the world.
-- (largest country population in world: 1277558000)

SELECT name, population 
FROM country 
WHERE population = (
	SELECT MAX(population) AS "largest_population"
	FROM country
);
-- 8. The maximum population of all cities in the world.
-- (largest city population in world: 10500000)
SELECT name, population 
FROM city 
WHERE population = (
	SELECT MAX(population)
	FROM city
);
-- 9. The maximum population of all cities in Australia.
-- (largest city population in Australia: 3276207)

SELECT name, population 
FROM city 
WHERE population = (
	SELECT MAX(population)
	FROM city
	WHERE countrycode = 'AUS'
);
	

-- 10. The minimum population of all countries in the world.
-- (smallest_country_population in world: 50)

SELECT name, population
FROM country
WHERE population = (
	SELECT MIN(population)
	FROM country
	WHERE population > 0
);

-- 11. The average population of cities in the United States.
-- (avgerage city population in USA: 286955.3795)

SELECT country.name, AVG(city.population)
FROM country, city
WHERE country.name = ( 
	SELECT name 
	FROM country
	WHERE code = 'USA'
)
GROUP BY country.name;


-- 12. The average population of cities in China.
-- (average city population in China: 484720.6997 approx.)

SELECT C.name, AVG(T.population)
FROM city AS T
JOIN country AS C ON code = countrycode
WHERE code = 'CHN'
GROUP BY C.name;
 

-- 13. The surface area of each continent ordered from highest to lowest.
-- (largest continental surface area: 31881000, "Asia")

SELECT continent, SUM(surfacearea) AS "surface_area"
FROM country
GROUP BY continent
ORDER BY surface_area DESC

=======
-- 4. The average life expectancy of countries in South America.
-- (average life expectancy in South America: 70.9461)

-- 5. The sum of the population of all cities in California.
-- (total population of all cities in California: 16716706)

-- 6. The sum of the population of all cities in China.
-- (total population of all cities in China: 175953614)

-- 7. The maximum population of all countries in the world.
-- (largest country population in world: 1277558000)

-- 8. The maximum population of all cities in the world.
-- (largest city population in world: 10500000)

-- 9. The maximum population of all cities in Australia.
-- (largest city population in Australia: 3276207)

-- 10. The minimum population of all countries in the world.
-- (smallest_country_population in world: 50)

-- 11. The average population of cities in the United States.
-- (avgerage city population in USA: 286955.3795)

-- 12. The average population of cities in China.
-- (average city population in China: 484720.6997 approx.)

-- 13. The surface area of each continent ordered from highest to lowest.
-- (largest continental surface area: 31881000, "Asia")

>>>>>>> 9012ad2172576f682314ff0b2440295279543aa4
-- 14. The highest population density (population divided by surface area) of all 
-- countries in the world. 
-- (highest population density in world: 26277.7777)

<<<<<<< HEAD
SELECT TOP 1 name,  MAX(population / surfacearea) AS "pop_density"
FROM country
GROUP BY name
ORDER BY pop_density DESC;

=======
>>>>>>> 9012ad2172576f682314ff0b2440295279543aa4
-- 15. The population density and life expectancy of the top ten countries with the 
-- highest life expectancies in descending order. 
-- (highest life expectancies in world: 83.5, 166.6666, "Andorra")

<<<<<<< HEAD
SELECT TOP 10 name, MAX(population / surfacearea) AS "pop_density", lifeexpectancy 
FROM country
WHERE lifeexpectancy IS NOT NULL
GROUP BY name, lifeexpectancy
ORDER BY lifeexpectancy DESC;

=======
>>>>>>> 9012ad2172576f682314ff0b2440295279543aa4
-- 16. The difference between the previous and current GNP of all the countries in 
-- the world ordered by the absolute value of the difference. Display both 
-- difference and absolute difference.
-- (smallest difference: 1.00, 1.00, "Ecuador")

<<<<<<< HEAD
SELECT name, (gnp - gnpold) AS "gnp_difference", ABS(gnp - gnpold) AS "absolute_difference" 
FROM country
WHERE gnp IS NOT NULL AND gnpold IS NOT NULL
ORDER BY absolute_difference;

=======
>>>>>>> 9012ad2172576f682314ff0b2440295279543aa4
-- 17. The average population of cities in each country (hint: use city.countrycode)
-- ordered from highest to lowest.
-- (highest avg population: 4017733.0000, "SGP")
	
<<<<<<< HEAD
SELECT C.name,  AVG(T.population) AS "avg_population", code
FROM city as T
JOIN country as C ON countrycode = code
GROUP BY C.name, code
ORDER BY avg_population DESC;

-- 18. The count of cities in each state in the USA, ordered by state name.
-- (45 rows)
	
SELECT district, COUNT(name) AS "num_of_cities"
FROM city
WHERE countrycode = 'USA'
GROUP BY district
ORDER BY district;

-- 19. The count of countries on each continent, ordered from highest to lowest.
-- (highest count: 58, "Africa")

SELECT continent, COUNT(name) AS "num_of_countries"
FROM country
GROUP BY continent
ORDER BY num_of_countries DESC;
=======
-- 18. The count of cities in each state in the USA, ordered by state name.
-- (45 rows)
	
-- 19. The count of countries on each continent, ordered from highest to lowest.
-- (highest count: 58, "Africa")
>>>>>>> 9012ad2172576f682314ff0b2440295279543aa4
	
-- 20. The count of cities in each country ordered from highest to lowest.
-- (largest number of  cities ib a country: 363, "CHN")
	
<<<<<<< HEAD
SELECT C.name, COUNT(T.name) AS "num_of_cities"
FROM city AS "T"
JOIN country AS "C" ON countrycode = code
GROUP BY C.name
ORDER BY num_of_cities DESC;

=======
>>>>>>> 9012ad2172576f682314ff0b2440295279543aa4
-- 21. The population of the largest city in each country ordered from highest to 
-- lowest.
-- (largest city population in world: 10500000, "IND")

<<<<<<< HEAD
SELECT C.name, MAX(T.population) AS "largest_city"
FROM city AS "T"
JOIN country AS "C" ON countrycode = code
GROUP BY C.name
ORDER BY largest_city DESC;

-- 22. The average, minimum, and maximum non-null life expectancy of each continent 
-- ordered from lowest to highest average life expectancy. 
-- (lowest average life expectancy: 52.5719, 37.2, 76.8, "Africa")

SELECT continent, CAST(AVG(lifeexpectancy)AS DECIMAL(38, 4)) AS "avg_life_expected", MIN(lifeexpectancy) AS "min_life_expected", MAX(lifeexpectancy) AS "max_life_expected"
FROM country
WHERE lifeexpectancy IS NOT NULL
GROUP BY continent
ORDER BY avg_life_expected; 
=======
-- 22. The average, minimum, and maximum non-null life expectancy of each continent 
-- ordered from lowest to highest average life expectancy. 
-- (lowest average life expectancy: 52.5719, 37.2, 76.8, "Africa")
>>>>>>> 9012ad2172576f682314ff0b2440295279543aa4
