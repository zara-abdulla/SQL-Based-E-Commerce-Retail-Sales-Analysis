select c.full_name,c.age, count(o.order_id) as order_count
from customers c
join orders o
on o.customer_id=c.customer_id
group by c.customer_id, c.full_name, c.age
order by order_count desc
fetch first 5 rows only;