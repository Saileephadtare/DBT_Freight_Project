-- True if (at least 5 different companies and 2 different suppliers provide data for that day and lane and equipment type).

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
ORIGIN_PID,
DESTINATION_PID,
avg(USD_charges) as avg_pricing,
PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY USD_charges) AS median_daily_price,
CASE 
      WHEN COUNT(DISTINCT SUPPLIER_ID) >= 2 AND COUNT(DISTINCT COMPANY_ID) >= 5 THEN True
      ELSE False 
END AS dq_ok

from
equip_datapoints
group by 1,2,3,4
order by 2
