-- Transform extracted sales data into dashboard-ready aggregates
WITH base AS (
    SELECT
        order_id,
        order_date,
        customer_id,
        product_id,
        product_name,
        category,
        region,
        quantity,
        unit_price,
        discount,
        gross_sales,
        net_sales,
        total_cost,
        profit,
        DATE_TRUNC('month', order_date) AS order_month,
        EXTRACT(quarter FROM order_date) AS order_quarter,
        EXTRACT(year FROM order_date) AS order_year
    FROM novamart_sales_extract
),
regional_performance AS (
    SELECT
        order_year,
        order_quarter,
        region,
        SUM(net_sales) AS total_revenue,
        SUM(profit) AS total_profit,
        SUM(quantity) AS total_units,
        CASE WHEN SUM(net_sales) = 0 THEN 0
             ELSE SUM(profit) / SUM(net_sales)
        END AS margin_pct
    FROM base
    GROUP BY 1, 2, 3
),
product_performance AS (
    SELECT
        order_year,
        order_quarter,
        product_id,
        product_name,
        category,
        SUM(net_sales) AS product_revenue,
        SUM(profit) AS product_profit,
        SUM(quantity) AS units_sold,
        DENSE_RANK() OVER (
            PARTITION BY order_year, order_quarter
            ORDER BY SUM(net_sales) DESC
        ) AS revenue_rank
    FROM base
    GROUP BY 1, 2, 3, 4, 5
)
SELECT
    b.order_id,
    b.order_date,
    b.order_month,
    b.order_quarter,
    b.order_year,
    b.customer_id,
    b.product_id,
    b.product_name,
    b.category,
    b.region,
    b.quantity,
    b.unit_price,
    b.discount,
    b.gross_sales,
    b.net_sales,
    b.total_cost,
    b.profit,
    rp.total_revenue AS region_revenue_quarter,
    rp.total_profit AS region_profit_quarter,
    rp.margin_pct AS region_margin_pct_quarter,
    pp.product_revenue AS product_revenue_quarter,
    pp.product_profit AS product_profit_quarter,
    pp.revenue_rank AS product_revenue_rank_quarter
FROM base b
LEFT JOIN regional_performance rp
    ON b.order_year = rp.order_year
   AND b.order_quarter = rp.order_quarter
   AND b.region = rp.region
LEFT JOIN product_performance pp
    ON b.order_year = pp.order_year
   AND b.order_quarter = pp.order_quarter
   AND b.product_id = pp.product_id;
