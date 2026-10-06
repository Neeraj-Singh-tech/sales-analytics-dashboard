-- Extract base retail sales data for NovaMart analytics
SELECT
    s.order_id,
    s.order_date,
    s.customer_id,
    s.product_id,
    p.product_name,
    p.category,
    s.region,
    s.quantity,
    s.unit_price,
    s.discount,
    (s.quantity * s.unit_price) AS gross_sales,
    (s.quantity * s.unit_price) * (1 - COALESCE(s.discount, 0)) AS net_sales,
    (s.quantity * p.unit_cost) AS total_cost,
    ((s.quantity * s.unit_price) * (1 - COALESCE(s.discount, 0))) - (s.quantity * p.unit_cost) AS profit
FROM sales s
JOIN products p
    ON s.product_id = p.product_id
WHERE s.order_date >= DATE '2025-01-01'
  AND s.order_date < DATE '2026-01-01';
