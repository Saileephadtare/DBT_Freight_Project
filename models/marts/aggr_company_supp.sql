-- {{ config(schema='xs_final') }}

with equip_datapoints as(
    select 
    CREATED,
    EQUIPMENT_ID,
    ORIGIN_PID,
    DESTINATION_PID,
    SUPPLIER_ID,
    COMPANY_ID,
    USD_charges
    from {{ref("Daily_cal")}}
)
select 
CREATED,
EQUIPMENT_ID,
-- ORIGIN_PID,
-- DESTINATION_PID,
-- SUPPLIER_ID,
-- COMPANY_ID,
avg(USD_charges) as avg_pricing,
PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY USD_charges) AS median_daily_price,
(case when count(distinct SUPPLIER_ID)>=2 and count(distinct COMPANY_ID>=2) then True
      when count(distinct SUPPLIER_ID)<2 and count(distinct COMPANY_ID<2) then False end) as Data_QA

from
equip_datapoints
-- where created='2021-04-16' 
-- and origin_pid='898' and destination_pid='504' 
-- and equipment_id='2'
group by 1,2
order by 2
