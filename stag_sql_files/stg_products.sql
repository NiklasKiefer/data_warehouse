{{ config(materialized='view') }}

with source as (
    select * from {{ source('raw', 'products') }}
),

renamed as (
    select
        product_id,
        product_name,
        manufacturer,
        category,
        product_type
    from source
)

select * from renamed
