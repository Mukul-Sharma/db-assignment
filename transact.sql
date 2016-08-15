select process_cart(1);
select process_cart(2);
select process_cart(3);
select process_cart(4);

insert into "transactions"("amount", "order_id", "user_id", "status", "payment_method", "flow") values (20, 1, 1, 'pending', 1, 'from');
insert into "transactions"("amount", "order_id", "user_id", "status", "payment_method", "flow") values (40, 2, 2, 'pending', 1, 'from');
insert into "transactions"("amount", "order_id", "user_id", "status", "payment_method", "flow") values (50, 3, 3, 'pending', 1, 'from');
insert into "transactions"("amount", "order_id", "user_id", "status", "payment_method", "flow") values (40, 4, 4, 'pending', 1, 'from');
