{{
    config(
        materialized='table'
    )
}}

{
WITH added_row_number AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY date_local ,country_name ORDER BY total_gmv DESC) AS row_number
  FROM (
    SELECT DISTINCT `orders`.country_name, `vendors`.vendor_name, sum(gmv_local) as total_gmv, date_local 
  FROM `orders`
  LEFT JOIN `vendors` 
  ON `orders`.vendor_id = `vendors`.id
  GROUP BY date_local,country_name, vendor_name
  
  )
)
SELECT DATETIME_TRUNC(date_local,YEAR),added_row_number.country_name, added_row_number.vendor_name, added_row_number.total_gmv
FROM added_row_number
where row_number <= 2
ORDER BY date_local, country_name
}