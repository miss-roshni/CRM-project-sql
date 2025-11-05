create schema crm
---- create customers table ----


create table crm.customer(
	
	customer_id int primary key,
	first_name varchar(200),
	last_name varchar(200),
	email varchar(200),
	phone_number varchar(14),
	Adress varchar(200),
	assigned_sale_repID int,
	customer_join_date date ,
	foreign key(assigned_sale_repID)
	references crm.salesrepresentatives(salerep_ID)
)


--- create salesrepresentatives table --


create table crm.salesrepresentatives(
	salerep_ID int primary key,
	first_name varchar(200),
	last_name varchar(200),
	email varchar(200),
	phone_number varchar(14),
	department varchar(200)
	
)
--- CREATE order table ----


create table crm.orders(
	order_id int primary key,
	customer_id int,
	order_date date,
	total_amount float,
	foreign key (customer_id)
	references crm.customer(customer_id)
)
------create products table------
create table crm.products(
	
	product_id int primary key,
	product_name varchar(200),
	description varchar(200),
	price float,
	quantity_in_stock int
)


---- create order items ---

create table crm.order_items(
	
	order_item_id int primary key,
	order_id int,
	product_id int,
	quantity int,
	unit_price float,
	foreign key (order_id) references crm.orders(order_id),
	foreign key (product_id) references crm.products(product_id)
)

--- create lead table ----


create table crm.leads(
	
	lead_id int primary key,
	first_name varchar(200),
	last_name varchar(200),
	email varchar(50),
	phone_number bigint,
	address varchar(200),
	source varchar(20),
	status varchar(200),
	notes text,
	lead_creation_date date
)



---- create table interactions ----

create table crm.interactions(
	
	interaction_id int primary key,
	lead_id int,
	sales_rep_id int,
	interaction_date date,
	interaction_type varchar(200),
	outcome varchar(200),
	notes text,
	foreign key (sales_rep_id) references 
    crm.salesrepresentatives(salerep_id),
	foreign key (lead_id) references crm.leads(lead_id)
	)
	
--- create task table ---


create table crm.tasks(
	
	task_id int primary key,
	description varchar(200),
	due_date date,
	status varchar(200),
	priority varchar(200),
	assigned_to int,
	foreign key (assigned_to) references
    crm.salesrepresentatives(salerep_id)
)
—-- view —-




create view crm_master_view as 
select c.customer_id,c.first_name,c.last_name,c.email,
c.phone_number,c.adress,c.customer_join_date,c.assigned_sale_repid,
s.salerep_id,s.first_name as sales_first_name,
s.last_name as sales_last_name,s.email as sales_email,
s.phone_number as sales_phone_number,s.department,
o.order_id ,o.customer_id as order_cust_id,o.order_date,
o.total_amount,oi.order_item_id,oi.product_id ,oi.quantity,
oi.unit_price,p.product_id as prod_product_id,p.product_name,
p.description,p.price,p.quantity_in_stock,l.lead_id,
l.first_name as lead_first_name,l.last_name as lead_last_name,
l.email as lead_email,l.phone_number as lead_phon_no,
l.source,l.status,l.notes,l.lead_creation_date,
i.interaction_id,i.sales_rep_id as interaction_sales_rep_id,
i.interaction_date,i.interaction_type,i.outcome,i.notes as interaction_notes,
t.task_id,t.description as task_description,t.due_date,
t.status as tasks_status,t.priority
from crm.customer as c 
left join crm.salesrepresentatives as s
on c.assigned_sale_repid=s.salerep_id
left join crm.orders as o
on c.customer_id=o.customer_id
left join crm.order_items as oi
on o.order_id=oi.order_id
left join crm.products as p
on oi.product_id=p.product_id
left join crm.leads as l
on l.email=c.email
left join crm.interactions as i
on l.lead_id=i.lead_id
left join crm.tasks as t
on t.assigned_to=s.salerep_id


select * from crm_master_view

select * from crm.salesrepresentatives

insert into crm.salesrepresentatives
values(101,'Arunima','Rathi','arunima@gamil.com',987654321,'DataScience')

select * from crm.customer

insert into crm.customer
values(1,'Arunima','Rathi','arunima@gmail.com',987367342,'UP',101,NOW())

SELECT * from crm.orders

insert into crm.orders
values(1,1,now(),1000)




	
