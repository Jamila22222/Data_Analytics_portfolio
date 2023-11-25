SELECT
  time,
  CASE
    WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'morning'
    WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'afternoon'
    ELSE 'evening'
  END AS time_of_date
FROM sales;


alter table sales add column time_of_day varchar (20);

-- to unter the time of the day------


UPDATE sales
SET time_of_day = (
  CASE
    WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'morning'
    WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'afternoon'
    ELSE 'evening'
  END
);

-- day_name --------
UPDATE sales
SET time_of_day = (
  CASE
    WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'morning'
    WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'afternoon'
    ELSE 'evening'
  END
);

select 
date,
	DAYNAME(date)
from sales;

ALTER table sales add column day_name varchar(10);



update sales 
set day_name = dayname(date);


-- month_name ---

select
	date,
    monthname (date)
from sales;

alter table sales add column month_name varchar (10);

update sales 
set month_name = monthname(date);


-- ----------generic questions---------
-- How many unique cities does the data have?---

select distinct city
from sales;

-- In which city is each branch?---

select distinct branch
from sales;

select 
	distinct city,
    branch
from sales;



-- --------------product questions ------------------------------

-- How many unique product lines does the data have?---

select 
	count(distinct product_line)
from sales;


-- What is the most common payment method?---
	select 
		count(payment_method) as count_num, payment_method
    from sales
    group by payment_method
    order by count_num desc;
    
    -- What is the most selling product line?---
select * from sales;

select 
	count( product_line), Product_line
from sales
group by product_line
order by count( product_line) desc;

-- What is the total revenue by month?---
    select* from sales;
    
SELECT 
    month_name AS month,
    SUM(total) AS total_sum
FROM sales
GROUP BY month_name
ORDER BY total_sum desc;

    
-- What month had the largest cost_of goods------

select
	month_name as month,
    sum(cogs) as cost_of_goods
from sales
group by month_name
order by cost_of_goods asc;

-- What product line had the largest revenue?------

select * from  sales;
select 
	product_line,
    sum(total) as total_revenue
from sales
group by product_line
order by total_revenue desc;

-- What is the city with the largest revenue?------
select * from sales;

select 
	Branch,
	city,
    sum(total) as city_revenue
from sales
group by city, Branch
order by city_revenue desc;

-- What product line had the largest Value after tax--------
select
	product_line,
    avg(vat) as average_tax
from sales
group by product_line
order by average_tax desc ;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales--------




-- Which branch sold more products than average product sold?--------
SELECT 
    Branch,
    SUM(Quantity) AS quantity
FROM sales
GROUP BY Branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales)
ORDER BY quantity DESC;

    
-- What is the most common product line by gender?--------

select 
	gender,
	product_line,
    count(gender) as gender_count
from sales
group by product_line, gender
order by gender_count desc;


-- What is the average rating of each product line? -----

select 
	round ( avg(rating),2) as avg_rating,
    product_line
from sales
group by product_line
order by avg_rating desc;



-- sales questions-------------------------------

-- Number of sales made in each time of the day per weekday-----

select * from sales;

select 
	time_of_day,
    count(*) as total_sales
from sales
group by time_of_day
order by total_sales desc;

select 
	time_of_day,
    count(*) as total_sales
from sales
where day_name = 'monday'
group by time_of_day
order by total_sales desc;


-- Which of the customer types brings the most revenue?-----

select 
	customer_type,
    sum(total) as total
from sales
group by customer_type
order by total desc ;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?-----

select 
	city,
    avg (vat) as tax_average
from sales
group by city
order by tax_average desc;


-- Which customer type pays the most in VAT?-----
SELECT
    customer_type,
    AVG(vat) AS vat
FROM sales
GROUP BY customer_type
ORDER BY vat DESC;



-- customers  questions--------------------

-- How many unique customer types does the data have?-----

select 
 distinct customer_type
from sales;


-- How many unique payment methods does the data have?-----

select 
 distinct Payment_method
from sales;


-- Which customer type buys the most?-----
select 
	customer_type,
	count(*) as type_count
from sales
group by customer_type
order by type_count desc;


-- What is the most common customer type?-----
select 
	customer_type,
	count(*) as customer
from sales
group by customer_type
order by customer desc;


-- What is the gender of most of the customers?-----

select 
	gender,
	count(*) as gender_count
from sales
group by gender
order by gender_count;

-- What is the gender distribution per branch?-----
SELECT 
    gender,
    COUNT(*) AS gender_count
FROM sales
WHERE branch = 'c'
GROUP BY gender
ORDER BY gender_count DESC;

SELECT 
    gender,
    COUNT(*) AS gender_count
FROM sales
WHERE branch = 'b'
GROUP BY gender
ORDER BY gender_count DESC;

SELECT 
    gender,
    COUNT(*) AS gender_count
FROM sales
WHERE branch = 'c'
GROUP BY gender
ORDER BY gender_count DESC;


--     Which time of the day do customers give most ratings? -----

select 
	time_of_day,
    sum(rating) as rating
from sales 
group by time_of_day
order by rating desc;

select 
	time_of_day,
    avg(rating) as rating
from sales 
group by time_of_day
order by rating desc;
    
    
    -- Which time of the day do customers give most ratings per branch? -----
    
    select 
	time_of_day,
    avg(rating) as rating
from sales 
where branch = 'c'
group by time_of_day
order by rating desc;
    
    
 -- Which day of the week has the best avg ratings?-----

select 
	 day_name,
     avg (rating) as rating 
from sales 
group by day_name
order by rating;





