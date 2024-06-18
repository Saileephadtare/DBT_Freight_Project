with raw_charges as
(

select * from 

 {{ source('xn_raw', 'XS_CHARGES') }}	

),
charges_staging as(
    select
    D_ID,
    CURRENCY,
    CHARGE_VALUE


FROM raw_charges
)	
SELECT * FROM charges_staging

		