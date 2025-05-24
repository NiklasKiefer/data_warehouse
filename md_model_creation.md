# Multidimensional Model Erstellung

## Erstellung der Tables

-- Dimension Tables

CREATE TABLE dim_datetime (
    datetime_id BIGINT PRIMARY KEY, -- Unix timestamp
    date DATE,
    time TIME,
    day INT,
    day_of_week VARCHAR(15),
    weekend BOOLEAN,
    week INT,
    iso_week INT,
    weekday_num_iso INT,
    week_start_date DATE,
    month INT,
    month_name VARCHAR(20),
    quarter INT,
    year INT,
    fiscal_year INT,
    fiscal_quarter VARCHAR(5)
);

CREATE TABLE dim_products (
    product_id SERIAL PRIMARY KEY,
    product_code VARCHAR(50) NOT NULL,
    name VARCHAR(100),
    manufacturer VARCHAR(100),
    category VARCHAR(50),
    product_type VARCHAR(50),
    valid_from DATE,
    valid_to DATE,
    is_current BOOLEAN
);

CREATE TABLE dim_customers (
    customer_id SERIAL PRIMARY KEY,
    customer_code VARCHAR(50) NOT NULL,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    birthdate DATE,
    email VARCHAR(100),
    phonenumber VARCHAR(20),
    street VARCHAR(100),
    city VARCHAR(50),
    postal_code VARCHAR(20),
    state VARCHAR(50),
    country VARCHAR(50),
    valid_from DATE,
    valid_to DATE,
    is_current BOOLEAN
);

CREATE TABLE dim_location (
    location_id SERIAL PRIMARY KEY,
    location_code VARCHAR(50) NOT NULL,
    location_name VARCHAR(100),
    street VARCHAR(100),
    city VARCHAR(50),
    postal_code VARCHAR(20),
    state VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE dim_suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_code VARCHAR(50) NOT NULL,
    company_name VARCHAR(100),
    street VARCHAR(100),
    city VARCHAR(50),
    postal_code VARCHAR(20),
    state VARCHAR(50),
    country VARCHAR(50),
    valid_from DATE,
    valid_to DATE,
    is_current BOOLEAN
);

