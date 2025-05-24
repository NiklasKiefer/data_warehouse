{{ config(materialized='view') }}

with source as (
    select * from {{ source('raw', 'inventory') }}
),
renamed as (
    select
        inventory_movement_id::varchar,
        product_id::varchar,
        supplier_id::varchar,
        location_id::varchar,
        event_type::varchar,
        movement_datetime::timestamp,
        quantity::int,
        unit_price::numeric
    from source
)
select * from renamed