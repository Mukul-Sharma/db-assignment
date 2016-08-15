CREATE OR REPLACE FUNCTION process_cart(cart_id in INTEGER) RETURNS void AS
$$
DECLARE
	cost integer;
	order_id integer;
	cart_item RECORD;
BEGIN
	insert into orders(user_id, cost)
	select user_id, 0
	from carts 
	where id = cart_id
	returning id into order_id;
	
	for cart_item in select product_variant_id, total_price, quantity from cart_items where cart_id = cart_id LOOP
		insert into "order_items"("order_id", "product_variant_id", "total_price", "quantity") values(order_id, cart_item.product_variant_id, cart_item.total_price, cart_item.quantity);
   	END LOOP;
END;
$$  
language plpgsql;