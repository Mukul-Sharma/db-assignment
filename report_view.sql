select 
o.id order_id,
o.created_at date,
o.cost order_cost,
u.name user_name,
u.email user_email,
p.description product_name,
p.price product_price
from orders o
join users u
on o.user_id = u.id
join order_items items
on o.id = items.order_id
join product_variants p
on items.product_variant_id = p.id
where o.created_at > current_date - 30