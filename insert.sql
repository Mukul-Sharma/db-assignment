insert into "users"("name", "email", "pass") values('Mukul', 'abc@xyx.com', 'abcdefghi');
insert into "users"("name", "email", "pass") values('Vivek', 'abc@uyr.com', 'abcdefghi');
insert into "users"("name", "email", "pass") values('Mukul', 'uur@xyx.com', 'abcdefghi');
insert into "users"("name", "email", "pass") values('Mukul', 'jcj@xyx.com', 'abcdefghi');
insert into "users"("name", "email", "pass") values('Mukul', 'yeyd@xyx.com', 'abcdefghi');

insert into "products"("name") values('Item 1');
insert into "products"("name") values('Item 2');
insert into "products"("name") values('Item 3');
insert into "products"("name") values('Item 4');

insert into "colors"("name") values('Red');
insert into "colors"("name") values('Green');
insert into "colors"("name") values('Black');
insert into "colors"("name") values('Purple');

insert into "product_variants"("description", "price", "product_id", "color_id") values('Red Item 1', 20.00, 1, 1);
insert into "product_variants"("description", "price", "product_id", "color_id") values('Purple Item 1', 24.00, 1, 4);
insert into "product_variants"("description", "price", "product_id", "color_id") values('Red Item 2', 20.00, 2, 1);
insert into "product_variants"("description", "price", "product_id", "color_id") values('Green Item 1', 20.00, 2, 2);
insert into "product_variants"("description", "price", "product_id", "color_id") values('Black Item 3', 20.00, 3, 3);
insert into "product_variants"("description", "price", "product_id", "color_id") values('Green Item 4', 20.00, 4, 2);

insert into "carts"("user_id") values(1);
insert into "carts"("user_id") values(2);
insert into "carts"("user_id") values(3);
insert into "carts"("user_id") values(4);

insert into "cart_items"("cart_id", "quantity", "product_variant_id") values(1, 1, 1);
insert into "cart_items"("cart_id", "quantity", "product_variant_id") values(1, 2, 2);
insert into "cart_items"("cart_id", "quantity", "product_variant_id") values(2, 2, 1);
insert into "cart_items"("cart_id", "quantity", "product_variant_id") values(3, 1, 3);
insert into "cart_items"("cart_id", "quantity", "product_variant_id") values(4, 3, 4);

insert into "payment_methods"("description") values('credit_card');
insert into "payment_methods"("description") values('debit_card');
insert into "payment_methods"("description") values('net_banking');
insert into "payment_methods"("description") values('cod');
insert into "payment_methods"("description") values('coupons');

insert into coupons (code, valid_for_days, amount) values ('HELLO', 2, 20);
insert into coupons (code, valid_for_days, amount) values ('HELLO2', 1, 10);
insert into coupons (code, valid_for_days, amount) values ('HELLO3', 4, 50);
insert into coupons (code, valid_for_days, amount) values ('HELLO1', 1, 50);
insert into coupons (code, valid_for_days, amount) values ('HELLO4', 5, 100);

insert into coupon_uses(user_id, coupon_id) values (1, 1);
insert into coupon_uses(user_id, coupon_id) values (2, 1);
insert into coupon_uses(user_id, coupon_id) values (3, 2);
