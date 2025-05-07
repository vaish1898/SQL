-- Create Database
CREATE DATABASE coffee_shop_db;
USE coffee_shop_db;

-- Create Table for Coffee Shop Sales Data
CREATE TABLE coffee_shop_sales (
    store_id INT,
    week_start_date DATE,
    weekly_sales DECIMAL(10, 2),
    promotion_flag BOOLEAN,
    customer_rating DECIMAL(2, 1)
);
