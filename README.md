# Retail Sales Performance Analytics Dashboard (NovaMart)

## Executive Summary
NovaMart's leadership needs a clear view of regional sales performance, product contribution, and profitability trends to plan next quarter targets. This project delivers a full analytics workflow from extraction to dashboarding:

- **SQL scripts** prepare clean, analysis-ready sales data.
- **Jupyter notebook** performs EDA and data quality cleanup.
- **Tableau workbook** provides an interactive executive dashboard.
- **Repository documentation** explains how to run each step.

### Key business questions addressed
1. Which regions drive the highest revenue and profit?
2. Which products and categories are top performers?
3. How are monthly and quarterly sales trending?
4. Where are margin opportunities or underperforming segments?

## Repository Deliverables

### 1) SQL scripts (data extraction & transformation)
- `/home/runner/work/sales-analytics-dashboard/sales-analytics-dashboard/sql/01_extract_sales_data.sql`
  - Extracts sales + product details and calculates gross sales, net sales, cost, and profit.
- `/home/runner/work/sales-analytics-dashboard/sales-analytics-dashboard/sql/02_transform_sales_data.sql`
  - Creates dashboard-ready fields and quarterly aggregates for region and product performance.

### 2) Python Jupyter Notebook (EDA & cleaning)
- `/home/runner/work/sales-analytics-dashboard/sales-analytics-dashboard/notebooks/novamart_sales_eda.ipynb`
  - Loads raw CSV data from `data/raw/sales_data.csv`
  - Cleans dates, numeric fields, missing discount/cost, and duplicates
  - Recomputes business metrics and exports cleaned data to `data/processed/sales_clean.csv`

### 3) Interactive Tableau dashboard
- `/home/runner/work/sales-analytics-dashboard/sales-analytics-dashboard/dashboard/novamart_sales_dashboard.twb`
  - Data source points to `data/processed/sales_clean.csv`
  - Includes worksheet structure for:
    - Revenue by Region
    - Top Products
    - Monthly Sales Trend
  - Includes an Executive Overview dashboard container for interactive assembly

### 4) Executive summary (this README)
This README serves as the one-page executive summary and implementation guide.

## How to use
1. Run SQL extraction script on your warehouse/source database.
2. Materialize output into `novamart_sales_extract` (table or view).
3. Run transformation script to produce dashboard-ready output.
4. Place raw CSV as `data/raw/sales_data.csv` and run notebook end-to-end.
5. Open Tableau workbook and refresh data source from `data/processed/sales_clean.csv`.

## Suggested dashboard KPIs
- Total Revenue
- Total Profit
- Profit Margin %
- Units Sold
- Top 10 Products by Revenue
- Revenue and Profit by Region (quarterly filter)
