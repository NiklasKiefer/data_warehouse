# Project overview
This project demonstrates how to create and work with a simple data warehouse.

# Initial setup
Using cmd, move into project folder and execute:
> docker compose up -d

This starts the docker compose process, initiating all containers

# Postgres SQL
Access via PgAdmin @ [localhost:8080](http://localhost:8080/).
The following credentials need to be used to login:

- Username: **admin@pgadmin.com**
- Password: **admin**

# dbt
This is a tool for transforming raw data into clean tables for the PostresSQL database. It represents the ETL process.

The dbt container can be entered by typing in the following command:
> docker exec -it dw_dbt bash

# Power Bi
This software is a powerful visualization tool and it needs to be installed either by Microsoft Store or download directly [here](https://www.microsoft.com/de-de/download/details.aspx?id=58494).
Connect to postres database using the following credentials:

- Host: **localhost**
- Port: **5432**
- User: **dbt**
- Password **dbt**


# Creating a new project
So far, a postressql database was created (currently without any data in it), dbt was set up and Powe Bi was installed.
Now start by creating a project for the warehouse. First, go inside the dbt container using this command
> docker exec -it dw_dbt bash

If not already in */usr/app*, move into this folder and type the following command to intiate the project
> dbt init sales_project

When asked, enter the following information:
- Database: **postgres**
- Host: **postgres**
- Port: **5432**
- User: **dbt**
- Password: **dbt**
- DBname: **sales_dw**
- Schema: **public**
- Threads: **1**

After this is done, the project should be successfully created. In order to verify this, navigate into the sales_project folder like this:
> cd /usr/app/sales_project

Then, test if the seutp was successful by typing in the following command:
> dbt debug

This should result in the following message:

> **All checks passed!**

### TODO
> Create dimensinal model as sketch
> create data marts
> Integrate raw data source into postgres
> Create staging models for raw data
> Build dimensional model using db run
> Visualize using Power Bi



# Creation the multidimensional models

## Connect the database to pgAdmin

> Click on "Add New Server"
> Enter a Name for the server
> Go to the tab "Connection" and add your local IP-adress
> Add the username and password (dbt/dbt)
> Click Save

## dbt: Create the tables:

See notes in the file **md_model_creation.md**

## dbt: Laden der Rohdaten:

See notes in the file **md_model_creation.md**

## dbt: Staging-Modelle erstellen

See notes in the file **md_model_creation.md**