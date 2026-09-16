-- Завдання 1.3
SELECT 'products' AS t, COUNT(*) FROM products
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'employees', COUNT(*) FROM employees
UNION ALL SELECT 'events', COUNT(*) FROM events
UNION ALL SELECT 'customer_data', COUNT(*) FROM customer_data
UNION ALL SELECT 'product_catalog', COUNT(*) FROM product_catalog
UNION ALL SELECT 'products_with_categories', COUNT(*) FROM products_with_categories;
-- Завдання 2.1
select 
  name,
  price,
  ceil(price) as price_ceil,
  round(cast(sqrt(price) as numeric),2) as price_sqrt
from 
	products
order by 
	id;
-- Завдання 2.2
select
  name,
  price,
  mod(price,1000) as price_rest
from 
	products
order by 
	id;
-- Завдання 2.3
select
  name,
  coalesce(discount,0) as discount,
  case
    when coalesce(discount,0) < 0.07 then 'Мінімальна'
    when coalesce(discount,0) <= 0.12 then 'Середня'
    else 'Висока'
  end as discount_level
from 
	products
order by 
	id;
-- Завдання 2.4
select
  name,
  round(price*coalesce(discount,0),2) as money_discount,
  round(greatest(price*coalesce(discount,0),1000),2) as max_discount
from 
	products
order by 
	id;
-- Завдання 2.5
select
  name,
  price,
  least(price,18000) as capped_price
from 
	products
order by 
	id;
-- Завдання 3.1
select
  count(*) as orders_count,
  sum(total_amount) as total_sales,
  round(avg(total_amount),2) as avg_amount,
  min(total_amount) as min_amount,
  max(total_amount) as max_amount
from 
	orders;
-- Завдання 3.2
select
  region,
  count(*) as orders_count,
  sum(total_amount) as total_sales,
  avg(total_amount) as avg_amount
from 
	orders
group by 
	region
order by 
	total_sales desc;
-- Завдання 3.3
select
  customer_id,
  count(*) as orders_count,
  sum(total_amount) as total_spent
from 
	orders
group by 
	customer_id
having 
	count(*) > 1
order by qqq
	customer_id;
-- Завдання 3.4
select
  customer_id,
  count(distinct region) as regions_count,
  string_agg(distinct region,', ' order by region) as regions
from 
	orders
group by 
	customer_id
having 
	count(distinct region) > 1
order by 
	customer_id;
-- Завдання 3.5qqqqqqqqqqqqqqqqqqqqqqqq
select
  region,
  round(avg(total_amount),2) as avg_amount,
  round(stddev(total_amount),2) as stddev_amount,
  round(variance(total_amount),2) as variance_amount
from 
	orders
group by 
	region
order by 
	region;
-- Завдання 4.1
select
  id,
  first_name,
  last_name,
  lower(left(last_name,3) || left(first_name,3) || id::text) as login
from 
	employees
order by 
	id;
-- Завдання 4.2
select
  id,
  first_name,
  last_name,
  length(bio) as bio_length,
  left(bio,50) || '...' as bio_short
from 
	employees
where 
	length(bio) > 50
order by 
	id;
-- Завдання 4.3
select
  id,
  department,
  trim(department) as department_trimmed,
  bio,
  trim(bio) as bio_trimmed
from 
	employees
where 
	department != trim(department)
    or bio != trim(bio)
order by 
	id;
-- Завдання 4.4
 select distinct
 	split_part(email,'@',2) as domain
from 
	employees;
-- Завдання 4.5
select
  id,
  first_name,
  last_name
from 
	employees
where 
	last_name like '% %'
order by 
	id;
-- Завдання 4.6
select
  department,
  string_agg(bio,'; ') as bios
from 
	employees
group by 
	department
order by 
	department;
-- Завдання 4.7
select
  lpad(id::text,5,'*') as padded_id,
  first_name,
  last_name
from 
	employees
order by 
	id;
-- Завдання 5.1
select
  event_name,
  round(extract(epoch from (end_date-start_date))/3600.0,1) as duration_hours,
  round(extract(epoch from (end_date-start_date))/86400.0,2) as duration_days
from 
	events
order by 
	id;
																																																																																																																							-- Завдання 5.2
select
  event_name,
  to_char(start_date,'DD.MM.YYYY HH24:MI') as start_formatted,
  to_char(end_date,'FMMonth DD, YYYY') as end_formatted
from 
	events
order by 
	id;
-- Завдання 5.3
select
  event_name,
  start_date,
  case
    when start_date < now() then 'Минуле'
    else 'Майбутнє'
  end as status
from 
	events
order by 
	id;
-- Завдання 5.4
select
  event_name,
  registration_deadline,
  start_date,
  round(extract(epoch from (start_date-registration_deadline))/86400.0,1) as days_before_start
from 
	events
where 																																																																													
	registration_deadline > start_date - interval '7 days'
order by 
	id;
