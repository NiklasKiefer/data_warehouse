# Multidimensional schema
This file contains the database schema for the sales data warehouse. It consists of two fact tables for order management and inventory management.
Here follows a short description of the different chapters of this file:
- **Model definition**: Initial definition of the tables the warehouse will contain
- **Planned folder structure**: Folder structure of the data warehouse, containing all tables that the warehouse will consist of
- **Table column definitoins**: Initial definition of each table of the warehouse. does not contain datatypes, they will be chosen during implementation

*Additional Notes*
- maybe implement Junk dimension if there is enough time to do so



## Model definition

> Fact tables

- fact_orders (fact per order line)
- fact_inventory (fact per inventory movement event)


> Dimension tables

**shared dimensions**
- dim_datetime (values should be generated)
- dim_products (slowly changing dimension type 2)
- dim_locations


**orders dimensions**
- dim_customers (slowly changing dimension type 2)

**inventory dimensions**
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
        /shared
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
NOTES:
SK = Surrogate Key
BK = Business key
SCD 2 = Slowly changing columns level 2

- **fact tables**

fact_orders (
    order_id BK
    order_line_id PK
    customer_id SK
    product_id SK
    datetime_id SK
    location_id SK
    quantity
    unit_price (wird hier benötigt, da preis sich über zeit ändern kann)
    total_price
)

fact_inventory (
    inventory_movement_id PK
    product_id SK
    supplier_id SK
    inventory_event_type_id SK
    datetime_id SK
    location_id SK
    quantity
    unit_price
    total_price
)

- **dimension tables**

dim_products (
    product_id PK(SK)
    product_code (BK)
    name
    manufacturer
    category
    product_type
    valid_from         (Used for SCD 2)
    valid_to           (Used for SCD 2)
    is_current         (Used for SCD 2)
)

dim_customers (
    customer_id PK(SK)
    customer_code (BK)
    firstname
    lastname
    birthdate
    email
    phonenumber
    street
    city
    postal_code
    state
    country
    valid_from         (Used for SCD 2)
    valid_to           (Used for SCD 2)
    is_current         (Used for SCD 2)
)

dim_location (
    location_id PK(SK)
    location_code (BK)
    location_name
    street
    city
    postal_code
    state
    country
)

dim_suppliers (
    supplier_id PK(SK)
    supplier_code (BK)
    company_name
    street
    city
    postal_code
    state
    country
    valid_from         (Used for SCD 2)
    valid_to           (Used for SCD 2)
    is_current         (Used for SCD 2)
)

dim_inventory_event_type (
    inventory_event_type_id PK(SK)
    event_type_name (better as enum value, planned types: restock, return_to_supplier, customer_return, internal_transfer, write_off)
    description (optional)
)


dim_datetime (
    datetime_id PK(SK)   -- integer in linux format
    date
    time
    day
    day_of_week
    weekend
    week
    iso_week                -- iso standard for week, debatable if wanted
    weekday_num_iso         -- iso standard for weekday, debatable if wanted
    week_start_date
    month
    month_name
    quarter
    year
    fiscal_year
    fiscal_quarter
)
