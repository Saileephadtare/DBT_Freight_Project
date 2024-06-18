with raw_datapoints as
(

select * from 

 {{ source('xn_raw', 'XS_DATAPOINTS_1') }}	

),
datapoints_staging as(
    select
    D_ID,
    DATE(CREATED) AS CREATED,
	ORIGIN_PID,
	DESTINATION_PID,
	VALID_FROM,
	VALID_TO,
	COMPANY_ID,
	SUPPLIER_ID,
	EQUIPMENT_ID
    FROM raw_datapoints

    
)	
SELECT * FROM datapoints_staging
		