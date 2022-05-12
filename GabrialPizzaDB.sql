drop schema public cascade;
create schema public;

 create table reasons(
 	id serial not null PRIMARY KEY,
    name varchar(50) NOT NULL 
  );
 
 create table users(
  	id bigserial not null PRIMARY KEY,
  	first_name varchar(30),
  	last_name varchar(50),	
  	email varchar(150),
  	password varchar(40)
  );

 create table provinces(
    id serial not null PRIMARY KEY,
    name varchar(30)
 );
   
 
 create table customers(
  	id bigserial not null PRIMARY KEY,
  	first_name varchar(30) NOT NULL,
  	last_name varchar(50) NOT NULL,	
  	email varchar(150) NOT NULL,
  	address varchar(50),
  	address2 varchar(50),
  	city varchar(30),
	province_id integer references provinces(id),
  	postal_code varchar(7),
  	phone_number varchar(14) NOT NULL
 );

  create table customer_calls(
  	id bigserial not null PRIMARY KEY,
   	call_timestamp timestamp DEFAULT CURRENT_TIMESTAMP,
   	call_length smallint,
   	customer_id bigint references customers(id),
	user_id bigint references users(id),
	reason_id integer references reasons(id),  
	description_of_call text
  );
  
  create table customer_call_notes(
   id bigserial NOT NULL PRIMARY KEY,
   customer_call_id bigint references customer_calls(id),	
   note_timestamp timestamp DEFAULT CURRENT_TIMESTAMP,
   notes text
 );

 insert into reasons (id, name)  values (1, 'food recipe');
 insert into reasons (id, name)  values (2, 'assignment completing');
 insert into reasons (id, name)  values (3, 'exam related');
 insert into reasons (id, name)  values (4, 'prof for douts');
 insert into reasons (id, name)  values (5, 'for greeting');


  insert into users (id, first_name, last_name, email, password)  values (1, 'param', 'savalia', 'paramsavalia@gool.com', '1234id');
  insert into users (id, first_name, last_name, email, password)  values (2, 'bala', 'shah', 'balabala@gool.com', '1234ie');
  insert into users (id, first_name, last_name, email, password)  values (3, 'vraj', 'jindal', 'rohitjind@gool.com', '1256d');
  insert into users (id, first_name, last_name, email, password)  values (4, 'vri', 'kumar', 'vrikum@gool.com', '567aii');
  insert into users (id, first_name, last_name, email, password)  values (5, 'aayush', 'aayush', 'aayush1@gool.com', '2345id');

  insert into provinces (id, name)  values (1, 'Ontario');
  insert into provinces (id, name)  values (2, 'British Columbia');
  insert into provinces (id, name)  values (3, 'Alberta');
  insert into provinces (id, name)  values (4, 'Nova Scotia');
  insert into provinces (id, name)  values (5, 'Manitoba');
 
 
  insert into customers(id,first_name, last_name,email,address,address2,city,postal_code,phone_number,province_id) 
    	values(1,'disha','mithal','mithal@gool.com','bayshore','lincon fields','ottawa','K2BG7','9900990011',5);                         

  insert into customers(id,first_name, last_name,email,address,address2,city,postal_code,phone_number,province_id) 
    	values(2,'bunny','parik','bunny@gool.com','bayshore','lincon fields','ottawa','K2BG7','9808987017',3);                         

  insert into customers(id,first_name, last_name,email,address,address2,city,postal_code,phone_number,province_id) 
    	values(3,'jiya','verma','jiysverma@gool.com','Peggys Cove','Lunenburg','nova scotia ','RK2GGG','6109099001',2);                         

  insert into customers(id,first_name, last_name,email,address,address2,city,postal_code,phone_number,province_id) 
    	values(4,'kumar', 'sanu', 'skumar@gool.com','Chestermere','Central Alberta','Alberta','AA9R11','7108088501',3);

  insert into customers(id,first_name, last_name,email,address,address2,city,postal_code,phone_number,province_id) 
     	values(5, 'birwa', 'raval', 'bliarara@gool.com','Thompson','Winnipeg','Manitoba','MAN9R44','4104048771',5);


	 insert into customer_calls (id,call_length,description_of_call,user_id,customer_id,reason_id) 
   		values (1,48,'emergency',5,2,1);

	 insert into customer_calls (id,call_length,description_of_call,user_id,customer_id,reason_id) 
		values(2,528,'planning',4,5,3); 

	 insert into customer_calls (id,call_length,description_of_call,user_id,customer_id,reason_id) 
		values(3,418,'test planning',1,4,4); 

	 insert into customer_calls (id,call_length,description_of_call,user_id,customer_id,reason_id) 
		values(4,48,'douts regarding trip',3,3,3); 

	 insert into customer_calls (id,call_length,description_of_call,user_id,customer_id,reason_id) 
		values(5,948,'birthday',2,2,3);
		
	 
	 insert into customer_call_notes (id,notes,customer_call_id) 
								values (1,'emergency for food',1);

	 insert into customer_call_notes (id,notes,customer_call_id) 
								values (2,'planning',2);

	 insert into customer_call_notes (id,notes,customer_call_id) 
								values (3,'hospital',3);

	 insert into customer_call_notes (id,notes,customer_call_id) 
								values (4,'trip',4);

	  insert into customer_call_notes (id,notes,customer_call_id) 
								values (5,'planning for outing',5);
							
	
	 select * from customers where phone_number like '%9900990011%';
	 
	 select * from customer_calls where customer_id = 2;

	 select * from customer_calls where user_id = 5;
	 
 select customer_calls.id 
 		as call_id, users.first_name 
	 	as users_first_name, users.last_name 
		as users_last_name, customers.first_name 
		as customers_first_name, customers.last_name 
		as customers_last_name, customers.phone_number 
		as customers_phone_number, reasons.name 
		as reasons, count(customer_call_notes.id) 
		as customer_call_notes from customer_calls 
		inner join users on customer_calls.user_id = users.id
		inner join customers on customer_calls.customer_id = customers.id
		inner join reasons on customer_calls.reason_id = reasons.id
		inner join customer_call_notes on customer_call_notes.customer_call_id = customer_calls.id
		group by call_id,users_first_name,users_last_name,customers_first_name,customers_last_name,customers_phone_number,reasons;
		
		
		select avg(customer_call_counts) 
			from  (select count (*) as customer_call_counts from customer_calls group by customer_calls.customer_id) as sub_customer_calls;		
	 

	