-- Завдання 5.5
select
  event_name,
  case to_char(start_date,'id')
    when '1' then 'Понеділок'
    when '2' then 'Вівторок'
    when '3' then 'Середа'
    when '4' then 'Четвер'
    when '5' then 'П''ятниця'
    when '6' then 'Субота'
    when '7' then 'Неділя'
  end as weekday
from 
	events
order by 
	id;
-- Завдання 5.6
select
  event_name,
  start_date,
  start_date - interval '3 days' as reminder_date
from 
	events
order by 
	id;
-- Завдання 5.7
select
  event_name,
  extract(year from start_date) as event_year,
  extract(month from start_date) as event_month,
  extract(quarter from start_date) as event_quarter
from 
	events
order by 
	id;
-- Завдання 6.1
select
  name,
  case
    when email is not null and phone is not null then email || ', ' || phone
    when email is not null then email
    when phone is not null then phone
    else ''
  end as contact_status
from 
	customer_data
order by 
	id;
-- Завдання 6.2
select
  name,
  coalesce(email,'Немає email') as email,
  coalesce(phone,'Немає телефону') as phone,
  coalesce(address,'Адреса не вказана') as address,
  coalesce(total_purchases,0) as total_purchases,
  coalesce(to_char(last_purchase_date, 'YYYY-MM-DD'),'Немає покупок') as last_purchase_date
from 
	customer_data
order by 
	id;
-- Завдання 6.3
select
  id,
  name,
  total_purchases
from 
	customer_data
where 
	total_purchases is null 
	or total_purchases = 0
order by 
	id;
-- Завдання 6.4
select
  id,
  name
from 
	customer_data
where 
	email is null 
	and phone is null
order by 
	id;
-- Завдання 6.5
select
  count(*) as total,
  count(email) as with_email,
  count(phone) as with_phone,
  count(address) as with_address,
  count(case when email is null and phone is null and address is null then 1 end) as with_nothing
from 
	customer_data;
-- Завдання 7.1
select
  name,
  attributes ->> 'model' as brand,
  coalesce(attributes #>> '{specs,memory,ram}','Не вказано') as ram
from 
	product_catalog
order by 
	id;
-- Завдання 7.2
select
  name,
  attributes -> 'specs' ->> 'battery' as battery
from 
	product_catalog
where
	attributes -> 'specs' ? 'battery'
order by
	id;
-- Завдання 7.3
select
  name,
  tags
from 
	product_catalog
where 
	tags ?| array['gaming', 'wearables', 'audio']
order by 
	id;
-- Завдання 7.4
select
  sum(case when attributes #>'{specs,screen}' is not null then 1 end) as with_screen,
  sum(case when attributes #>'{specs,battery}' is not null then 1 end) as with_battery,
  sum(case when attributes #>'{specs,gps}' is not null then 1 end) as with_gps,
  sum(case when (attributes -> 'specs') ?| array['screen','battery','gps'] then 1 end) as with_any
from 
	product_catalog;
-- Завдання 7.5
select
  name,
  key as attr_key,
  value as attr_value
from 
	product_catalog,jsonb_each(attributes)
order by id;
-- Завдання 7.6
select
  jsonb_object_agg(brand,names) as result
from (
  select
    attributes ->> 'brand' as brand,
    jsonb_agg(name order by name asc) as names
  from 
  	product_catalog
  group by
  	attributes ->> 'brand') k;
-- Завдання 7.7
update 
	product_catalog
set 
	attributes = jsonb_set(
    attributes,'{specs,warranty}','"1 рік"'::jsonb,
  true
)
where not
	(attributes -> 'specs' ? 'warranty');

select
  name,
  attributes #>> '{specs,warranty}' as warranty
from 
	product_catalog
order by 
	id;
-- Завдання 8.1
select 
	string_agg(name,', ' order by id asc) as products
from 
	products_with_categories;
-- Завдання 8.2
select
  name,
  categories,
  array_length(categories,1) as categories_count
from 
	products_with_categories
where 
	array_length(categories,1) > 2
order by 
	id;
-- Завдання 8.3
select
  name,
  categories
from 
	products_with_categories
where 
	categories && array['Гаджети','Ноутбуки','Аудіо']
order by  
	id;
-- Завдання 8.4
select
  name,
  unnest(specifications) as specification
from 
	products_with_categories
order by 
	id;
-- Завдання 8.5
select
  name,
  count(spec) as numeric_specs_count
from 
	products_with_categories,unnest(specifications) as spec
where 
	spec ~ '[0-9]'
group by 
	id,
	name
having 
	count(spec) >= 2
order by 
	id;
-- Завдання 8.6
select
  unnest(categories) as category,
  count(*) as products_count,
  sum(price) as total_price
from 
	products_with_categories
group by 
	category
order by 
	total_price desc;
-- Завдання 8.7
update 
	products_with_categories
set 
	categories = array_append(categories,'Топ-продаж')
where not 
	'Топ-продаж' = any(categories);

select
  name,
  categories
from 
	products_with_categories
order by 
	id;
 