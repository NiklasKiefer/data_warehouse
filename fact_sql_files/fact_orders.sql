{{ config(materialized='table') }}

select
    o.order_id,
    o.order_line_id,
    o.customer_id,
    o.product_id,
    o.location_id,
    dt.datetime_id,
    o.quantity,
    o.unit_price
from {{ ref('stg_orders') }} o
join {{ ref('dim_datetime') }} dt
    on cast(o.order_datetime as date) = dt.date_day