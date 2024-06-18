with raw_exchange_rate as
(

select * from 

 {{ source('xn_raw', 'exchange_rate') }}	

),
exchange_rate_staging as(
    -- select distinct 
    select
    DAY,
    CURRENCY,
    RATE

FROM raw_exchange_rate
)	
SELECT * FROM exchange_rate_staging

		