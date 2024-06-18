Snowflake-dbt project!

### Prerequisite 
-Snowflake Trial Account
-DBT installation 
  -pip install dbt[check snowflake plugin is supported or not]

### Credential
-Snowflake Account Details
  - Add credential to Profile.yml file
    Accountname
    Password
    Warehouse
    Schema
    Database
    Role [Default role is ACCOUNTADMIN]
    Test connection
### Snowflake Tables
    -use role accountadmin;[use role of your choice]
    -create or replace warehouse warehouse_name;
    -create or replace database database_name;
    -create or replace schema raw_schema;
    -load data manually and create table in the raw_schema
### DBT Packages
    -Install packages with the packages.yml 
    -run dbt deps
### DBT Models
   - create dbt staging models in models folder[staging]
   - create yml file for defining source and testing
   - create dbt transfrmation model in models folder[marts]  
   - Testing before creating model- dbt test
   - Creating model in snowflake environment - dbt run or dbt run --select single_model
### DBT Macro   
   - macro for custom schema
### EDA
   - Data analysis to explore solution