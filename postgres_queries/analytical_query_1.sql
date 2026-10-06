select EXTRACT(YEAR
               FROM r.rental_date) AS rental_year,
       EXTRACT(MONTH
               FROM r.rental_date) AS rental_month,
       c.first_name,
       c.last_name,
       c.email,
       f.title AS movie_title,
       count(*) over(partition by EXTRACT(YEAR
                                          FROM r.rental_date), EXTRACT(MONTH
                                                                       FROM r.rental_date), r.customer_id rows between unbounded preceding and current row) as rental_count
from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on f.film_id = i.film_id
order by rental_year,
         rental_month,
         r.customer_id;