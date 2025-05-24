{{ config(materialized='table') }}

select
    o.order_id,
    o.order_line_id,
    o.customer_id,
    o.product_id,
    o.location_id,
    o.order_datetime,
    o.quantity,
    o.unit_price
from {{ ref('stg_orders') }} o
