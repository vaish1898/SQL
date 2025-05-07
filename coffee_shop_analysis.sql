-- Step 1: Initial Data Inspection
SELECT *
FROM coffee_shop_sales
LIMIT 10;

-- Step 2: Check for Null Values
SELECT COUNT(*) AS null_sales_count
FROM coffee_shop_sales
WHERE weekly_sales IS NULL;

-- Step 3: Identify Weeks with Maximum Sales
SELECT MAX(weekly_sales) AS max_weekly_sales, 
       week_start_date
FROM coffee_shop_sales
GROUP BY week_start_date
ORDER BY max_weekly_sales DESC
LIMIT 5;

-- Step 4: Determine the Year with the Highest Total Sales
WITH yearly_sales AS (
  SELECT YEAR(week_start_date) AS sales_year, 
         SUM(weekly_sales) AS total_sales
  FROM coffee_shop_sales
  GROUP BY sales_year
)
SELECT sales_year, total_sales
FROM yearly_sales
ORDER BY total_sales DESC;

-- Step 5: Identify the Month with the Highest Sales in the Most Successful Year
WITH monthly_sales AS (
  SELECT MONTH(week_start_date) AS sales_month, 
         SUM(weekly_sales) AS total_sales
  FROM coffee_shop_sales
  WHERE YEAR(week_start_date) = (SELECT sales_year FROM yearly_sales ORDER BY total_sales DESC LIMIT 1)
  GROUP BY sales_month
)
SELECT sales_month, total_sales
FROM monthly_sales
ORDER BY total_sales DESC;

-- Step 6: Find the Store with the Most Sales
WITH total_sales AS (
  SELECT store_id, SUM(weekly_sales) AS total_sales
  FROM coffee_shop_sales
  GROUP BY store_id
)
SELECT store_id, total_sales
FROM total_sales
ORDER BY total_sales DESC
LIMIT 3;

-- Step 7: Create a View for Store Growth Rate
CREATE VIEW store_growth_rate AS
SELECT subquery.store_id,
       (subquery.sales_2023 - subquery.sales_2021) / subquery.sales_2021 AS growth_rate
FROM (SELECT store_id,
             SUM(CASE WHEN YEAR(week_start_date) = 2021 THEN weekly_sales ELSE 0 END) AS sales_2021,
             SUM(CASE WHEN YEAR(week_start_date) = 2023 THEN weekly_sales ELSE 0 END) AS sales_2023
      FROM coffee_shop_sales
      GROUP BY store_id) subquery;

-- Step 8: Identify Stores with Highest Growth Rate from 2021 to 2023
SELECT store_id, ROUND(growth_rate * 100, 2) AS growth_rate_percentage
FROM store_growth_rate
ORDER BY growth_rate_percentage DESC
LIMIT 5;

-- Step 9: Identify Stores with Lowest Growth Rate from 2021 to 2023
SELECT store_id, ROUND(growth_rate * 100, 2) AS growth_rate_percentage
FROM store_growth_rate
ORDER BY growth_rate_percentage ASC
LIMIT 5;

-- Step 10: Analyze Total Sales During Promotional and Non-Promotional Weeks
SELECT 
  CASE WHEN promotion_flag THEN 'Promotional Week' ELSE 'Non-Promotional Week' END AS week_type,
  SUM(weekly_sales) AS total_sales
FROM coffee_shop_sales
GROUP BY week_type;

-- Step 11: Identify Holidays with the Most Sales
SELECT week_start_date, promotion_flag, MAX(weekly_sales) AS highest_sales
FROM coffee_shop_sales
WHERE promotion_flag = true
GROUP BY week_start_date, promotion_flag
ORDER BY highest_sales DESC;
