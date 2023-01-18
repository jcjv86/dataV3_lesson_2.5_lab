USE sakila;

-- 1. Select all the actors with the first name ‘Scarlett’.
SELECT * FROM actor
WHERE first_name = "Scarlett";


-- 2. How many films (movies) are available for rent and how many films have been rented?
SELECT count(distinct(inventory_id)) FROM inventory;
-- Total number of films available (even repeated ones) 16044
SELECT COUNT(DISTINCT inventory_id) FROM rental;

SELECT count(rental_id) FROM rental;
-- Total number of films rented 


-- 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.

SELECT MAX(length) as max_duration, MIN(length) as min_duration from film;


-- 4. What's the average movie duration expressed in format (hours, minutes)?

select date_format(date_add('2000-01-01', interval (avg(length)) minute), '%h:%i') from film;

 
-- SELECT CONVERT(TIME,DATEADD(ms,526.30*60000,0))

-- 5. How many distinct (different) actors' last names are there?
SELECT count(distinct(last_name)) from actor;


-- 6. Since how many days has the company been operating (check DATEDIFF() function)?

-- Difference in days
SELECT datediff('2023-01-18', left(min(rental_date),10)) from rental;
-- Difference in days between first rental and last
SELECT datediff(left(max(rental_date),10), left(min(rental_date),10)) from rental;
-- If we want to calculate the years, /365
SELECT (datediff(left(max(rental_date),10), left(min(rental_date),10))/365) from rental;
-- Difference in years to the cease of operations of Blockbuster January 12, 2014:
SELECT (datediff('2014-01-12', left(min(rental_date),10))/365) from rental;


-- 7. Show rental info with additional columns month and weekday. Get 20 results.

SELECT *, DATE_FORMAT(rental_date, "%M") AS month, DATE_FORMAT(rental_date, "%W") AS weekday from rental;


-- 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

SELECT *, DATE_FORMAT(rental_date, "%W") as day,
CASE
WHEN DATE_FORMAT(rental_date, "%W") = 'Saturday' then 'weekend'
WHEN DATE_FORMAT(rental_date, "%W") = 'Sunday' then 'weekend'
WHEN DATE_FORMAT(rental_date, "%W") <> 'Saturday' OR 'Sunday' then 'workday'
ELSE ''
END AS 'day_type'
FROM rental;


-- 9. Get release years.

SELECT distinct(release_year) from film;


-- 10. Get all films with ARMAGEDDON in the title.

SELECT * from film
WHERE left(title,10) = 'ARMAGEDDON' OR right(title,10) = 'ARMAGEDDON';


-- 11. Get all films which title ends with APOLLO.

SELECT * from film
WHERE right(title,6) = 'APOLLO';


-- 12. Get 10 the longest films.

SELECT * from film
ORDER BY length DESC
LIMIT 10;


-- 13. How many films include Behind the Scenes content?

SELECT * FROM film
WHERE special_features LIKE '%Behind%';