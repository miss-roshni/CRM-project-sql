CREATE OR REPLACE VIEW crm_masterview
 AS
 SELECT c.customerid,
    c.email AS customeremail,
    p.productname
   FROM crm.customers c
     LEFT JOIN crm.salesrepresentatives s ON c.assigned_salesrepid = s.salesrepid
     LEFT JOIN crm.orders o ON c.customerid = o.customerid
     LEFT JOIN crm.order_item oi ON o.orderid = oi.orderid
     LEFT JOIN crm.products p ON oi.productid = p.productid
     LEFT JOIN crm.leads l ON l.email::text = c.email::text
     LEFT JOIN crm.interactions i ON l.leadid = i.leadid
     LEFT JOIN crm.tasks t ON s.salesrepid = t.assigned_to;

ALTER TABLE public.crm_masterview
    OWNER TO postgres;

----- create procedure to get the top 5 selling product ---

--- create table for top 5 daily products 
create table if not exists crm.daily_top_products(
report_date date not null,
product_id int not null,
total_sales int not null,
	rank int not null,
	created_at timestamp default now()
)


select * from crm.daily_top_products

---create a procedure 

create or replace procedure insert_daily_top_products()
language plpgsql
as $$

begin
    
	 ---delete the old entries from the table ---
	 delete from crm.daily_top_products
	 where report_date=current_date;
	 
	 --- now insert the top 5 products --
	 
	 insert into crm.crm.daily_top_products(report_date,product_id,total_sales,rank)
	 select 
	      current_date as report_date,oi.product_id,
		  sum(oi.quantity*oi.unit_price) as total_sale,
		  rank() over(order by sum(oi.quantity*oi.unit_price) desc) as rank
	 from orders as o
	 inner join order_item as oi on o.order_id=oi.order_id
	 inner join products as p on oi.product_id=p.product_id
	 where o.order_date=current_date
	 group by oi.product_id
	 order by total_sale desc
	 limit 5;
end;
$$;

select * from crm.products
insert into crm.products
values (1,'Laptop','IT',20000,10),(2,'Mobile','Phone',10000,20),
(3,'Pan Tab','Education',5000,50),
(4,'IPAD','LEARNING',50000,30),
(5,'HeadPhone','Song',25000,100),
(6,'Charger','Battery',6000,80)


