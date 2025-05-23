# Multidimensional schema
This file contains the database schema for the sales data warehouse. It consists of two fact tables for order management and inventory management.


## Model definition

> Fact tables

- fact_orders (fact per order line)
- fact_inventory (fact per inventory movement event)


> Dimension tables

** shared dimensions **
- dim_datetime (values should be generated)
- dim_products (slowly changing dimension type 2)
- dim_locations


** orders dimensions **
- dim_customers (slowly changing dimension type 2)

** inventory dimensions **
- dim_inventory_event_type
- dim_suppliers (slowly changing dimension type 2)


> Staging tables (important for etl process)
- stg_orders
- stg_inventory

- stg_products
- stg_locations
- stg_customers
- stg_inventory_event_types
- stg_suppliers


# Planned folder structure

/models
    /staging    
        /orders
            /stg_orders.sql
        /inventory
            /stg_inventory.sql
        /shared_dimensions
            /stg_products.sql
            /stg_locations.sql
            /stg_customers.sql
            /stg_inventory_event_types.sql
            /stg_suppliers.sql
    /marts
        /facts
            /fact_orders.sql
            /fact_inventory.sql
        /dimensions
            /dim_products.sql
            /dim_location.sql
            /dim_customers.sql
            /dim_suppliers.sql
            /dim_inventory_event_type.sql
            /dim_datetime.sql

# Table column definitions
