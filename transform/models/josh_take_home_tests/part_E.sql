{{
    config(
        materialized='table'
    )
}}


SELECT vendor_name, customer_count
FROM {{ref('q2')}}
