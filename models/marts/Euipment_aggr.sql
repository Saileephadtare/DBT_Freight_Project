-- median  and average daily price for lane,date and equipment type

with equip_datapoints as(
    select 
    CREATED,
    EQUIPMENT_ID,
    ORIGIN_PID,
    DESTINATION_PID,
    USD_charges
    from {{ref("Daily_cal")}}
)
select 
CREATED,
EQUIPMENT_ID,
ORIGIN_PID,
DESTINATION_PID,
avg(USD_charges) as avg_pricing,
PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY USD_charges) AS median_daily_price
from
equip_datapoints
group by 1,2,3,4
order by 2
