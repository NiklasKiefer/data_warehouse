{{ config(materialized='view') }}

with source as (
    select * from {{ source('raw', 'customers') }}
),
renamed as (
    select
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
    from source
)
select * from renamed