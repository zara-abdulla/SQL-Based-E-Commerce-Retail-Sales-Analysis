select count(distinct r.order_id) * 100.0 / count(distinct o.order_id) as return_percentage
from orders o
left join returns r
on r.order_id=o.order_id;