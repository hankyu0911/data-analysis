-- create database testdb;

-- use testdb;

-- CREATE TABLE orders (
--     order_id INT PRIMARY KEY,
--     user_id INT,
--     order_date DATE,
--     amount DECIMAL(10,2)
-- );

-- 첫구매 기간별 Retention(Monthly)
with first_order as (
	select
		order_id,
        user_id,
        order_date,
        amount,
        min(order_date) over (partition by user_id) first_order_date
	from orders
)
,
cohort as (
	select
		*,
        timestampdiff(MONTH, first_order_date, order_date) + 1 cohort_index
	from first_order
)
select
	date_format(first_order_date, '%Y%m') first_order_ym,
    count(distinct case when cohort_index = 1 then user_id end) / count(distinct case when cohort_index = 1 then user_id end) '1',
    count(distinct case when cohort_index = 2 then user_id end) / count(distinct case when cohort_index = 1 then user_id end)  '2',
    count(distinct case when cohort_index = 3 then user_id end) / count(distinct case when cohort_index = 1 then user_id end)  '3',
    count(distinct case when cohort_index = 4 then user_id end) / count(distinct case when cohort_index = 1 then user_id end)  '4',
    count(distinct case when cohort_index = 5 then user_id end) / count(distinct case when cohort_index = 1 then user_id end)  '5',
    count(distinct case when cohort_index = 6 then user_id end) / count(distinct case when cohort_index = 1 then user_id end)  '6',
    count(distinct case when cohort_index = 7 then user_id end) / count(distinct case when cohort_index = 1 then user_id end)  '7',
    count(distinct case when cohort_index = 8 then user_id end) / count(distinct case when cohort_index = 1 then user_id end)  '8',
    count(distinct case when cohort_index = 9 then user_id end) / count(distinct case when cohort_index = 1 then user_id end)  '9',
    count(distinct case when cohort_index = 10 then user_id end) / count(distinct case when cohort_index = 1 then user_id end)  '10',
    count(distinct case when cohort_index = 11 then user_id end) / count(distinct case when cohort_index = 1 then user_id end)  '11',
    count(distinct case when cohort_index = 12 then user_id end) / count(distinct case when cohort_index = 1 then user_id end)  '12'
from cohort
group by first_order_ym
order by first_order_ym;


-- MAU
select
	date_format(order_date, '%Y%m') order_ym,
    count(distinct user_id) MAU,
    round(sum(amount) / count(distinct user_id), 0) ARPPU
from orders
group by order_ym
order by order_ym;




