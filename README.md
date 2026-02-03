# Zepto_inventory_analysis

## Project Overview

**Product Title**: Inventory Data Analysis
**Level**: Beginner
**Database**: 'https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset'

This project demonstrates practical SQL skills and analytical techniques used to explore, clean, and analyze inventory data in a quick-commerce setting similar to Zepto. It involves working with a structured inventory dataset, performing data cleaning and preparation, and conducting exploratory data analysis to understand pricing patterns, discount strategies, stock availability, product value, and category performance. Using SQL queries, the project answers key business questions related to revenue estimation, stockouts, unit pricing, and inventory distribution, showing how raw data can be transformed into meaningful insights that support better inventory planning and operational decision-making. This project is particularly valuable for beginners in data analytics looking to build a strong foundation in SQL through a practical, business-focused use case.

## Objectives:
-To analyze inventory data of a quick-commerce platform similar to Zepto using SQL.=
-To understand product pricing patterns, including MRP, discounted price, and actual value through unit price analysis.
-To identify stock availability issues such as out-of-stock high-value products.
-To estimate category-wise revenue contribution and determine high-performing product segments.
-To classify products based on quantity/weight for better inventory segmentation.
-To evaluate inventory distribution in terms of total weight across categories.
-To develop a structured and scalable SQL-based approach for inventory analysis and business insight generation.

## Project Structure

## 1) Database & Table setup

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```




