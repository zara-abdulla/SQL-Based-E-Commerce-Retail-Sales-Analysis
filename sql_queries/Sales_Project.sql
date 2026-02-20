-- I. Sales Performance

-- 1. Calculate total sales revenue (unit_price * quantity - discount)
select sum(p.unit_price * od.quantity - od.discount) as total_sales
from order_details od
join products p
on od.product_id=p.product_id;



-- 2. Monthly sales revenue and number of orders
select TO_CHAR(o.order_date, 'YYYY-MM') as year_month,
COUNT(DISTINCT o.order_id) as number_of_orders, 
sum(p.unit_price * od.quantity - od.discount)  as total_sales
from orders o
join order_details od
on od.order_id=o.order_id
join products p 
on p.product_id= od.product_id
group by TO_CHAR(o.order_date, 'YYYY-MM')
order by year_month;



-- 3. Revenue, cost, and profit per product
select p.product_name, 
coalesce(sum(p.cost_price*od.quantity),0) as cost_price,
coalesce(sum(od.quantity * p.unit_price - od.discount),0) as revenue,
coalesce((sum(od.quantity * p.unit_price - od.discount) - sum(p.cost_price*od.quantity)),0) as profit
from products p
left join order_details od
on od.product_id=p.product_id
group by p.product_id, p.product_name;



-- 4. Top 5 products by revenue
select p.product_name, p.category, sum(od.quantity * p.unit_price - od.discount) as total_sales
from products p
join order_details od
on p.product_id=od.product_id
group by p.product_name, p.category
order by total_sales desc
fetch first 5 rows only;



-- 5. Top 5 customers by number of orders
select c.full_name,c.age, count(o.order_id) as order_count
from customers c
join orders o
on o.customer_id=c.customer_id
group by c.customer_id, c.full_name, c.age
order by order_count desc
fetch first 5 rows only;



-- 6. Sales and order distribution by city
select c.city,
coalesce(sum(p.unit_price * od.quantity - od.discount),0) as total_sales,
count(distinct o.order_id) as order_count
from customers c
left join orders o
on o.customer_id=c.customer_id
left join order_details od
on od.order_id=o.order_id
left join products p
on p.product_id=od.product_id
group by c.city
order by total_sales desc;



-- II. Discount & Payment Analysis

-- 1. Analyze the impact of discounts on sales (discounted vs non-discounted orders)
select
  order_type,
  count(*) as order_count
from (
  select
    order_id,
    case 
      when sum(discount) > 0 then 'Discounted Orders'
      else 'Non-Discounted Orders'
    end as order_type
  from order_details
  group by order_id
) t
group by order_type;



-- 2. Sales distribution by payment method
select o.payment_method, count(distinct o.order_id) as order_count,
sum(p.unit_price * od.quantity - od.discount)  as total_sales
from orders o
join order_details od
on od.order_id=o.order_id
join products p
on p.product_id=od.product_id
group by o.payment_method
order by total_sales desc;



-- 3. Ratio of completed vs cancelled orders
select status, 
count(*)*100.0/(select count(*) from orders) as percentage
from orders
where status in ('Completed', 'Cancelled')
group by status;




-- III. Return Analysis

-- 1. Return rate (return count / total orders)
select count(distinct r.order_id) * 100.0 / count(distinct o.order_id) as return_percentage
from orders o
left join returns r
on r.order_id=o.order_id;



-- 2. Most returned products and categories
select p.product_name, p.category, count(r.return_id) as return_count
from products p
join returns r
on r.product_id=p.product_id
group by p.product_name, p.category
order by return_count desc
fetch first 10 rows only;



-- 3. Distribution of return reasons
select 
    reason,
    count(*) * 100.0 / (select count(*) from returns) as return_percentage
from returns
group by reason
order by return_percentage desc;



-- IV. Bonus Analysis

-- 1. Average profit margin by category (%)
select p.category,
    round(
        (sum(od.quantity * p.unit_price - od.discount)
            - sum(p.cost_price * od.quantity)
        ) * 100.0
        / nullif(
            sum(od.quantity * p.unit_price - od.discount),0),2) as average_profit_percentage
from products p
left join order_details od
    on od.product_id = p.product_id
group by p.category
order by average_profit_percentage desc;



-- 2. Sales share by customer age groups
select
    case
        when c.age <= 25 then 'Young'
        when c.age between 26 and 45 then 'Adult'
        when c.age > 45 then 'Older'
    end as age_group,
    round(
        sum(p.unit_price * od.quantity - od.discount) * 100.0
        / sum(sum(p.unit_price * od.quantity - od.discount)) over (),
        2
    ) as sales_share_percentage
from customers c
left join orders o on o.customer_id = c.customer_id
left join order_details od on od.order_id = o.order_id
left join products p on p.product_id = od.product_id
group by 
    case
        when c.age <= 25 then 'Young'
        when c.age between 26 and 45 then 'Adult'
        when c.age > 45 then 'Older'
    end
order by sales_share_percentage desc;



-- 3. Year-over-year sales growth (2023 vs 2024)
select
    round(
        (sum(case when extract(year from o.order_date) = 2024 
                 then p.unit_price * od.quantity - od.discount 
                 else 0 end)
       -
        sum(case when extract(year from o.order_date) = 2023 
                 then p.unit_price * od.quantity - od.discount 
                 else 0 end)
       ) * 100.0
       / nullif(sum(case when extract(year from o.order_date) = 2023 
                        then p.unit_price * od.quantity - od.discount 
                        else 0 end),0),
       2
    ) as sales_growth_percentage
from orders o
join order_details od on od.order_id = o.order_id
join products p on p.product_id = od.product_id
where extract(year from o.order_date) in (2023, 2024);