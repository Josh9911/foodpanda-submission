{{
    config(
        materialized='table'
    )
}}

{
SELECT vendor_name, count(customer_id) as customer_count, sum(gmv_local) as total_gmv, 
FROM `winged-bliss-367614.Orders.Orders`
LEFT JOIN `winged-bliss-367614.Vendors.Vendors` 
ON `winged-bliss-367614.Orders.Orders`.vendor_id = `winged-bliss-367614.Vendors.Vendors`.id
WHERE `winged-bliss-367614.Orders.Orders`.country_name = 'Taiwan'
GROUP BY vendor_name
ORDER BY count(customer_id) DESC
}



