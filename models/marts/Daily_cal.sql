-- {{ config(schema='xs_final') }}
------daily sum of usd charges with datapoint_id and date for equipment
with overall_price as
(
select *
from {{ref("Prices")}}
)
select
dt.D_ID,
dt.created,
dt.EQUIPMENT_ID,
dt.ORIGIN_PID,
dt.DESTINATION_PID,
dt.SUPPLIER_ID,
dt.COMPANY_ID,
sum(orp.USD_Value) as USD_charges
from overall_price as orp
join {{ref("sources_datapoints")}} as dt
on orp.D_ID=dt.D_ID
and orp.CREATED=dt.CREATED
-- where dt.created='2021-04-16' 
-- and dt.origin_pid='898' and dt.destination_pid='504' 
-- and dt.equipment_id='2'
-- and dt.D_ID='381811145'
group by 
1,2,3,4,5,6,7
-- order by D_ID
order by dt.created,dt.EQUIPMENT_ID,dt.ORIGIN_PID,dt.DESTINATION_PID