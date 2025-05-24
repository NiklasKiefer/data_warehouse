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


# Creation the multidimensional models

## Connect the database to pgAdmin

Info: This part is only for visualization.

> Click on "Add New Server"
> Enter a Name for the server
> Go to the tab "Connection" and add your local IP-adress
> Add the username and password (dbt/dbt)
> Click Save

## Create tables and load the data

1) Put the data (csv), which you want to load into your db into the following path:

> dbt/sales_project/seeds

2) Go into the dbt container (docker exec -it dw_dbt bash) and use the following command:

> dbt seed

After completion the terminal should show this report:

>19:22:19  Finished running 7 seeds in 0 hours 0 minutes and 0.64 seconds (0.64s).
>19:22:19  
>19:22:19  Completed successfully

## Put the SQL-files into their destinated locations

1) Execute the python-script "automated_copy_to_models.py" to copy the necessary SQL-Queries into their respectiv folders.

All files are copied into the folder dbt/modesl/*

## Execute all SQL-Queries

1) Run the following command to execute all queries simultaneously.

> dbt run

After completion the terminal should show this report:

>19:08:21  Finished running 8 table models, 7 view models in 0 hours 0 minutes and 1.27 seconds (1.27s).
>19:08:21
>19:08:21  Completed successfully

## End


# Power BI Desktop

Working!


### TODO
> Create dimensinal model as sketch
> create data marts
> Integrate raw data source into postgres
> Create staging models for raw data
> Build dimensional model using db run
> Visualize using Power Bi