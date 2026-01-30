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

--check that data imported or not
select * from zepto;

--data exploration

--count of rows
select count(*) from zepto;

--sample data 
select * from zepto 
limit 10;

--check for null values
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

--diffrent product category in the data 
select distinct category
from zepto
order by category;

--product in stock and out of stock
select outofstock, count(sku_id)
from zepto 
group by outofstock

--product name present multiple times
select name, count(sku_id) as "Number of SKUs"
from zepto
group by name 
having count(sku_id) > 1
order by count(sku_id) DESC;

--data cleaning

--product price might be 0

select * from zepto 
where mrp = 0
or discountedsellingprice = 0;

--deleting the input where the mpr or the discounted price is 0

delete from zepto 
where mrp=0;

--converting the price frpm paise to rupee
update zepto
set mrp = mrp/100,
discountedsellingprice = discountedsellingprice/100

-- some business analytical related questions
-- Q1 find the top 10 best-valued products based on the discount percentage.

select distinct * from zepto
order by discountpercent desc
limit 10;

-- Q2 what are the products with high mrp but out of stock

select distinct * from zepto 
where outofstock = TRUE and mrp > 300
order by mrp desc

-- Q3 calculate the estimated revenue for each category

select distinct category, sum(discountedsellingprice * availablequantity)
from zepto
group by category
order by sum(discountedsellingprice * availablequantity) desc;

--Q4 find all products where mrp greater than 500 and discount is less than 10%

select distinct * from zepto
where mrp > 500
and discountpercent < 10;


--Q5 identify the top 5 categories offering the highest average discount percentage

select category, ROUND(avg (discountpercent),2)
from zepto 
group by category 
order by avg(discountpercent) desc
limit 5;

--Q6 find the price per gram from the products above 100g and sort by best value.

select distinct name, weightingms, discountedsellingprice, round(discountedsellingprice/weightingms,2) as price_per_grams
from zepto
where weightingms >=100
order by round(discountedsellingprice/weightingms,2);

--Q7 grow the products into categories like low, medium, bulk

select distinct name, weightingms,
case
when weightingms < 1000 then 'Low'
when weightingms < 5000 then 'Medium'
else 'Bulk'
End as weight_category
from zepto
order by weightingms;

--Q8 what is the toatal inventory weight per category

select category,
sum (weightingms * availablequantity) as total_weight
from zepto
group by category
order by total_weight;
