This repository contains the SQL homework assignment for UNC's Data Analytics program. This sql project used data from Sakila to demonstrate database creation, creating/altering tables, searching/selecting/updating data, and joining information from different tables. 

Below are some examples.

Joining to determine totals from different tables:
```
SELECT staff.first_name, staff.last_name, SUM(payment.amount) AS 'Total Amount', COUNT(payment.payment_date LIKE '2005-08%') AS '# of August 2005 Transactions'
FROM staff INNER JOIN payment ON payment.staff_id=staff.staff_id GROUP BY first_name;
```

Searching for items that start with specific letters and are a specific language:
```
SELECT title FROM film fi
WHERE ((fi.title like 'K%')  
OR(fi.title like 'Q%') AND (fi.language_id IN (
	Select language_id 
    from  language la
    where la.name = 'English' ))
    );
```

Searching multiple tables to find top five grossing and list in decending order:
```
    SELECT cat.name as Genre, sum(P.AMOUNT) as Gross_rev
FROM payment P, rental ren, inventory Inv, film_category ficat, category cat
WHERE P.rental_id = ren.rental_id
AND ren.inventory_id = Inv.inventory_id
AND Inv.film_id = ficat.film_id
AND ficat.category_id = cat.category_id
GROUP BY cat.name ORDER BY 2 DESC LIMIT  5; 
```
