-- View: public.crm_master_view

-- DROP VIEW public.crm_master_view;

CREATE OR REPLACE VIEW public.crm_master_view
 AS
 SELECT c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.phone_number,
    c.adress,
    c.customer_join_date,
    c.assigned_sale_repid,
    s.salerep_id,
    s.first_name AS sales_first_name,
    s.last_name AS sales_last_name,
    s.email AS sales_email,
    s.phone_number AS sales_phone_number,
    s.department,
    o.order_id,
    o.customer_id AS order_cust_id,
    o.order_date,
    o.total_amount,
    oi.order_item_id,
    oi.product_id,
    oi.quantity,
    oi.unit_price,
    p.product_id AS prod_product_id,
    p.product_name,
    p.description,
    p.price,
    p.quantity_in_stock,
    l.lead_id,
    l.first_name AS lead_first_name,
    l.last_name AS lead_last_name,
    l.email AS lead_email,
    l.phone_number AS lead_phon_no,
    l.source,
    l.status,
    l.notes,
    l.lead_creation_date,
    i.interaction_id,
    i.sales_rep_id AS interaction_sales_rep_id,
    i.interaction_date,
    i.interaction_type,
    i.outcome,
    i.notes AS interaction_notes,
    t.task_id,
    t.description AS task_description,
    t.due_date,
    t.status AS tasks_status,
    t.priority
   FROM crm.customer c
     LEFT JOIN crm.salesrepresentatives s ON c.assigned_sale_repid = s.salerep_id
     LEFT JOIN crm.orders o ON c.customer_id = o.customer_id
     LEFT JOIN crm.order_items oi ON o.order_id = oi.order_id
     LEFT JOIN crm.products p ON oi.product_id = p.product_id
     LEFT JOIN crm.leads l ON l.email::text = c.email::text
     LEFT JOIN crm.interactions i ON l.lead_id = i.lead_id
     LEFT JOIN crm.tasks t ON t.assigned_to = s.salerep_id;

ALTER TABLE public.crm_master_view
    OWNER TO postgres;

