{{ config(
    materialized = 'table'
) }}

select
	orders.customer_id as customer_id,
	customers.name as customer_name,
	customers.email as customer_email,
	min(orders.created_at) as first_order_at,
	count(orders.created_at) as order_count
from {{ source('coffee_shop', 'customers') }} as customers
left join {{ source('coffee_shop', 'orders') }} as orders
  on customers.id = orders.customer_id
group by 
    customer_id,
    customer_name,
    customer_email
order by first_order_at