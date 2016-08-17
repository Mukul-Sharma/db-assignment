create table users(id serial primary key not null,
	name varchar(50) not null,
	email varchar(50) not null unique,
	pass varchar(20) not null,
	created_at timestamp default current_timestamp,
	constraint pass_constraint check(character_length(pass) > 8)
);

create table products(id serial primary key not null,
	name varchar(100) not null unique
);

create table colors(id serial primary key not null,
	name varchar(10) not null unique
);

create table product_variants(id serial primary key not null,
	description text,
	price decimal(10, 4) not null,
	product_id integer references products,
	color_id integer references colors,
	unique(product_id, color_id)
);

create table carts(id serial primary key not null,
	user_id integer references users,
	cost decimal(10, 4) default 0.00
);

create table cart_items(id serial primary key not null,
	cart_id integer references carts,
	quantity integer not null,
	product_variant_id integer references product_variants,
	total_price decimal(10, 4) default 0.00,
	constraint at_least_one check(quantity > 0)
);

create table orders(id serial primary key not null,
	cost decimal(10, 4) not null default 0.00,
	created_at timestamp default current_timestamp,
	updated_at timestamp,
	status varchar(10) not null default 'pending',
	user_id integer references users,
	constraint status_type check(status in('pending', 'complete', 'returned'))
);

create table order_items(id serial primary key not null,
	order_id integer references orders,
	quantity integer not null,
	product_variant_id integer references product_variants,
	total_price decimal(10, 4) default 0.00,
	constraint at_least_one check(quantity > 0)
);

create table payment_methods(id serial primary key not null,
	description text not null unique
);

create table coupons(id serial primary key not null,
	valid_for_days integer default 1,
	code varchar(10) not null unique,
	amount decimal(10, 4) not null,
	created_at date default current_date
);

create table coupon_uses(id serial,
	user_id integer references users,
	coupon_id integer references coupons,
	use_date timestamp default current_timestamp,
	unique(user_id, coupon_id)
);

create table transactions(id serial primary key not null,
	amount decimal(10, 4) not null,
	status varchar(10) not null default 'pending',
	constraint status_type check(status in('pending', 'complete', 'failed')),
	created_at timestamp default current_timestamp,
	order_id integer references orders,
	user_id integer references users,
	payment_method integer references payment_methods,
	flow varchar(5) not null,
	constraint flow_type check(flow in('from', 'to'))
);
