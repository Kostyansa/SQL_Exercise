start transaction;

create schema if not exists shop
   authorization postgres;
	
create table if not exists shop.Customer ( 
	id serial not null unique,
	fullName text not null,
	password varchar(255) not null,
	login varchar(45) not null,
	primary key (id));

create table if not exists shop.Item ( 
	id serial not null unique,
	name text not null,
	description text not null,
	price money not null,
	primary key (id));

create table if not exists shop.ItemAvailability ( 
	id int not null unique,
	amount int not null,
	foreign key (id)
		references shop.Item(id)
		on delete cascade);

create table if not exists shop.Bundle ( 
	id serial not null,
	name text not null,
	description text not null,
	price money not null,
	primary key (id));

create table if not exists shop.Bundle_Has_Item ( 
	id_Bundle int not null,
	id_Item int not null,
	foreign key (id_Bundle) 
		references shop.Bundle(id)
		on delete cascade,
	foreign key (id_Item) 
		references shop.Item(id)
		on delete set null);

create table if not exists shop.CustomerOrder ( 
	id serial not null,
	id_Customer int not null,
	primary key (id));

create table if not exists shop.CustomerOrder_Has_Item ( 
	id_CustomerOrder serial not null,
	id_Item int,
	foreign key (id_CustomerOrder) 
		references shop.CustomerOrder(id)
		on delete cascade,
	foreign key (id_Item) 
		references shop.Item(id)
		on delete set null);

create table if not exists shop.CustomerOrder_Has_Bundle ( 
	id_CustomerOrder serial not null,
	id_Bundle int,
	foreign key (id_CustomerOrder) 
		references shop.CustomerOrder(id) 
		on delete cascade,
	foreign key (id_Bundle) 
		references shop.Bundle(id)
		on delete set null);

create table if not exists shop.Payment ( 
	id serial not null,
	id_CustomerOrder int not null,
	price money not null,
	completed bool not null default false,
	primary key (id),
	foreign key (id_CustomerOrder) 
		references shop.CustomerOrder(id) 
		on delete cascade);



create unique index idCustomer_UNIQUE on shop.customer(id asc);
create unique index loginCustomer_UNIQUE on shop.customer(login asc);

create unique index idItem_UNIQUE on shop.item(id asc);
create unique index nameItem_UNIQUE on shop.item(name asc);

create unique index idCustomerOrder_UNIQUE on shop.customerOrder( id asc);
create index idCustomer on shop.customerOrder(id_Customer asc);

create unique index idBundle_UNIQUE on shop.bundle(id asc);
create unique index namBundle_UNIQUE on shop.bundle(name asc);

create unique index idPayment_UNIQUE on shop.payment(id asc);
create unique index idOrder_UNIQUE on shop.payment(id_CustomerOrder asc);

commit;
