SELECT *
FROM workspace.fnb.fnb_sales_dataset;

-- Total records
SELECT COUNT(*) AS total_records
FROM workspace.fnb.fnb_sales_dataset; 

-- Results: total_recors is 1053

-- Check for NULL values
SELECT
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS null_dates,
    SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS null_sales,
    SUM(CASE WHEN `Cost Of Sales` IS NULL THEN 1 ELSE 0 END) AS null_cost,
    SUM(CASE WHEN `Quantity Sold` IS NULL THEN 1 ELSE 0 END) AS null_quantity
FROM workspace.fnb.fnb_sales_dataset;
-- Results: No NULL values

-- Duplicate records
SELECT
    Date,
    Sales,
    `Cost Of Sales`,
    `Quantity Sold`,
    COUNT(*) AS duplicate_count
FROM workspace.fnb.fnb_sales_dataset
GROUP BY
    Date,
    Sales,
    `Cost Of Sales`,
    `Quantity Sold`
HAVING COUNT(*) > 1;
-- Results: No duplicates

-- Checking Data types
DESCRIBE workspace.fnb.fnb_sales_dataset;
-- Results: Date column is in timestamp
--        : Sales and Cost of sales in Decimal values

-- Summary statistics
SELECT
    MIN(Sales) AS min_sales,
    MAX(Sales) AS max_sales,
    AVG(Sales) AS avg_sales,

    MIN(`Cost Of Sales`) AS min_cost,
    MAX(`Cost Of Sales`) AS max_cost,
    AVG(`Cost Of Sales`) AS avg_cost,

    MIN(`Quantity Sold`) AS min_quantity,
    MAX(`Quantity Sold`) AS max_quantity,
    AVG(`Quantity Sold`) AS avg_quantity
FROM workspace.fnb.fnb_sales_dataset;

-- Date range
SELECT
    MIN(Date) AS start_date,
    MAX(Date) AS end_date
FROM workspace.fnb.fnb_sales_dataset;



