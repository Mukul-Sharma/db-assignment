select process_cart(1, 1);
select process_cart(2, 2);
select process_cart(3, 3);
select process_cart(4, 4);

update transactions set status = 'complete' where id = 1;
update transactions set status = 'complete' where id = 2;
