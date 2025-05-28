# Setup Guide
This file contains all steps necessary to perform the setup for the sales_dw data warehouse project

## Prerequisites
The following installments are required for the setup:

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [Power BI](https://powerbi.microsoft.com/)

## Folder structure
The project contains the following structure:
````
data_warehouse
    │   docker-compose.yml                          # initial docker setup for data warehouse project
    │   drop_tables.sql                             # script for dropping all tables
    │   source.yml                                  # raw table setup for dbt
    │   Visualization_Salesdw_PowerBI.pbix          # power bi dashboard visualization
    │
    ├───documentation                               # project documentation files
    │       multidimensional_schema.md
    │       setup_guide.md
    │       visualization_of_usecase.md
    │
    ├───import_data                                 # raw input csv files 
            customers.csv
            event_types.csv                         
            inventory.csv
            locations.csv
            orders.csv
            products.csv
            suppliers.csv
````

## Technology stack
For this project, the following technology stack was used:

- [PostgreSQL](https://www.postgresql.org/) – A popular open-source relational database
- [pgAdmin](https://www.pgadmin.org/) – A web-based administration tool for managing PostgreSQL databases.
- [dbt](https://www.getdbt.com/) – SQL-based data transformation and modeling tool.
- [Power BI](https://powerbi.microsoft.com/) – Visualization tool for building interactive dashboards.

## Initial setup
Initiate the project environment using the provided `docker-compose.yml` file:

````docker compose up -d````

This command initializes and starts all required containers.

At the end, you should see the following:

````
[+] Running 4/4
 ✔ Network data_warehouse_default  Created
 ✔ Container dw_postgres           Started
 ✔ Container dw_dbt                Started
 ✔ Container dw_pgadmin            Started
 ````

## Verify if PostgreSQL database exists
After starting the containers, you can verify that the database is by accessing it via PgAdmin @ [localhost:8080](http://localhost:8080/).
Use the following credentials to login:

- Username: **admin@pgadmin.com**
- Password: **admin**

The PostgreSQL container automatically creates a database named `sales_dw` on startup. You can verify its existence by clicking `Add New Server`. Enter the following:

- **Name:** `PostgreSQL` (or any name you like)
- Go to the **Connection** tab and enter:
    - **Host name/address:** `postgres`
    - **Port:** `5432`
    - **Username:** `dbt`
    - **Password:** `dbt`

Now you should be able to find the empty `sales_dw` database in the Object Explorer tab.

## Creating a new dbt project
A `dbt` project has to be created for to manage the tables of this database. Enter the dbt container using the following command:

````docker exec -it dw_dbt bash````

If not already in */usr/app*, move into this folder and type the following command to intiate the project:

````dbt init sales_project````

When asked, enter the following information:
- Database: **[1] postgres**
- Host: **postgres**
- Port: **5432**
- User: **dbt**
- Password: **dbt**
- DBname: **sales_dw**
- Schema: **public**
- Threads: **1**

After this is done, the project should be successfully created. In order to verify this, navigate into the sales_project folder like this:

````cd /usr/app/sales_project````

Then, test if the seutp was successful by typing in the following command:

````dbt debug````

This should result in the following message:

````**All checks passed!**````

This confirms the dbt project was created successfully, which concludes the setup necessary for the presentation.