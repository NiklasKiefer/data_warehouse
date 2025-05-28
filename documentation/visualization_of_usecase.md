## Use case: Annual financial statement analysis for the 2024 financial year

At the end of the year, the management of your IT sales company would like to carry out a comprehensive analysis of the turnover from the previous financial year 2024. 
The aim is to use this analysis to gain sound insights for strategic planning for the 2025 financial year. 

Create an interactive Power BI report and analyze which products, customer regions and business locations had the greatest impact on sales in 2024. Also examine how these sales drivers have developed over time. 

Use interactive visualizations to analyze the following questions based on data: 
- What is the total annual turnover in 2024? 
- How has turnover developed over the course of 2024? 
- Which products and states were particularly strong in terms of sales? 
- Which business locations generated the largest share of total sales?

---

## Instructions: Creating a Power BI report for the 2024 annual financial statement analysis

### 1. prerequisites

* Install **Power BI Desktop**
* Start your **Docker container** with the database

### 2. establish data connection

1. open **Power BI Desktop**
2. select **Retrieve from other source**
3. go to **Database → PostgreSQL database → Connect**
4. enter the following connection data:
* **Server**: `localhost:5432`
**Database**: `sales_dw`
* **User name**: `dbt`
* **Password**: `dbt`
5. Select the following tables in the **Navigator**:
* All `public.dim...` tables
* The two `public.fact...` tables
6. Click on **Load**

### 3. first steps in Power BI

**Table view** (left, 2nd icon): Overview of the structure and content of the tables
**Model view** (left, 3rd icon): Representation of the relationships between the tables
**Report view** (left, 1st symbol): This is where we create our visualizations

### 4. complete the data model

- We create the measure `sales` in the table `public fact_orders`: 
``Sales = SUMX('public fact_orders', 'public fact_orders'[quantity] * 'public fact_orders'[unit_price])``
We click on the table mentioned under Table view and select New measure under Calculations at the top.
- Then we can start with the visualizations.

### 5. create visualizations

#### 1. Selection of business month
- **Visualization:** Data section
- Field:** `dim_datetime[year_month]`

#### 2. Selection product type
- **Visualization:** Data section
- **Field:** `dim_products[product_type]`

#### 3. Sales development in the 2024 financial year
- **Visualization:** Line chart
- **X-axis:** `dim_datetime[month]`
- **Y-axis:** Turnover

#### 4. Top-selling products
- **Visualization:** KPI
- **Value:** Turnover
- **Trend axis:** `dim_datetime[year]`

#### 5. Annual turnover 2024
- **Visualization:** Stacked bar chart
- **Y-axis:** `dim_products.product_name`
- **X-axis:** Turnover

#### 6. Customer regions with the highest turnover
- **Visualization:** Stacked bar chart
- **X-axis:** `dim_customers[state]`
- **Y-axis:** Turnover

#### 7. Turnover in 2024 per business location
- **Visualization:** Ring chart
- Legend:** `dim_location[location_name]`
- **Values:** Turnover
