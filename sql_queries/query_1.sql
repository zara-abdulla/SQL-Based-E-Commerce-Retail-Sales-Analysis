select 
    o.order_date as order_date,
    count(distinct o.order_id) as number_of_orders,
    sum(p.unit_price * od.quantity - od.discount) as total_sales
from orders o
join order_details od on od.order_id = o.order_id
join products p on p.product_id = od.product_id
group by o.order_date
order by o.order_date;