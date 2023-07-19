use swiggy_sql_analysis;

# checking if exact no of records got inserted or not
select count(*) from items;
select count(*) from orders;

select * from orders;
select * from items;

# distinct items ordered by the customer
select distinct name from items;
select count( distinct name) as distinct_items_ordered_sofar from items;


# Veg items ordered so far
select name from items where is_veg=1;
select count(name) from items where is_veg=1;

# Orders with items characterised by Veg/Non-Veg ordered so far
select count(name) as count, is_veg from items group by is_veg order by count(name) desc;
# Understanding the value of is_veg=2
select name from items where is_veg=2;

# Orders containing chicken
select * from items where name like '%chicken%';

# average no of items in each order
select count(name)/count(distinct order_id) as avg_items_perorder from items;

# Number of times a particular product was ordered
select name, count(*) as count from items group by name order by count(*) desc;

# Number of restaurants ordered so far
select count(distinct restaurant_name) as distinct_restaurants_orderedsofar from orders;

# Number of Orders ordered from a restaurant
select restaurant_name, count(*) as no_of_orders from orders group by restaurant_name order by count(*) desc;

# Monthwise number of Orders 
select date_format(order_time,'%Y-%m') as ordered_date, count( distinct order_id) as no_of_orders from orders
group by date_format(order_time,'%Y-%m') order by count(distinct order_id) desc;

# Last order datetime
select max(order_time) from orders;

# Monthwise money spend on orders
select date_format(order_time,'%Y-%m') as ordered_date, sum(order_total) as no_of_orders from orders
group by date_format(order_time,'%Y-%m') order by sum(order_total) desc;

# average value of order purchase
select sum(order_total)/count(distinct order_id) as avg_order_value from orders;

# Yearly money spend on orders
select date_format(order_time,'%Y') as year_order, sum(order_total) as no_of_orders from orders
group by date_format(order_time,'%Y') order by sum(order_total) desc;

# Yearly money spend on orders with rankings
with year_data as(
select date_format(order_time,'%Y') as year_order, sum(order_total) as total_revenue from orders
group by date_format(order_time,'%Y'))
select year_order, total_revenue , rank() over(order by total_revenue desc) as rankings from year_data;

# Restaurant rankings based on money spent
with restaurant_revenue as(
select restaurant_name, sum(order_total) as total_money_spent from orders group by restaurant_name)
select restaurant_name, total_money_spent,rank() over(order by total_money_spent desc) as ranking from restaurant_revenue;


select * from items;
select * from orders;

# Using Joins to fetch details about each order
select a.name, a.is_veg,b.order_total,b.restaurant_name,b.order_time from items a 
join orders b on a.order_id=b.order_id;
# Identifying combinations of items ordered
select a.order_id,a.name as name1,b.name as name2,concat(a.name," - ",b.name) as combo_ordered 
from items a join items b
on a.order_id=b.order_id
where a.name!=b.name; 










