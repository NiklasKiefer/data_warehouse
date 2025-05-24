{{ config(materialized='view') }}

with source as (
    select * from {{ source('raw', 'suppliers') }}
),
renamed as (
    select
        supplier_id::varchar,
        company_name::varchar,
        street::varchar,
        city::varchar,
        postal_code::varchar,
        state::varchar,
        country::varchar
    from source
)
select * from renamed