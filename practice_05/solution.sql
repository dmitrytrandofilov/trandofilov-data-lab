--Завдання 1.3
SELECT 'sales' AS t, COUNT(*) FROM sales
UNION ALL
SELECT 'stock_prices', COUNT(*) FROM stock_prices;
--Завдання 2.1
select
  store_id,
  sum(total_amount) as total_store_sales
from 
	sales
group by 	
	store_id
order by 
	store_id;
select
sale_id,
  store_id,
  total_amount,
  sum(total_amount) over () as total_all_sales
from 
	sales
order by 
	sale_id;
--Завдання 2.2
select
  sale_id,
  store_id,
  total_amount,
  round(avg(total_amount) over (),2) as avg_all
from 
	sales
order by 
	sale_id;
--Завдання 2.3
select
  sale_id,
  total_amount,
  count(*) over () as sales_count
from 
	sales
order by 
	sale_id;
--Завдання 2.4
select
  sale_id,
  store_id,
  total_amount,
  round((total_amount/sum(total_amount) over ())*100,2) as pct_of_total
from 
	sales
order by 
	sale_id;
--Завдання 2.5
select
  sale_id,
  store_id,
  total_amount,
  rank() over (order by total_amount desc) as overall_rank
from 
	sales
order by 
	overall_rank,
	sale_id;
--Завдання 3.1
select
  sale_id,
  store_id,
  total_amount,
  round(avg(total_amount) over (partition by store_id),2) as avg_store_sales
from 
	sales
order by 
	store_id,
	sale_id;
--Завдання 3.2
select
  sale_id,
  store_id,
  total_amount,
  sum(total_amount) over w as store_total,
  min(total_amount) over w as store_min,
  max(total_amount) over w as store_max,
  count(*) over w as store_sales_cnt
from 
	sales
window 
	w as (partition by store_id)
order by 
	store_id,
	sale_id;
--Завдання 3.3
select
  sale_id,
  store_id,
  total_amount,
  round(total_amount - avg(total_amount) over w,2) as diff_from_avg
from 
	sales
window 
	w as (partition by store_id)
order by 
	store_id,
	sale_id;
--Завдання 3.4
select
  sale_id,
  store_id,
  total_amount,
  round(total_amount/sum(total_amount) over w * 100,2) as pct_of_store
from 
	sales
window 
	w as (partition by store_id)
order by 
	store_id,
	sale_id;
--Завдання 3.5
select
  sale_id,
  store_id,
  total_amount,
  avg_store_sales
from (
  select
    sale_id,
    store_id,
    total_amount,
    round(avg(total_amount) over (partition by store_id),2) as avg_store_sales
  from sales
) k
where 
	total_amount > avg_store_sales
order by 
	store_id, 
	sale_id;
-- Завдання 4.1
select
  	sale_id, 
	store_id, 
	total_amount,
  row_number() over (partition by store_id order by sale_date,sale_id) as sale_rank
from 
	sales;
-- Завдання 4.2
select
  	sale_id, 
	store_id, 
	total_amount,
  rank() over (partition by store_id order by total_amount desc,sale_id) as amount_rank
from 
	sales;
-- Завдання 4.3
select
  	sale_id, 
	store_id, 
	total_amount,
  rank() over (partition by store_id order by total_amount desc,sale_id) as amount_rank,
  dense_rank() over (partition by store_id order by total_amount desc,sale_id) as amount_dense
from 
	sales;
/* 
У наведеному прикладі різниця відсутня. Відмінність rank() та dense_rank() полягає у тому, що перший робить пропуск у нумерації після однакових значень,
а другий нумерує без пропусків (1, 2, 2, 3). Різниця була б помітна у магазині з однаковими total_amount.
*/
-- Завдання 4.4
select
  	sale_id, 
	store_id, 
	total_amount,
  ntile(2) over (partition by store_id order by total_amount desc,sale_id) as half
from 
	sales;
-- Завдання 4.5
select
  	sale_id, 
	store_id, 
	sale_date,
	total_amount,
  rank() over (partition by sale_date order by total_amount desc,sale_id) as date_rank
from 
	sales;
-- Завдання 4.6
select
  	sale_id, 
	store_id, 
	sale_date,
	product_id,
	total_amount,
  row_number() over (partition by product_id order by sale_date,sale_id) as product_rank
from 
	sales;
-- Завдання 5.1
select 
  sale_id,
  store_id,
  lag(total_amount) over w as previous_sale_amount
from 
	sales
window 
	w as (partition by store_id order by sale_date,sale_id);
-- Завдання 5.2
select
  sale_id,
  store_id,
  lag(total_amount) over w as previous_sale_amount,
  lead(total_amount) over w as next_sale_amount
from 
	sales
window 
	w as (partition by store_id order by sale_date,sale_id);
-- Завдання 5.3
select
  sale_id,
  store_id,
  lag(total_amount) over w as previous_sale_amount,
  lead(total_amount) over w as next_sale_amount,
  total_amount - lag(total_amount) over w as diff_prev
from 
	sales
window 
	w as (partition by store_id order by sale_date,sale_id);
-- Завдання 5.4
select
  sale_id,
  store_id,
  coalesce(lag(total_amount) over w,0) as previous_sale_amount,
  lag(total_amount,1,0) over w as previous_sale_amount_2
from 	
	sales
window 
	w as (partition by store_id order by sale_date,sale_id);
-- Завдання 5.5
select
  sale_id,
  store_id,
  lag(total_amount,2) over w as two_sales_ago
