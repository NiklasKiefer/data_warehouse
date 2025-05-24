{{ config(materialized='table') }}

select
    i.inventory_movement_id,
    i.product_id,
    i.supplier_id,
    i.location_id,
    i.event_type,
    i.movement_datetime,
    i.quantity,
    i.unit_price
from {{ ref('stg_inventory') }} i