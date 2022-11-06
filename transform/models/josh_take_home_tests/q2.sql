{{
    config(
        materialized='table'
    )
}}

{
SELECT vendor_name, count(customer_id) as customer_count, sum(gmv_local) as total_gmv, 
FROM `orders`
LEFT JOIN `vendors`
ON `orders` .vendor_id = `vendors`.id
WHERE `orders`.country_name = 'Taiwan'
GROUP BY vendor_name
ORDER BY count(customer_id) DESC
}



