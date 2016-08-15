select
o.id order_id,
o.cost total,
o.created_at date,
t.payment_method method,
t.status status,
d.amount discount
from orders o
join transactions t
on o.id = t.order_id
left join transactions d
on o.id = d.order_id and d.payment_method = 5