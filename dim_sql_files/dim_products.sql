{{ config(materialized='table') }}

select
    product_id,
    product_name,
    manufacturer,
    category
    product_type
from {{ ref('stg_products') }}


