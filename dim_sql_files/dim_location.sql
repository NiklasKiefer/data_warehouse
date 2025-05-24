{{ config(materialized='table') }}

select distinct
    location_id::varchar,
    location_name::varchar,
    street::varchar,
    city::varchar,
    postal_code::varchar,
    state::varchar,
    country::varchar
from {{ ref('stg_locations') }}