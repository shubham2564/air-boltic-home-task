# Air Boltic – Analytics Data Model

## Overview
This repository contains a proposed analytics data model for Air Boltic, a marketplace for shared aeroplane rides.

The goal of the model is to support monitoring, experimentation, and self-service analysis across regions, customer segments, routes, and aircraft types, while remaining scalable as the business grows.

The implementation assumes Bolt’s analytics stack:
- S3 for storage
- Databricks for compute
- dbt for transformations
- Looker for reporting

For the home task, a representative subset of the model is implemented using dbt.

---

## Data Model Design

The model follows a star-schema approach with clearly defined fact and dimension tables.

### Fact tables
- fct_orders  
  One row per seat purchase.  
  This is the primary table for revenue, active users, and demand analysis.

- fct_trips (described in DDL)  
  One row per flight.  
  Enables analysis of routes, aircraft utilization, and trip characteristics.

### Dimension tables
- dim_customer  
  Customer information enriched with customer group attributes such as company, private group, or organisation.

- dim_customer_group  
  Describes customer group metadata and enables segmentation.

- dim_aeroplane and dim_aeroplane_model  
  Aircraft attributes including manufacturer, model, seat capacity, range, and engine type.

- dim_city and dim_route  
  Geography and route modeling to support origin-destination and regional analysis.

- dim_date  
  Standard date dimension to support DAU, WAU, MAU, and time-based aggregations.

This structure allows analysts to answer questions such as:
- Which customer segments drive the most revenue?
- How does demand differ by route length or aircraft size?
- Which regions are growing or underperforming?
- How do premium versus low-cost trips behave over time?

---

## Implemented dbt Models

The dbt project implements a focused subset of the full model:
- Staging models (stg_*) to clean and standardize raw inputs
- Marts:
  - dim_customer
  - dim_aeroplane
  - fct_orders

Basic data quality checks are included:
- not null and unique constraints on primary keys
- referential integrity between facts and dimensions
- accepted values for order status

---

## Design Decisions and Tradeoffs
- A star schema was chosen to optimize self-service analytics and Looker consumption.
- Selected attributes such as customer group type and route context are denormalized to reduce query complexity for analysts.
- Only a subset of the full model is implemented to keep the scope focused while still demonstrating modeling and dbt best practices.

---

## What I Would Do With More Time
- Add incremental models and snapshots for slowly changing dimensions.
- Introduce pre-aggregated daily KPI tables for improved dashboard performance.
- Add data freshness, volume, and anomaly detection tests.
- Enrich city data with external geographic attributes such as country, timezone, and distance calculations.
- Build Looker explores and governed metrics on top of the marts layer.

---

## How to Run Locally
'''bash
dbt seed
dbt run
dbt test

