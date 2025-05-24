{{ config(materialized='table') }}

select distinct
    customer_id,
    firstname,
    lastname,
    birthdate,
    email,
    phonenumber,
    street,
    city,
    postal_code,
    state,
    country
from {{ ref('stg_customers') }}
