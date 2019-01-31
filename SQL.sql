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
SELECT staff.first_name, staff.last_name, SUM(payment.amount) AS 'Total Amount', COUNT(payment.payment_date LIKE '2005-08%') AS '# of August 2005 Transactions'
FROM staff INNER JOIN payment ON payment.staff_id=staff.staff_id GROUP BY first_name;

## 6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
SELECT fi.title, COUNT(fa.actor_id), fi.film_id
FROM film_actor fa,film fi 
WHERE fa.film_id = fi.film_id
GROUP BY fa.film_id;

## 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?
SELECT fi.title, COUNT(Inv.inventory_id), fi.film_id
FROM inventory Inv,film fi 
WHERE Inv.film_id = fi.film_id 
AND fi.title = "Hunchback Impossible"
GROUP BY fi.film_id;

## 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name:
SELECT C.first_name, C.last_name, SUM(P.amount)
FROM payment P, customer C 
WHERE P.customer_id = C.customer_id 
GROUP BY C.last_name, C.first_name
ORDER BY C.last_name;

## 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` 
## have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.
SELECT title FROM film fi
WHERE ((fi.title like 'K%')  
OR(fi.title like 'Q%') AND (fi.language_id IN (
	Select language_id 
    from  language la
    where la.name = 'English' ))
    );

## 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
SELECT act.first_name, act.last_name 
FROM  film_actor fa, actor act
WHERE  fa.film_id = (SELECT film_id FROM film fi WHERE Fi.title = 'Alone Trip')
AND  fa.actor_id = act.actor_id;

## 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. 
## Use joins to retrieve this information.
SELECT C.first_name, C.last_name, C.email
FROM customer C
WHERE address_id IN (
	SELECT ad.address_id FROM  address ad, city cit, country coun
		WHERE  ad.city_id = cit.city_id AND  cit.country_id = coun.country_id
		AND coun.country = 'Canada');
        
## 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as _family_ films.
SELECT fi.title, fi.description
FROM film fi
WHERE fi.film_id IN (
	SELECT ficat.film_id
		FROM  film_category ficat, category cat
		  WHERE  ficat.category_id = cat.category_id
			AND cat.name = 'Family');
            
## 7e. Display the most frequently rented movies in descending order.
SELECT  Inv.film_id, fi.title,  COUNT(*) AS rented_total
FROM rental ren, inventory Inv, film fi
WHERE ren.inventory_id = Inv.inventory_id
AND Inv.film_id = fi.film_id
GROUP BY Inv.film_id, Fi.title
ORDER BY rented_total Desc;

## 7f. Write a query to display how much business, in dollars, each store brought in.
SELECT C.store_id, Sum(P.amount) as money_store FROM payment  P, customer C
WHERE P.customer_id = C.customer_id GROUP BY C.store_id;

## 7g. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, cit.city, coun.country
FROM store s, address ad, city cit, country coun 
WHERE s.address_id  = ad.address_id
AND ad.city_id = cit.city_id
AND cit.country_id = coun.country_id;

## 7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, 
## payment, and rental.)
SELECT cat.name as Genre, sum(P.AMOUNT) as Gross_rev
FROM payment P, rental ren, inventory Inv, film_category ficat, category cat
WHERE P.rental_id = ren.rental_id
AND ren.inventory_id = Inv.inventory_id
AND Inv.film_id = ficat.film_id
AND ficat.category_id = cat.category_id
GROUP BY cat.name ORDER BY 2 DESC LIMIT  5; 
                    
## 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. 
## Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
CREATE VIEW Gross_rev_by_genre AS (
	SELECT cat.name as Genre, sum(P.AMOUNT) as Gross_revenue
	FROM PAYMENT P, rental ren, inventory Inv, film_category ficat, category cat
	WHERE P.rental_id = ren.rental_id
	AND ren.inventory_id = Inv.inventory_id AND Inv.film_id = ficat.film_id
	AND ficat.category_id = cat.category_id
	GROUP BY cat.name ORDER BY 2 DESC LIMIT 5);

## 8b. How would you display the view that you created in 8a?
SHOW CREATE VIEW Gross_rev_by_genre;
SELECT * FROM Gross_rev_by_genre ;

## 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.
DROP VIEW Gross_rev_by_genre;
