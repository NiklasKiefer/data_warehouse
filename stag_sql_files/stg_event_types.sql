{{ config(materialized='view') }}

with source as (
    select * from {{ source('raw', 'event_types') }}
),
renamed as (
    select
        event_type_name::varchar,
        description::varchar
    from source
)
select * from renamed