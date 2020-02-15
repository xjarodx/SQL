This repository contains the SQL homework assignment for UNC's Data Analytics program. This sql project uses data from Sakila to demonstrate database creation, creating/altering tables, searching/selecting/updating data, and joining information from different tables. 

Joining to determin totals from different tables
```SELECT staff.first_name, staff.last_name, SUM(payment.amount) AS 'Total Amount', COUNT(payment.payment_date LIKE '2005-08%') AS '# of August 2005 Transactions'
FROM staff INNER JOIN payment ON payment.staff_id=staff.staff_id GROUP BY first_name;```

