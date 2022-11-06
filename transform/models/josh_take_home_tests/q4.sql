{{
    config(
        materialized='table'
    )
}}

{
WITH added_row_number AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY date_local ,country_name ORDER BY total_gmv DESC) AS row_number
  FROM (
    SELECT DISTINCT `winged-bliss-367614.Orders.Orders`.country_name, `winged-bliss-367614.Vendors.Vendors`.vendor_name, sum(gmv_local) as total_gmv, date_local 
  FROM `winged-bliss-367614.Orders.Orders`
  LEFT JOIN `winged-bliss-367614.Vendors.Vendors` 
  ON `winged-bliss-367614.Orders.Orders`.vendor_id = `winged-bliss-367614.Vendors.Vendors`.id
  GROUP BY date_local,country_name, vendor_name
  
  )
)
SELECT date_local,added_row_number.country_name, added_row_number.vendor_name, added_row_number.total_gmv
FROM added_row_number
where row_number <= 2
ORDER BY date_local, country_name
}