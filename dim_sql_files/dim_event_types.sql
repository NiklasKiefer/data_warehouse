{{ config(materialized='table') }}

select distinct
    event_type_name::varchar,
    description::varchar
from {{ ref('stg_event_types') }}
