-- Retrieving the data
SELECT *
FROM workspace.fnb.fnb_sales_dataset;


--creatING one cleaned table with calculations
CREATE OR REPLACE TABLE workspace.fnb.fnb_sales_clean AS
SELECT
    Date,
    Sales,
    `Cost Of Sales` AS Cost_Of_Sales,
    `Quantity Sold` AS Quantity_Sold,

    Sales - `Cost Of Sales` AS Gross_Profit,

    Sales / `Quantity Sold` AS Unit_Price,

    `Cost Of Sales` / `Quantity Sold` AS Cost_Per_Unit,

    ((Sales - `Cost Of Sales`) / Sales) * 100 AS Gross_Profit_Percentage,

    (Sales - `Cost Of Sales`) / `Quantity Sold` AS Gross_Profit_Per_Unit

FROM workspace.fnb.fnb_sales_dataset;

CREATE OR REPLACE TABLE workspace.fnb.fnb_sales_gold AS

SELECT
    *,
    
    -- Running Total of Gross Profit
    SUM(Gross_Profit)
    OVER (
        ORDER BY Date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Rolling_Profit,

    -- Overall Average Selling Price
    AVG(Unit_Price)
    OVER () AS Average_Unit_Price,

    -- Date Dimensions
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    DATE_FORMAT(Date,'MMMM') AS Month_Name,
    QUARTER(Date) AS Quarter,
    DATE_FORMAT(Date,'EEEE') AS Day_Of_Week

FROM workspace.fnb.fnb_sales_clean;

-- Final table

SELECT * FROM workspace.fnb.fnb_sales_gold;

--