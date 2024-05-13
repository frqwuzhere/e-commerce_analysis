select * from customer_detail;

-- task 1 
select
	extract(month from order_date) as month
    ,round(sum(after_discount),2) as total_sales
from order_detail
where extract(year from order_date) = 2021
	and is_valid = 1
group by 1
order by 2 desc;

-- task 2
select 
	extract(month from order_date) as bulan
	,count(distinct customer_id) as pelanggan
    ,count(distinct id) as orderan
    ,count(qty_ordered) as kuantiti
from order_detail
where extract(year from order_date) = 2021
	and is_valid = 1
group by 1
order by 2 desc;

-- task 3
select
	sd.category
    ,sum(od.after_discount) as total_sales
from order_detail od
left join sku_detail sd
on od.sku_id = sd.id
where extract(year from od.order_date) = 2022
	and od.is_valid = 1
group by 1
order by 2 desc;

-- task 4
with compared_sales as (select 
	sd.category
	,sum(case when extract(year from od.order_date) = 2021 then od.after_discount end) AS sales_2021
    ,sum(case  when extract(year from od.order_date) = 2022 then od.after_discount end) AS sales_2022
from order_detail od
left join sku_detail sd
on od.sku_id = sd.id
group by 1)
select 
	category
    ,sales_2021
    ,sales_2022
    , case 
		when sales_2022 - sales_2021 > 0 then 'naik'
        else 'turun'
	end as diff_status
from compared_sales
group by 1
order by 4;

-- task 5
select
	sd.sku_name
    ,sd.category
    ,sum(od.after_discount)
    ,count(distinct od.customer_id)
    ,count(distinct od.id)
    ,sum(od.qty_ordered)
from order_detail od
left join sku_detail sd
on od.sku_id = sd.id
where extract(year from od.order_date) = 2022
	and od.is_valid = 1
group by 1,2
order by 3 desc
limit 10;

-- task 6
select
	pd.payment_method
    ,count(distinct od.id) total_transactions
from order_detail od
left join payment_detail pd
on od.payment_id = pd.id
where extract(year from od.order_date) = 2022
	and is_valid = 1
group by 1
order by 2 desc
limit 5;

-- task 7
select 
	(case
		when sd.sku_name like '%samsung%' then 'samsung'
        when sd.sku_name like '%sony%' then 'sony'
        when sd.sku_name like '%apple%' then 'apple'
        when sd.sku_name like '%huawei%' then 'huawei'
        when sd.sku_name like '%lenovo%' then 'lenovo'
        else null
	end) product
	,sum(od.after_discount) total_sales
from order_detail od
left join sku_detail sd
on od.sku_id = sd.id
where od.is_valid = 1 and
	(case
		when sd.sku_name like '%samsung%' then 'samsung'
        when sd.sku_name like '%sony%' then 'sony'
        when sd.sku_name like '%apple%' then 'apple'
        when sd.sku_name like '%huawei%' then 'huawei'
        when sd.sku_name like '%lenovo%' then 'lenovo'
        else null
	end)
    is not null
group by 1
order by 2 desc;

-- task 8
with compared_sales as (select 
	sd.category
	,round(sum(case when extract(year from od.order_date) = 2021 then od.after_discount - (sd.cogs * od.qty_ordered) end),2)  AS profit_2021
    ,round(sum(case  when extract(year from od.order_date) = 2022 then od.after_discount - (sd.cogs * od.qty_ordered) end),2)  AS profit_2022
from order_detail od
left join sku_detail sd
on od.sku_id = sd.id
group by 1)
select 
	category
    ,profit_2021
    ,profit_2022
    ,round(100 * ((profit_2022 - profit_2021) / profit_2021)) as diff
from compared_sales
group by 1
order by 4 desc;

-- task 9
select 
	sd.sku_name,
	sum(od.after_discount - (sd.cogs * od.qty_ordered)) profit
from order_detail od
left join sku_detail sd
on od.sku_id = sd.id
where sd.category = 'Health & Sports'
	and od.is_valid = 1
    and extract(year from od.order_date) = 2022
group by 1
order by 2 desc
limit 5;

-- task 10
select
	sd.category
    ,count(distinct case when pd.payment_method = 'cod' then od.id end)  as cod
    ,count(distinct case when pd.payment_method = 'Payaxis' then od.id end) as payaxis
    ,count(distinct case when pd.payment_method = 'customercredit' then od.id end) as customercredit
    ,count(distinct case when pd.payment_method = 'Easypay' then od.id end) as easypay
    ,count(distinct case when pd.payment_method = 'jazzwallet' then od.id end) as jazzwalet
from order_detail od
left join payment_detail pd
on od.payment_id = pd.id
left join sku_detail sd
on od.sku_id = sd.id
where extract(year from od.order_date) = 2022
	and is_valid = 1
group by 1
order by 2 desc

