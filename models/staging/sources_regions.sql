with raw_regions as
(

select * from 

 {{ source('xn_raw', 'regions') }}	

),
regions_staging as(
    -- select distinct 
    select
    SLUG,
    NAME,
    PARENT

    FROM raw_regions
)	
SELECT * FROM regions_staging
		