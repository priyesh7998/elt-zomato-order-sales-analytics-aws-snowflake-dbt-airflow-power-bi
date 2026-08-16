# elt-zomato-order-sales-analytics-aws-snowflake-dbt-airflow-power-bi

> End-to-end ELT pipeline for Zomato order and sales analytics, from cloud storage and transformation to automated orchestration and Power BI reporting.

## Table of Contents

- [Overview](#overview)
- [Problem Statement](#problem-statement)
- [Dataset](#dataset)
- [Tools & Technologies](#tools--technologies)
- [Method](#method)
- [Key Insights](#key-insights)
- [Dashboard](#dashboard)
- [How to Run](#how-to-run)
- [Result & Conclusion](#result--conclusion)
- [Future Work](#future-work)
- [Author & Contact](#author--contact)

## Overview

This project builds a complete **ELT data pipeline** for Zomato order and sales data. Raw data is stored in **Amazon S3**, loaded into **Snowflake**, transformed using **dbt**, orchestrated with **Apache Airflow**, and consumed in **Power BI** for interactive business analytics.

## Problem Statement

Raw order data is difficult to analyze directly and requires a reliable workflow for ingestion, transformation, orchestration, and reporting. The goal of this project is to create a scalable pipeline that converts raw Zomato data into clean, analytics-ready datasets and actionable sales insights.

## Dataset

The dataset contains seven related Zomato tables:

| Table | Approx. Rows |
|---|---:|
| `orders` | ~10M |
| `order_items` | ~20–25M |
| `restaurants` | ~0.1–0.2M |
| `menus` | ~0.17M |
| `foods` | ~0.3–0.4M |
| `users` | ~1M |
| `reviews` | ~0.3 |

The data is transformed into analytics-ready models following a **staging → marts** approach.

## Tools & Technologies

| Area | Tools |
|---|---|
| Cloud Storage | Amazon S3 |
| Data Warehouse | Snowflake |
| Data Loading | Snowpipe |
| Transformation | dbt |
| Orchestration | Apache Airflow |
| Analytics | Power BI |
| Development | SQL, Python, VS Code, Docker |

## Method

1. **Extract** raw Zomato data and store it in Amazon S3.
2. **Load** the raw data into Snowflake using stages and Snowpipe.
3. **Transform** the raw Snowflake data with dbt. The data is cleaned and modeled through **staging** and **mart** layers.
4. **Store** the cleaned and transformed models back in Snowflake under the **staging** and **mart** schemas.
5. **Test** and organize the transformed data for reliable downstream analysis.
6. **Orchestrate** the pipeline workflows using **Apache Airflow**.
7. **Connect** Power BI to the analytics layer.
8. **Build** an interactive dashboard for sales, orders, delivery, discounts, and city/month analysis.

## Key Insights

- Total orders: **29.44M**
- Delivered orders: **26.94M**
- Total sales: **1.42B**
- Delivered order sales: **1.30B**
- Average delivery time: **31.08**
- Highest monthly sales: **December — 147M**
- Highest city sales contribution: **Bangalore — 172.46M (21.84%)**

> Dashboard values shown above are based on the current project snapshot and may change if the underlying data is refreshed.

## Dashboard

![Zomato Order & Sales Analytics Dashboard](dashboard/zomato_dashboard.png)

The Power BI dashboard provides KPI cards, city-wise sales distribution, monthly sales/order trends, delivery-time analysis, and discount metrics.

## How to Run

### Prerequisites

- WSL
- Ubuntu
- Docker Desktop
- Python
- dbt

### 1. Clone the repository

```bash
git clone https://elt-zomato-order-sales-analytics-aws-snowflake-dbt-airflow-power-bi.git
cd elt-zomato-order-sales-analytics-aws-snowflake-dbt-airflow-power-bi
```

### 2. Set up the pipeline

```bash
cd "zomato_data_pipeline"
```

Configure your **AWS S3**, **Snowflake**, **dbt**, and **Airflow** credentials/settings before running the pipeline.

### 3. Run dbt

```bash
dbt debug
dbt run
dbt test
```

### 4. Start Airflow

```bash
docker-compose build
docker-compose up -d
```

Open the Airflow UI and trigger the required DAG.

### 5. Open the dashboard

Open the `.pbix` file inside:

```text
Zomato Order Sales Analytics/
```

Update the Power BI data source/credentials if required, then refresh the dataset.

> **Note:** Replace `<YOUR_GITHUB_USERNAME>` with your GitHub username. Keep credentials and secrets outside the repository.

## Project Structure

```text
.
├── dashboard/
│   ├── zomato_dashboard.png
│   └── other screenshots...
│
├── Zomato Data Pipeline/
│   ├── zomato /   #DBT
│   ├── airflow/
│   └── other pipeline files...
│
├── zomato_order_sales_analytics/
│   └── dashboard.pbix
│
└── README.md
```

## Result & Conclusion

The project demonstrates a complete modern data workflow from **raw cloud data to business intelligence**. It combines cloud storage, data warehousing, transformation, orchestration, and visualization into one reproducible ELT pipeline.

## Future Work

- Add incremental dbt models and snapshots
- Implement stronger data-quality monitoring
- Add CI/CD for dbt and Airflow
- Add automated pipeline alerts and logging
- Build additional Power BI dashboards with time-series analysis such as **QTD, MTD, YTD, and Same Period Last Year**
- Add day-wise and calendar-based analysis, including **weekday vs. weekend order trends**
- Deploy the pipeline to a production cloud environment

## Author & Contact

**Priyesh Kumar**  
BCA Student | Data Analytics & Engineering


- GitHub:`https://github.com/priyesh7998`
- LinkedIn: `https://linkedin.com/in/priyesh7998`
- Email: `priyesh9080@gmail.com`

