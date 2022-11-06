{{
    config(
        materialized='table'
    )
}}

{
    SELECT country_name,
    SUM (gmv_local) as total_gmv
    FROM `bigquery/tables/datawarehouse/orders.csv` 
    GROUP BY country_name

}