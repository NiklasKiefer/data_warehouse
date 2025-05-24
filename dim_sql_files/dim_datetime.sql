{{ config(materialized='table') }}

with dates as (
    select
        date_trunc('day', d)::date as date_day
    from generate_series('2020-01-01'::date, '2030-12-31'::date, interval '1 day') d
)
select
    date_day,
    extract(year from date_day)::int as year,
    extract(month from date_day)::int as month,
    extract(day from date_day)::int as day,
    to_char(date_day, 'YYYY-MM') as year_month,
    to_char(date_day, 'YYYY-MM-DD') as full_date
from dates
