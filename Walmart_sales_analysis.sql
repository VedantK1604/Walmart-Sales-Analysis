-- CREATING DATABASE:
CREATE DATABASE walmart;
-------------------------------------------------------------------------------------------------------------------------------------------
-- CREATING TABLE :
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(3, 1)
);
SELECT * FROM sales;
-------------------------------------------------------------------------------------------------------------------------------------------
-- FEATURE ENGINEERING (Adding new columns- time_of_day, day_name, month_name)

# 1. Time_of_day:
SELECT time,
	(
	CASE 
		WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
	END
	) AS time_of_day
FROM sales;

ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);
UPDATE sales
SET time_of_day = (CASE 
		WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
	END);

# 2. Day_name:
SELECT date, DAYNAME(date) AS day_name FROM sales;

ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);
UPDATE sales
SET day_name = DAYNAME(date);

# 3. Month_name:
-- we have 3 months i.e. January, February, and March

SELECT date, MONTHNAME(date) AS month_name FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
UPDATE sales
SET MONTH_name = MONTHNAME(date);

----------------------------------------------------------------------------------------------------------------------------------------
--                              EXPLORATORY DATA ANALYSIS:
----------------------------------------------------------------------------------------------------------------------------------------
-- GENERIC QUESTION

# 1. How many unique citites does the data have?
SELECT DISTINCT(city) FROM sales;

# 2. In which city is each brand?
SELECT DISTINCT(city), branch FROM sales;
----------------------------------------------------------------------------------------------------------------------------------------

-- PRODUCTS QUESTIONS:

# 1. How many product lines does the data have?
SELECT COUNT(DISTINCT(product_line)) AS No_of_product_lines FROM sales; 

# 2. Which is the most common payment method?
SELECT payment AS Payment_method FROM sales
GROUP BY payment
HAVING COUNT(payment) = (SELECT COUNT(payment) FROM sales 
						GROUP BY payment
						ORDER BY COUNT(payment) DESC LIMIT 1);
                        
# 3. Which is the most selling product line?
SELECT product_line, COUNT(product_line) AS Count FROM sales
GROUP BY product_line
ORDER BY Count DESC LIMIT 1;

# 4. What are the 3 top most profitable product line?
SELECT product_line, SUM(total) AS total FROM sales
GROUP BY product_line
ORDER BY total DESC LIMIT 3;

# 5. What is the total revenue by month?
SELECT month_name AS Month, SUM(total) AS Revenue FROM sales
group by month_name
ORDER BY Revenue DESC;

# 6. Which month has the largest Cogs?
SELECT ANY_VALUE(month_name) AS Month, ANY_VALUE(SUM(cogs)) AS total_cogs FROM sales
group by month_name
ORDER BY total_cogs DESC LIMIT 1;

# 7. Which City and branch has the largest revenue?
SELECT branch, city, SUM(total) AS revenue FROM sales
GROUP BY city, branch
ORDER BY revenue DESC LIMIT 1; 

# 8. What product line has the largest VAT?
SELECT product_line, AVG(tax_pct) as Avg_tax FROM sales
GROUP BY product_line
ORDER BY Avg_tax DESC;

# 9. Which brand sold more product than overall average product sold?
SELECT branch, SUM(quantity) AS Quantity FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

# 10. What is the most common product line by gender?
SELECT product_line,gender, COUNT(gender) AS Count FROM sales
GROUP BY product_line, gender
ORDER BY Count DESC;

# 11. What is the average rating of each product line?
SELECT product_line, ROUND(AVG(rating),2) AS Avg_rating FROM sales
GROUP BY product_line
ORDER BY Avg_rating DESC;

# 12. Fetch Each product line and add a column to those product line called product_quality
# showing quality as "Good" or "Bad".
# Good if it is greater than average unit price.

SELECT invoice_id ,product_line, unit_price,
(
CASE
	WHEN unit_price >= (SELECT AVG(unit_price) FROM sales) THEN 'Good'
    ELSE 'Bad'
END
) AS poduct_quality
FROM sales;
------------------------------------------------------------------------------------------------------------------------------------------
-- SALES QUESTIONS:

# 1. Number of sales made in each time of day per week.
SELECT time_of_day, COUNT(*) AS total_sales FROM sales
GROUP BY time_of_day;

# 2. Which customer type brings the most revenue?
SELECT customer_type, SUM(total) AS revenue FROM sales
GROUP BY customer_type;

# 3. Which city has the largest Average tax percent?
SELECT city, AVG(tax_pct) AS avg_tax_pct FROM sales
GROUP BY city
ORDER BY avg_tax_pct DESC LIMIT 1;

# 4. Total income with total sale by each day in a Month with time of that day
SELECT date, month_name, day_name, time_of_day,SUM(quantity) AS quantity_sold, 
SUM(total) total_sale FROM sales
GROUP BY date, month_name, day_name, time_of_day
ORDER BY date ASC;
------------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOMER QUESTIONS:

# 1. How many unique customer types does the data have?
SELECT DISTINCT customer_type FROM sales;

# 2. What is the most common customer type?
SELECT customer_type, COUNT(*) No_of_time_buys FROM sales
GROUP BY customer_type
ORDER BY No_of_time_buys DESC;

# 3. Which customer type buys the most?
 SELECT customer_type, SUM(quantity) AS Total_buys FROM sales
 GROUP BY customer_type
 ORDER BY Total_buys DESC;
 
# 4. What is the gender of most of the customers with their customer types?
SELECT customer_type, gender, COUNT(*) AS Count FROM sales
GROUP BY customer_type, gender
ORDER BY Count DESC; 

# 5. Which time of the day do customers give most ratings?
SELECT time_of_day, AVG(rating) AS avg_rating FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

# 6. Which day fo the week has the best avg ratings?
SELECT day_name, AVG(rating) AS avg_rating FROM sales
GROUP BY day_name 
ORDER BY avg_rating DESC;
-------------------------------------------------------------------------------------------------------------------------------------------



