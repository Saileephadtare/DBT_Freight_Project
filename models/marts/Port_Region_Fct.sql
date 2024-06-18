

-- join datapoints table with port table to get source country,slug and destination country and slug based on ID from datapoints
WITH SRC_DEST_COUNTRY AS(
SELECT
DPT.ORIGIN_PID,
DPT.DESTINATION_PID,
MAX(CASE WHEN DPT.ORIGIN_PID=SPORT.PID THEN SPORT.COUNTRY END) AS SOURCE_COUNTRY,
MAX(CASE WHEN DPT.ORIGIN_PID=SPORT.PID THEN SPORT.SLUG END) AS SOURCE_SLUG,
MAX(CASE WHEN DPT.DESTINATION_PID=SPORT.PID THEN SPORT.COUNTRY END) AS DESTINATION_COUNTRY,
MAX(CASE WHEN DPT.DESTINATION_PID=SPORT.PID THEN SPORT.SLUG END) AS DESTINATION_SLUG
FROM {{ref("sources_datapoints")}} AS DPT
JOIN
{{ref("sources_ports")}} AS SPORT
ON SPORT.PID=DPT.ORIGIN_PID OR SPORT.PID=DPT.DESTINATION_PID
GROUP BY 1,2),

-- joined above cte with region table to get slug name for source and destination based on slug from cte
slug_name as(
SELECT sdt.*,
max(CASE WHEN sdt.source_slug=srg.slug THEN srg.name END) AS source_name,
max(CASE WHEN sdt.destination_slug=srg.slug THEN srg.name END) AS destination_name
FROM SRC_DEST_COUNTRY as sdt
join
{{ref("sources_regions")}} as srg
on sdt.source_slug=srg.slug
or sdt.destination_slug=srg.slug
group by 1,2,3,4,5,6)
select ORIGIN_PID,SOURCE_COUNTRY,SOURCE_SLUG,SOURCE_NAME,
DESTINATION_PID,DESTINATION_COUNTRY,DESTINATION_SLUG,DESTINATION_NAME
FROM
SLUG_NAME