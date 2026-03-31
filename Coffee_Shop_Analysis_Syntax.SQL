SELECT *
FROM bright_coffee_shop;
--checking what information is available on the data set

SELECT
  MIN(transaction_time) AS opening_time
FROM bright_coffee_shop;
--checking closing time/hours

 SELECT
  MAX(transaction_time) AS closing_time
FROM bright_coffee_shop;
--checking closing time/hours

SELECT DISTINCT store_location
FROM bright_coffee_shop;
--checking which stores are available

SELECT MIN(transaction_date) AS min_date 
FROM bright_coffee_shop;

SELECT MAX(transaction_date) AS latest_date 
FROM bright_coffee_shop;
--checking duration of data transactions

SELECT MIN(unit_price) As cheapest_price
FROM bright_coffee_shop;

SELECT MAX(unit_price) As expensive_price
FROM bright_coffee_shop;
--checking product pricing 0.8 min & 45 max

SELECT DISTINCT product_category
FROM bright_coffee_shop;

SELECT DISTINCT product_type
FROM bright_coffee_shop;

SELECT DISTINCT product_detail
FROM bright_coffee_shop;

SELECT DISTINCT product_category AS category,
                product_detail AS product_name
FROM bright_coffee_shop;
--checking products offered at store

SELECT COUNT(*) AS number_of_rows,
       COUNT(DISTINCT transaction_id) AS number_of_sales,
       COUNT(DISTINCT product_id) AS number_of_products,
       COUNT(DISTINCT store_id) AS number_of_stores,
       SUM(transaction_qty*unit_price) AS total_revenue
       FROM bright_coffee_shop;
--simplifying the whole data

SELECT transaction_id,
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      transaction_qty*unit_price AS revenue_per_tnx
FROM bright_coffee_shop;
--revenue per transaction

SELECT store_location,
       SUM(transaction_qty*unit_price) AS total_revenue
FROM bright_coffee_shop
GROUP BY store_location;
--total revenue per store

SELECT 
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      COUNT(DISTINCT transaction_id) AS Number_of_sales,
      SUM(transaction_qty*unit_price) AS revenue_per_day
FROM bright_coffee_shop
GROUP BY transaction_date,
         Day_name,
         Month_name;
--counting/checking daily rev. per store
    
SELECT 
-- Dates
      transaction_date AS purchase_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      Dayofmonth(transaction_date) AS day_of_month,

      CASE 
            WHEN Dayname(transaction_date) IN ('Sun','Sat') THEN 'Weekend'
            ELSE 'Weekday'
      END AS day_classifiction,

      --date_format(transaction_time, 'HH:mm:ss') AS purchase_time,
      CASE
            WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00' AND '11:59:59' THEN '01. Morning'
            WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN '02. Afternoon'
            WHEN date_format(transaction_time, 'HH:mm:ss') >= '17:00:00' THEN '03. Evening'
      END AS time_buckets,

-- Counts of IDS
      COUNT(DISTINCT transaction_id) AS Number_of_sales,
      COUNT(DISTINCT product_id) AS number_of_products,
      COUNT(DISTINCT store_id) AS number_of_stores,
-- Revenue
      SUM(transaction_qty*unit_price) AS revenue_per_day,

      CASE
            WHEN revenue_per_day <=50 THEN '01. Low Spend'
            WHEN revenue_per_day BETWEEN 51 AND 100 THEN '02. Med Spend'
            ELSE '03. High Spend'
      END AS spend_bucket,

-- Categorical columns
      store_location,
      product_category,
      product_detail

FROM bright_coffee_shop
GROUP BY transaction_date,
         Dayname(transaction_date),
         Monthname(transaction_date),
         Dayofmonth(transaction_date),

         CASE 
            WHEN Dayname(transaction_date) IN ('Sun','Sat') THEN 'Weekend'
            ELSE 'Weekday'
         END,

         CASE
            WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '00:00:00' AND '11:59:59' THEN '01. Morning'
            WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN '02. Afternoon'
            WHEN date_format(transaction_time, 'HH:mm:ss') >= '17:00:00' THEN '03. Evening'
         END,

         store_location,
         product_category,
         product_detail;
