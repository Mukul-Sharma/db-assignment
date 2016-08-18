CREATE OR REPLACE FUNCTION process_cart(which in INTEGER, method in INTEGER, coupon_use_id in INTEGER) RETURNS void AS
$$
DECLARE
	order_cost decimal(10,4);
	current_order_id integer;
	ordering_user_id integer;
	cart_item RECORD;
	t_status varchar(10);
BEGIN

	IF method = 5 THEN
		IF (select count(*) from coupon_uses where id = coupon_use_id) < 1 THEN
			RAISE EXCEPTION 'Invalid Coupon --> %', coupon_used_id
      		USING HINT = 'Please check your coupon use ID';
		END IF;
	END IF;
	
	insert into orders(user_id, cost)
	select c.user_id, c.cost
	from carts as c
	where id = which
	returning id, cost, user_id into current_order_id, order_cost, ordering_user_id;

	for cart_item in select product_variant_id, total_price, quantity from cart_items where cart_id = cart_id LOOP
		insert into "order_items"("order_id", "product_variant_id", "total_price", "quantity") values(current_order_id, cart_item.product_variant_id, cart_item.total_price, cart_item.quantity);
   	END LOOP;

   	delete from cart_items where cart_id = which;
   	
   	IF method = 5 THEN
   		t_status := 'complete';
   	ELSE
   		t_status := 'pending'; 
   	END IF;
   	
   	insert into "transactions"("amount", "order_id", "user_id", "status", "payment_method", "flow") values (order_cost, current_order_id, ordering_user_id, t_status, method, 'from');
END;
$$
language plpgsql;

CREATE OR REPLACE FUNCTION price_total() RETURNS trigger AS $price_total$
    BEGIN
    	NEW.total_price := NEW.quantity * (select price from product_variants where id = NEW.product_variant_id);
        RETURN NEW;
    END;
$price_total$
LANGUAGE plpgsql;

CREATE TRIGGER price_total BEFORE INSERT OR UPDATE ON cart_items
    FOR EACH ROW EXECUTE PROCEDURE price_total();

CREATE OR REPLACE FUNCTION update_cart() RETURNS trigger AS $update_cart$
    BEGIN
    	update carts set cost = (select sum(total_price) from cart_items where cart_id = NEW.cart_id) where id = NEW.cart_id;
        RETURN NEW;
    END;
$update_cart$
LANGUAGE plpgsql;

CREATE TRIGGER update_cart AFTER INSERT OR UPDATE ON cart_items
    FOR EACH ROW EXECUTE PROCEDURE update_cart();

CREATE OR REPLACE FUNCTION clear_cart() RETURNS trigger AS $clear_cart$
   BEGIN
   	update carts set cost = 0 where id = old.cart_id;
       RETURN NEW;
   END;
$clear_cart$
LANGUAGE plpgsql;

CREATE TRIGGER clear_cart AFTER DELETE ON cart_items
   FOR EACH ROW EXECUTE PROCEDURE clear_cart();

CREATE OR REPLACE FUNCTION is_valid_coupon(coupon_number integer, days integer) returns boolean as $$
BEGIN
	return (select count(id) from coupons where id = coupon_number and created_at > current_date - days) > 0;
END;
$$
language plpgsql;

CREATE OR REPLACE FUNCTION check_coupon() RETURNS TRIGGER AS $check_coupon$

	DECLARE
		coupon_days integer;
	BEGIN
		select valid_for_days into coupon_days from coupons where id = NEW.coupon_id;
		IF (select is_valid_coupon(NEW.coupon_id, coupon_days)) THEN
			RETURN NEW;
		ELSE 
			RAISE EXCEPTION 'Coupon Expired %', NEW.coupon_id
	  		USING HINT = 'Please check your coupon ID';
	  	END IF;
	END;
$check_coupon$
language plpgsql;

CREATE TRIGGER check_coupon BEFORE INSERT ON coupon_uses
FOR EACH ROW EXECUTE PROCEDURE check_coupon();

CREATE OR REPLACE FUNCTION process_order() RETURNS trigger AS $process_order$
	BEGIN
		IF NEW.status = 'complete' THEN
			update orders set status = 'complete' where id = NEW.order_id;
		END IF;
		RETURN NEW;
	END;
$process_order$
LANGUAGE plpgsql;

CREATE TRIGGER process_order AFTER UPDATE ON transactions
	FOR EACH ROW EXECUTE PROCEDURE process_order();