CREATE TABLE dim_inventory_event_type (
    inventory_event_type_id SERIAL PRIMARY KEY,
    event_type_name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Fact Tables

CREATE TABLE fact_orders (
    order_id VARCHAR(50), -- Business key
    order_line_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES dim_customers(customer_id),
    product_id INT REFERENCES dim_products(product_id),
    datetime_id BIGINT REFERENCES dim_datetime(datetime_id),
    location_id INT REFERENCES dim_location(location_id),
    quantity INT,
    unit_price NUMERIC(10,2),
    total_price NUMERIC(12,2)
);

CREATE TABLE fact_inventory (
    inventory_movement_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES dim_products(product_id),
    supplier_id INT REFERENCES dim_suppliers(supplier_id),
    inventory_event_type_id INT REFERENCES dim_inventory_event_type(inventory_event_type_id),
    datetime_id BIGINT REFERENCES dim_datetime(datetime_id),
    location_id INT REFERENCES dim_location(location_id),
    quantity INT,
    unit_price NUMERIC(10,2),
    total_price NUMERIC(12,2)
);

-- Staging Tables (for ETL)

CREATE TABLE stg_orders (
    order_id VARCHAR(50),
    order_line_id INT,
    customer_code VARCHAR(50),
    product_code VARCHAR(50),
    datetime TIMESTAMP,
    location_code VARCHAR(50),
    quantity INT,
    unit_price NUMERIC(10,2)
);

CREATE TABLE stg_inventory (
    inventory_movement_id INT,
    product_code VARCHAR(50),
    supplier_code VARCHAR(50),
    event_type_name VARCHAR(50),
    datetime TIMESTAMP,
    location_code VARCHAR(50),
    quantity INT,
    unit_price NUMERIC(10,2)
);

CREATE TABLE stg_products (
    product_code VARCHAR(50),
    name VARCHAR(100),
    manufacturer VARCHAR(100),
    category VARCHAR(50),
    product_type VARCHAR(50),
    valid_from DATE
);

CREATE TABLE stg_customers (
    customer_code VARCHAR(50),
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    birthdate DATE,
    email VARCHAR(100),
    phonenumber VARCHAR(20),
    street VARCHAR(100),
    city VARCHAR(50),
    postal_code VARCHAR(20),
    state VARCHAR(50),
    country VARCHAR(50),
    valid_from DATE
);

CREATE TABLE stg_locations (
    location_code VARCHAR(50),
    location_name VARCHAR(100),
    street VARCHAR(100),
    city VARCHAR(50),
    postal_code VARCHAR(20),
    state VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE stg_suppliers (
    supplier_code VARCHAR(50),
    company_name VARCHAR(100),
    street VARCHAR(100),
    city VARCHAR(50),
    postal_code VARCHAR(20),
    state VARCHAR(50),
    country VARCHAR(50),
    valid_from DATE
);

CREATE TABLE stg_inventory_event_types (
    event_type_name VARCHAR(50),
    description TEXT
);


# Testdaten einlesen

INSERT INTO dim_datetime (
    datetime_id, date, time, day, day_of_week, weekend, week,
    iso_week, weekday_num_iso, week_start_date, month,
    month_name, quarter, year, fiscal_year, fiscal_quarter
) VALUES
(202405201000, '2025-05-20', '10:00:00', 20, 'Tuesday', false, 21, 21, 2, '2025-05-19', 5, 'May', 2, 2025, 2025, 'Q2'),
(202405211200, '2025-05-21', '12:00:00', 21, 'Wednesday', false, 21, 21, 3, '2025-05-19', 5, 'May', 2, 2025, 2025, 'Q2');

INSERT INTO dim_products (
    product_id, product_code, name, manufacturer, category,
    product_type, valid_from, valid_to, is_current
) VALUES
(1, 'P001', 'Widget A', 'Acme Corp', 'Gadgets', 'Standard', '2024-01-01', NULL, true),
(2, 'P002', 'Gizmo B', 'Globex Inc', 'Tools', 'Deluxe', '2024-01-01', NULL, true);

INSERT INTO dim_customers (
    customer_id, customer_code, firstname, lastname, birthdate,
    email, phonenumber, street, city, postal_code, state, country,
    valid_from, valid_to, is_current
) VALUES
(1, 'C001', 'Alice', 'Miller', '1985-06-15', 'alice@example.com', '123456789', 'Main St 1', 'Berlin', '10115', 'Berlin', 'Germany', '2023-01-01', NULL, true),
(2, 'C002', 'Bob', 'Smith', '1990-04-20', 'bob@example.com', '987654321', '2nd St 3', 'Hamburg', '20095', 'Hamburg', 'Germany', '2023-01-01', NULL, true);

INSERT INTO dim_location (
    location_id, location_code, location_name, street, city, postal_code, state, country
) VALUES
(1, 'L001', 'Warehouse North', 'Nordweg 12', 'Hamburg', '20095', 'Hamburg', 'Germany'),
(2, 'L002', 'Store East', 'Oststraße 45', 'Berlin', '10115', 'Berlin', 'Germany');

INSERT INTO dim_suppliers (
    supplier_id, supplier_code, company_name, street, city, postal_code,
    state, country, valid_from, valid_to, is_current
) VALUES
(1, 'S001', 'SupplyCo GmbH', 'Industriestr. 9', 'Munich', '80331', 'Bavaria', 'Germany', '2023-01-01', NULL, true),
(2, 'S002', 'MegaParts AG', 'Techpark 5', 'Stuttgart', '70173', 'Baden-Württemberg', 'Germany', '2023-01-01', NULL, true);

INSERT INTO dim_inventory_event_type (
    inventory_event_type_id, event_type_name, description
) VALUES
(1, 'restock', 'New stock from supplier'),
(2, 'customer_return', 'Returned by customer'),
(3, 'write_off', 'Damaged goods removed');

INSERT INTO fact_orders (
    order_id, order_line_id, customer_id, product_id, datetime_id,
    location_id, quantity, unit_price, total_price
) VALUES
('O001', 1, 1, 1, 202405201000, 2, 2, 10.00, 20.00),
('O002', 2, 2, 2, 202405211200, 2, 1, 15.00, 15.00);

INSERT INTO fact_inventory (
    inventory_movement_id, product_id, supplier_id, inventory_event_type_id,
    datetime_id, location_id, quantity, unit_price, total_price
) VALUES
(1, 1, 1, 1, 202405201000, 1, 100, 8.00, 800.00),
(2, 2, 2, 3, 202405211200, 1, -5, 15.00, -75.00);

