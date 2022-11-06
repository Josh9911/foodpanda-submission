{{
    config(
        materialized='table'
    )
}}

{
    SELECT country_name,
    SUM (gmv_local) as total_gmv
    FROM `orders` 
    GROUP BY country_name

}