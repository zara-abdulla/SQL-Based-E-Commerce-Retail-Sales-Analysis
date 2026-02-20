select o.payment_method, count(distinct o.order_id) as order_count,
sum(p.unit_price * od.quantity - od.discount)  as total_sales
from orders o
join order_details od
on od.order_id=o.order_id
join products p
on p.product_id=od.product_id
group by o.payment_method
order by total_sales desc;