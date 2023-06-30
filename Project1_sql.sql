/* Name all the customers whose name starts with "H", with count*/

select * from Customer;

select Customer_name from Customer
where customer_name like 'H%';

select count(Customer_name) as Customer_count from Customer
where customer_name like 'H%';---19

/* Name the cities which has minimum number of customers */

select * from customer;

select customer_id, city from customer
order by city asc;

select count(*) as min_count, city
from customer
group by city
order by min_count asc
limit 148;

/* Name top three cities which has maximum number of customers.*/

select * from customer;

select count(*) as max_count, city
from customer
group by city
order by max_count desc
limit 1;

/* Mention the date which has maximum number of sales in 2017. */

select * from sales;

select count(*) as order_count, order_date from sales
where order_date >= '2017-01-01'
group by order_date
order by order_count desc
limit 1;

/* Mention the product category which has maximum sale in 2017. */

select * from product;
select * from sales;


select product_id, Category from product
order by Category;

select product_id, sale from sales
order by sale desc;

create table Product_count as select sales.product_id, sales.sale, Category
from sales
join product on sales.product_id=product.product_id
order by sale desc;

select * from Product_count;

select sum(sale) as category_sum, category
from Product_count
group by category 
order by category desc
limit 1;

/* Change the age column to Customer age. */

alter table customer rename column age to Customer_age;

select * from customer;

/* Mention the customers which ordered maximum quantity with his name, country and city in all the years.*/

select * from customer;
select * from sales;

create table max_quant as select a.customer_id, a.quantity, b.customer_name, b.country, b.city
from sales as a
join customer as b on a.customer_id = b.customer_id
order by quantity desc;

select * from max_quant;

select * from max_quant 
where quantity = 14;

/* Name of all the customers from United states.*/

select * from customer;

select customer_name, country from customer
where country like '%United_States%';

/*Round of total number of sales in the 2017*/

select * from sales;

create table sale_tot as select sale, extract ('year' from order_date)
from sales;

select * from sale_tot;

alter table sale_tot rename extract to year;

create table tot_sale_2017 as select sum(sale) as total_sale, year
from sale_tot
group by year
order by year desc
limit 1;


select * from tot_sale_2017;

select * , round(total_sale) from tot_sale_2017;

/* Number of months between the order date and ship date of the order which provided the maximum profit in 2017.*/

select * from sales;

select order_date, ship_date, product_id, profit from sales
order by profit desc;

create table profit_det as select order_date, ship_date, extract ('year' from order_date), product_id, profit
from sales
order by extract desc;

select * from profit_det;

alter table profit_det rename extract to year;

select profit, year, order_date, ship_date from profit_det
where year = 2017
order by profit desc;

select age ('2017-03-23', '2017-03-25');

/*Name the product which has maximum number of sale in 2017.*/---Office supplies(634989.25)

select * from product;
select * from sales;

create table max_sale as select a.product_id, a.sale, a.order_date, b.category
from sales as a right join product as b on a.product_id = b.product_id;

create table year_table as select product_id, sale, order_date, category, extract('year' from order_date)
from max_sale;

select sale, category, sum(sale) over(partition by category)
as total from year_table
order by total;
