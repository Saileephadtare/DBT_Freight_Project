
with stage_datapoints as 
(
select * from 
{{ref("sources_datapoints")}}
),
-- considered created date is between '2021-01-01' and '2022-06-01'
datapoints_day as(
select 
D_ID,
CREATED,
ORIGIN_PID,
DESTINATION_PID,
COMPANY_ID,
SUPPLIER_ID,
EQUIPMENT_ID
from
stage_datapoints
where 
CREATED between '2021-01-01' and '2022-06-01'
group by 1,2,3,4,5,6,7
order by CREATED
),
--joined datapoint and charges table basd on D_id to get currency value for datapoints 
charges_with_date as(
select dt.*, 
st.CHARGE_VALUE,
st.CURRENCY
from datapoints_day as dt
join 
{{ref("sources_charges")}} as st
on dt.D_ID=st.D_ID
),
----- joined charges table with exchange rate based on currecy 
-----joined datapoints with exchange rate based on date
datapoints_exchange_rate as(
select 
cd.D_ID,
cd.ORIGIN_PID,
cd.DESTINATION_PID,
cd.COMPANY_ID,
cd.SUPPLIER_ID,
cd.CREATED,
cd.EQUIPMENT_ID,
cd.CHARGE_VALUE,
cd.CHARGE_VALUE/ext.rate as USD_Value,
cd.CURRENCY as charge_currency,
ext.rate
from
charges_with_date as cd
join
{{ref("sources_exchange_rate")}} as ext
on cd.CREATED = ext.DAY
and cd.CURRENCY=ext.CURRENCY
)
select * from datapoints_exchange_rate