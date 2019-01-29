USE sakila;

## 1a. Display the first and last names of all actors from the table `actor`.
SELECT actor.first_name, actor.last_name FROM actor;

## 1b. Display the first and last names of all actors from the table `actor`.
ALTER TABLE actor ADD COLUMN `Actor Name` VARCHAR(50);
UPDATE actor SET `Actor Name` = CONCAT(first_name, ' ', last_name);
SELECT `Actor Name` FROM actor;

## 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
##			What is one query would you use to obtain this information?
SELECT * from actor WHERE first_name = "Joe";

## 2b. Find all actors whose last name contain the letters `GEN`:
SELECT * from actor WHERE last_name LIKE "%GEN%";

## 2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:
SELECT * from actor WHERE last_name LIKE "%LI%" ORDER BY last_name;

## 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, country FROM country WHERE country IN ("Afghanistan", "Bangladesh", "China");

## 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, so
##		 create a column in the table `actor` named `description` and use the data type `BLOB` (Make sure to research the type 
##		 `BLOB`, as the difference between it and `VARCHAR` are significant).
ALTER TABLE actor ADD COLUMN description BLOB;

## 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the `description` column.
ALTER TABLE actor DROP COLUMN description;

## 4a. List the last names of actors, as well as how many actors have that last name.
SELECT last_name,COUNT(*) AS count FROM actor GROUP BY last_name ORDER BY count DESC;

## 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name, COUNT(*) AS count FROM actor GROUP BY last_name HAVING count > 1 ORDER BY count DESC;

## 4c. The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. Write a query to fix the record.
UPDATE actor SET first_name = "HARPO" WHERE first_name = "GROUCHO";

## 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! 
##	In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`.
UPDATE actor SET first_name = "GROUCHO" WHERE first_name = "HARPO";

## 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?
SHOW CREATE TABLE sakila.address;

## 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
SELECT staff.first_name, staff.last_name, staff.address_id, address.address
FROM address INNER JOIN staff ON staff.address_id=address.address_id;

## 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.
SELECT staff.first_name, payment.amount 
staff_id FROM payment INNER JOIN staff ON staff.staff_id=payment.staff_id;















