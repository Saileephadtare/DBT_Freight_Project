with raw_ports as
(

select * from 

 {{ source('xn_raw', 'ports') }}	

),
ports_staging as(
    select distinct 
    PID,
    CODE,
    SLUG,
    NAME,
    COUNTRY,
    COUNTRY_CODE
    FROM raw_ports
)	
SELECT * FROM ports_staging
		