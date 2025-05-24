{{ config(materialized='view') }}

with source as (
    select * from {{ source('raw', 'locations') }}
),
renamed as (
    select
        location_id::varchar,
        location_name::varchar,
        street::varchar,
        city::varchar,
        postal_code::varchar,
        state::varchar,
        country::varchar
    from source
)
select * from renamed