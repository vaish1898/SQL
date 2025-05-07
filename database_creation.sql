-- Create the coffee shop sales database
CREATE DATABASE IF NOT EXISTS coffee_shop_db;
USE coffee_shop_db;

-- Create the coffee shop sales table
CREATE TABLE IF NOT EXISTS coffee_shop_sales (
    store_id INT NOT NULL,
    week_start_date DATE NOT NULL,
    weekly_sales DECIMAL(10, 2),
    promotion_flag BOOLEAN,
    customer_rating DECIMAL(2, 1),
    PRIMARY KEY (store_id, week_start_date)
);

-- Optional: Create an index on store_id for faster querying by store
CREATE INDEX idx_store_id ON coffee_shop_sales (store_id);

-- Sample INSERT Statements for Initial Data (Replace with your data loading process)
-- Example to insert sample data:
INSERT INTO coffee_shop_sales (store_id, week_start_date, weekly_sales, promotion_flag, customer_rating)
VALUES
(1, '2023-01-01', 1200.50, TRUE, 4.2),
(1, '2023-01-08', 1350.00, FALSE, 4.5),
(2, '2023-01-01', 950.30, FALSE, 3.9),
(2, '2023-01-08', 1020.60, TRUE, 4.3),
(3, '2023-01-01', 1100.75, TRUE, 4.1);
