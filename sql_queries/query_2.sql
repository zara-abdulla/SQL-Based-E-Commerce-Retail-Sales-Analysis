select p.product_name, p.category, 
sum(od.quantity * p.unit_price - od.discount) as total_sales
from products p
join order_details od
on p.product_id=od.product_id
group by p.product_name, p.category
order by total_sales desc
fetch first 5 rows only;