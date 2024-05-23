SELECT *
FROM WalmartSales..Sales


--------------- Feature Engineering -------------------
-- Time of day

SELECT 
	Time,
	(CASE 
		WHEN Time BETWEEN '00:00:00' and '12:00:00' THEN 'Morning'
		WHEN Time BETWEEN '12:01:00' and '16:00:00' THEN 'Afternoon'
		ELSE 'Evening' 
		END
	) AS time_of_date
FROM WalmartSales..Sales


ALTER TABLE WalmartSales..Sales ADD time_of_day VARCHAR(20)

UPDATE WalmartSales..Sales
SET time_of_day = (
					CASE
						WHEN Time BETWEEN '00:00:00' and '12:00:00' THEN 'Morning'
						WHEN Time BETWEEN '12:01:00' and '16:00:00' THEN 'Afternoon'
						ELSE 'Evening' 
						END
					)

--- Day name
Select 
Date,
FORMAT(Date, 'dddd') AS day_name
FROM WalmartSales..Sales

ALTER TABLE WalmartSales..Sales ADD day_name VARCHAR(10)

UPDATE WalmartSales..Sales
SET day_name = FORMAT(Date, 'dddd')

--Month name
SELECT 
Date,
FORMAT(Date, 'MMMM') AS month_name
FROM WalmartSales..Sales

ALTER TABLE WalmartSales..Sales ADD month_name VARCHAR(10)

UPDATE WalmartSales..Sales 
SET month_name = FORMAT(Date, 'MMMM')

--------------------------------------PRODUCT---------------------------------------
--- How many unique cities does the data have

SELECT 
DISTINCT City
FROM WalmartSales..Sales

--- In which City is each Branch

SELECT 
DISTINCT City,
Branch
FROM WalmartSales..Sales

--- How many unique product lines does the data have ?

SELECT 
COUNT(DISTINCT Product_line)
FROM WalmartSales..Sales

--- What is the most commun payment method ?

SELECT 
Payment,
COUNT(Payment) CNT
FROM WalmartSales..Sales
GROUP BY Payment
ORDER BY CNT DESC


--- What is the most selling product line ?

SELECT 
Product_line,
COUNT(Product_line) AS CNT
FROM WalmartSales..Sales
GROUP BY Product_line
ORDER BY CNT DESC

--- What is the total revenue by month

SELECT 
month_name AS Month,
SUM(Total) AS Total_Revenue
FROM WalmartSales..Sales
GROUP BY month_name
ORDER by Total_Revenue DESC

--- What Month had the largest COGS ? 

SELECT 
month_name AS Month,
SUM(cogs) AS COGS
FROM WalmartSales..Sales
GROUP BY month_name
ORDER BY COGS DESC

--- What product line had the largest revenue ?

SELECT 
Product_line,
SUM(Total) AS Total_Revenue
FROM WalmartSales..Sales
GROUP BY Product_line
ORDER BY Total_Revenue DESC

--- What is the city with the largest revenue ?

SELECT 
Branch,
City,
SUM(Total) AS Total_Revenue
FROM WalmartSales..Sales
GROUP BY City, Branch
ORDER BY Total_Revenue DESC

--- What product line had the largest VAT ?

SELECT 
Product_line,
AVG(VAT) AS Total_VAT
FROM WalmartSales..Sales
GROUP BY Product_line
ORDER BY Total_VAT DESC

--- Fetch each product line and add a column to those product line showing 'Good', 'Bad'. Good if its greater than average sales.

SELECT 

FROM WalmartSales..Sales


--- Which Branch sold more products than average product sold?

SELECT 
Branch,
SUM(cast(Quantity as int)) AS Qty
FROM WalmartSales..Sales
GROUP BY Branch
HAVING SUM(cast(Quantity as int)) > (Select AVG(cast(Quantity as int)) FROM WalmartSales..Sales)

--- What is the most common product line by gender

SELECT 
Gender,
Product_line,
COUNT(Gender) AS Total_CNT
FROM WalmartSales..Sales
GROUP BY Gender, Product_line
ORDER BY Total_CNT DESC

--- What is the average rating of each product line ?

SELECT 
Product_line,
ROUND(AVG(Rating), 2) AS Avg_Rating
FROM WalmartSales..Sales
GROUP BY Product_line
ORDER BY Avg_Rating DESC

-----------------------------------SALES--------------------------------
---Number of sales made in each time of the day per weekday ?

SELECT 
time_of_day,
COUNT(Total) AS Total_Sales
FROM WalmartSales..Sales
WHERE day_name = 'Sunday'    --- Weekday ---
GROUP BY time_of_day
ORDER BY Total_Sales DESC


---Which of the Customer types brings the most revenue ?

SELECT 
Customer_type,
SUM(Total) AS Revenue
FROM WalmartSales..Sales
GROUP BY Customer_type
ORDER BY Revenue DESC


--- Which City has the largest VAT ?

SELECT 
City,
AVG(VAT) AS VAT
FROM WalmartSales..Sales
GROUP BY City
ORDER BY VAT DESC

--- Which Customer type pays the most in VAT ?


SELECT 
Customer_type,
AVG(VAT) AS VAT
FROM WalmartSales..Sales
GROUP BY Customer_type
ORDER BY VAT DESC

-----------------------------------Customer--------------------------------
--- How many unique customer types does the data have ?

SELECT 
DISTINCT Customer_type
FROM WalmartSales..Sales

--- How many unique payment methods does the data have ?

SELECT 
DISTINCT Payment
FROM WalmartSales..Sales

---Which Customer type buys the most ?

SELECT 
Customer_type,
COUNT(Total) AS Total_Sales
FROM WalmartSales..Sales
GROUP BY Customer_type
ORDER BY Total_Sales DESC

--- What is the gender of most of the Customers ?

SELECT
Gender,
COUNT(Gender) AS CNT_Gender
FROM WalmartSales..Sales
GROUP BY Gender
ORDER BY CNT_Gender DESC

--- What is the gender distribution per Branch ?

SELECT 
Gender,
COUNT(gender) AS Gender_Dist
FROM WalmartSales..Sales
WHERE Branch = 'A'    --- Choose a Branch
GROUP BY Gender
ORDER BY Gender_Dist DESC

--- Which time of the day do customers give most ratings ?

SELECT 
time_of_day,
AVG(Rating) AS avg_rating
FROM WalmartSales..Sales
GROUP BY time_of_day
ORDER BY avg_rating DESC

--- Which time of the day do customers give most ratings per Branch ?

SELECT 
time_of_day,
AVG(Rating) AS avg_rating
FROM WalmartSales..Sales
WHERE Branch = 'C'    --- Choose a Branch
GROUP BY time_of_day
ORDER BY avg_rating DESC


--- Which day of the week has the best avg ratings ?

SELECT 
day_name,
AVG(Rating) AS avg_rating
FROM WalmartSales..Sales
GROUP BY day_name
ORDER BY avg_rating DESC


--- Which day of the week has the best avg ratings per Branch ?

SELECT 
day_name,
AVG(Rating) AS avg_rating
FROM WalmartSales..Sales
WHERE Branch = 'B'
GROUP BY day_name
ORDER BY avg_rating DESC