from 
	sales
window 
	w as (partition by store_id order by sale_date,sale_id);
-- Завдання 5.6
select
  sale_id,
  store_id,
  total_amount,
  coalesce(lag(total_amount) over w,0) as previous_sale_amount,
  case
    when lag(total_amount) over w is null then 'перший продаж'
    when total_amount > lag(total_amount) over w then 'зростання'
    when total_amount < lag(total_amount) over w then 'падіння'
    else 'без змін'
  end as trend
from 
	sales
window 
	w as (partition by store_id order by sale_date, sale_id);
-- Завдання 6.1
select 
	sale_id, 
	store_id, 
	total_amount, 
	sum(total_amount) over (partition by store_id order by sale_date,sale_id) as cumulative_store_sales
from 
	sales;
-- Завдання 6.2
select 
	sale_id, 
	store_id, 
	quantity_sold, 
	sum(quantity_sold) over (partition by store_id order by sale_date,sale_id) as cumulative_qty
from 
	sales;
-- Завдання 6.3
select 
	sale_id, 
	store_id, 
	total_amount, 
	avg(total_amount) over (partition by store_id order by sale_date,sale_id rows between 2 preceding and current row) as moving_avg_3rows
from 
	sales;
-- Завдання 6.4
select 
	sale_id, 
	store_id, 
	total_amount, 
	avg(total_amount) over (partition by store_id order by sale_date,sale_id rows between 2 preceding and current row) as moving_avg_3rows,
	avg(total_amount) over (partition by store_id order by sale_date range between interval '2 days' preceding and current row) as moving_avg_3days
from 
	sales;
-- Завдання 6.5
select 
	sale_id, 
	store_id, 
	total_amount, 
	max(total_amount) over (partition by store_id ORDER BY sale_date, sale_id rows between unbounded preceding and current row) as running_max 
from 
	sales;
-- Завдання 7.1
	select 	
		stock_id, 
		stock_symbol, 
		price_date, 
		closing_price, 
		lag(closing_price) over (partition by stock_symbol order by price_date) as yesterday_price, 
		lead(closing_price) over (partition by stock_symbol order by price_date) as tomorrow_price
	from 
		stock_prices;
-- Завдання 7.2
select 
	stock_id, 
	stock_symbol, 
	price_date, 
	closing_price, 
	closing_price - lag(closing_price) over (partition by stock_symbol order by price_date) as price_delta
from 
	stock_prices;
-- Завдання 7.3
select 
	stock_id, 
	stock_symbol, 
	price_date, 
	closing_price, 
	round((closing_price - lag(closing_price) over (partition by stock_symbol order by price_date))/lag(closing_price) over (partition by stock_symbol order by price_date) * 100,2) as pct_change
from 
	stock_prices;
-- Завдання 7.4
select 
	stock_id, 
	stock_symbol, 
	price_date, 
	closing_price, 
	first_value(closing_price) over (partition by stock_symbol order by price_date) as first_price, 
	round((closing_price - first_value(closing_price) over (partition by stock_symbol order by price_date)) / first_value(closing_price) over (partition by stock_symbol order by price_date) * 100, 2) as growth_from_start_pct
from 
	stock_prices;
-- Завдання 7.5
select 
	stock_id, 
	stock_symbol, 
	price_date, 
	closing_price, 
	max(closing_price) over (partition by stock_symbol) as max_price, 
	max(closing_price) over (partition by stock_symbol) - closing_price as diff_from_max
from 
	stock_prices;
-- Завдання 7.6
with cte_ as (
	select 
		stock_symbol, 
		price_date, 
		closing_price, 
		closing_price - lag(closing_price) over (partition by stock_symbol order by price_date) as price_delta
	from 
		stock_prices
)
select 
	stock_symbol, 
	price_date, 
	closing_price, 
	price_delta, 
	sum(coalesce(price_delta,0)) over (partition by stock_symbol order by price_date) as cumulative_change
from 
	cte_;
-- Завдання 7.7
with price_changes as (
	select 
		stock_id, 
		stock_symbol, 
		price_date, 
		closing_price, 
		closing_price - lag(closing_price) over (partition by stock_symbol order by price_date) as price_delta
	from 
		stock_prices
)
select 
	stock_id, 
	stock_symbol, 
	price_date, 
	closing_price, 
	case 
		when price_delta > 0 
		     and lag(price_delta) over (partition by stock_symbol order by price_date) > 0 
		then 'так' 
		else 'ні' 
	end as three_day_growth
from 
	price_changes;
-- Завдання 8.1
select 
	store_id, 
	sale_id, 
	sale_date, 
	total_amount
from (
	select 
		sale_id, 
		store_id, 
		sale_date, 
		total_amount,
		row_number() over (partition by store_id order by total_amount desc,sale_id) as rn
	from 
		sales
) t
where 
	rn = 1;
-- Завдання 8.2
with store_dates as (
	select distinct
		store_id, 
		first_value(sale_date) over (partition by store_id order by sale_date) as first_sale_date,
		last_value(sale_date) over (partition by store_id order by sale_date rows between unbounded preceding and unbounded following) as last_sale_date
	from 
		sales
)
select 
	store_id,
	first_sale_date,
	last_sale_date,
	last_sale_date - first_sale_date as days_between
from 
	store_dates;
-- Завдання 8.3
select 
	product_id, 
	sum(total_amount) as product_total, 
	rank() over (order by sum(total_amount) desc) as product_rank
from 
	sales
group by product_id;