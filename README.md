# Zepto_inventory_analysis

## Project Overview

**Product Title**: Inventory Data Analysis.
**Level**: Beginner.
**Database**: 'https://www.kaggle.com/datasets/palvinder2006/zepto-inventory-dataset'.

This project demonstrates practical SQL skills and analytical techniques used to explore, clean, and analyze inventory data in a quick-commerce setting similar to Zepto. It involves working with a structured inventory dataset, performing data cleaning and preparation, and conducting exploratory data analysis to understand pricing patterns, discount strategies, stock availability, product value, and category performance. Using SQL queries, the project answers key business questions related to revenue estimation, stockouts, unit pricing, and inventory distribution, showing how raw data can be transformed into meaningful insights that support better inventory planning and operational decision-making. This project is particularly valuable for beginners in data analytics looking to build a strong foundation in SQL through a practical, business-focused use case.

## Objectives:
1. To analyze inventory data of a quick-commerce platform similar to Zepto using SQL.
2. To understand product pricing patterns, including MRP, discounted price, and actual value through unit price analysis.
3. To identify stock availability issues such as out-of-stock high-value products.
4. To estimate category-wise revenue contribution and determine high-performing product segments.
5. To classify products based on quantity/weight for better inventory segmentation.
6. To evaluate inventory distribution in terms of total weight across categories.
7. To develop a structured and scalable SQL-based approach for inventory analysis and business insight generation.

## Project Structure

## Database & Table setup

```sql
drop table if exists zepto;

create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(100),
name VARCHAR(150) not null,
mrp numeric(8,2),
discountpercent numeric(5,2),
availablequantity INTEGER,
discountedsellingprice NUMERIC(8,2),
weightingms integer,
outofstock boolean,
quantity int
);
```

## Check that data imported or not
```sql
select * from zepto;
```

## Data exploration
## Count of rows
```sql
select count(*) from zepto;
```

## Sample data 
```sql
select * from zepto 
limit 10;
```

## Check for null values 
```sql
select * from zepto
where name is null
or category is null
or mrp is null
or discountpercent is null
or availablequantity is null
or discountedsellingprice is null
or weightingms is null
or outofstock is null
or quantity is null;
```

## Diffrent product category in the data
```sql
select distinct category
from zepto
order by category;
```

## Product in stock and out of stock
```sql
select outofstock, count(sku_id)
from zepto 
group by outofstock;
```

## Product name present multiple times
```sql
select name, count(sku_id) as "Number of SKUs"
from zepto
group by name 
having count(sku_id) > 1
order by count(sku_id) DESC;
```

## Data cleaning
## Product price might be 0
```sql
select * from zepto 
where mrp = 0
or discountedsellingprice = 0;
```

## Deleting the input where the mpr or the discounted price is 0
```sql
delete from zepto 
where mrp=0;
```

## Converting the price frpm paise to rupee
```sql
update zepto
set mrp = mrp/100,
discountedsellingprice = discountedsellingprice/100;
```

## Some business analytical related questions
## Q1 Find the top 10 best-valued products based on the discount percentage.
```sql
select distinct * from zepto
order by discountpercent desc
limit 10;
```

## Q2 What are the products with high mrp but out of stock
```sql
select distinct * from zepto 
where outofstock = TRUE and mrp > 300
order by mrp desc;
```

## Q3 Calculate the estimated revenue for each category
```sql
select distinct category, sum(discountedsellingprice * availablequantity)
from zepto
group by category
order by sum(discountedsellingprice * availablequantity) desc;
```

## Q4 Find all products where mrp greater than 500 and discount is less than 10%
```sql
select distinct * from zepto
where mrp > 500
and discountpercent < 10;
```

## Q5 Identify the top 5 categories offering the highest average discount percentage
```sql
select category, ROUND(avg (discountpercent),2)
from zepto 
group by category 
order by avg(discountpercent) desc
limit 5;
```

## Q6 Find the price per gram from the products above 100g and sort by best value.
```sql
select distinct name, weightingms, discountedsellingprice, round(discountedsellingprice/weightingms,2) as price_per_grams
from zepto
where weightingms >=100
order by round(discountedsellingprice/weightingms,2);
```

## Q7 Grow the products into categories like low, medium, bulk
```sql
select distinct name, weightingms,
case
when weightingms < 1000 then 'Low'
when weightingms < 5000 then 'Medium'
else 'Bulk'
End as weight_category
from zepto
order by weightingms;
```

## Q8 What is the toatal inventory weight per category
```sql
select category,
sum (weightingms * availablequantity) as total_weight
from zepto
group by category
order by total_weight;
```
