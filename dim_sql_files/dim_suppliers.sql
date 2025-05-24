{{ config(materialized='table') }}

select distinct
    supplier_id::varchar,
    company_name::varchar,
    street::varchar,
    city::varchar,
    postal_code::varchar,
    state::varchar,
    country::varchar
from {{ ref('stg_suppliers') }}
