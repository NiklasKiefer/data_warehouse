{{ config(materialized='view') }}

with source as (
    select * from {{ source('raw', 'orders') }}
),
renamed as (
    select
        order_id::varchar,
        order_line_id::varchar,
        customer_id::varchar,
        product_id::varchar,
        location_id::varchar,
        order_datetime::timestamp,
        quantity::int,
        unit_price::numeric
    from source
)
select * from renamed