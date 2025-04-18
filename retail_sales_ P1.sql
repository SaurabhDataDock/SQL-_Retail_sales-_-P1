create Database retailsales ;
------------------------------
select database();  -- to check present database .

use retailsales;  -- to select retailsales database .

------------------------------------
SELECT * FROM retailsales.retailsales;
--------------------------------------------------

-- ADDING Primary key
ALTER TABLE `retailsales`.`retailsales` 
CHANGE COLUMN `transactions_id` `transactions_id` INT NOT NULL ,
ADD PRIMARY KEY (`transactions_id`);
--------------------------------------------------

-- CHECKING FOR NULL VALUS
SELECT * FROM retailsales
WHERE transactions_id is null
or customer_id is null
or category is null
or quantiy is null
or price_per_unit is null
or total_sale is null
or sale_date is null;
---------------------------------------

-- DELETE NULL VALUES
DELETE from retailsales
WHERE transactions_id is null
or customer_id is null
or category is null
or quantiy is null
or price_per_unit is null
or total_sale is null
or sale_date is null;
--------------------------------
#________DATA EXPLORATION _____

# 1. counting number of transaction or no of rows .
SELECT count(transactions_id) as total
FROM retailsales;
-------------------------------------
# 2. counting no  of transactions by same customerID
SeLECT customer_id,COUNT(*)
FROM retailsales
group by customer_id;
--------------------------------------

-- 3. counting customer_id
SELECT count(Distinct customer_id ) as Customer_Count
FROM retailsales;
--------------------------------------

-- number of catergories
SELECT count(Distinct category ) as Customer_Count
FROM retailsales;
------------------------------------

-- ___________KEY FINDINGS______________
# 4. write a querry to find all sales from date '22-11-5'
SELECT *
FROM retailsales
WHERE sale_date= "22-11-5";

# 5. WRITE querry to find sales from month of may (5).. 
SELECT *
FROM retailsales
WHERE month(sale_date)= 5;

# 6. Write a sql querry to find sales where category is clothing and quantity >2 and month of sale is November
SELECT *
FROM retailsales
WHERE 
	month(sale_date)= 5
	AND category = "Clothing"
		AND quantiY > 2;
--------------------------------

# 7. Write category to find Total sales from each categogry
SELECT Distinct category, 
		count(*) as totalSales,
        sum(total_Sale) as Sum_of_sales 
FROM retailsales
group by category; 

# 8. Average age of person who purchase items from "Beauty " category
SELECT 
	distinct category,
	Avg(age) over (Partition by category order by category) as avg_Age
FROM retailsales
Where category = 'Beauty';

# 9. Write a  sql querry to find out all transactions where total sales is greater tha 1000
Select * 
FROM retailsales
WHERE total_sale > 1000;

# 10. write a SQL query to find total number of transaction made by each gender in each category 
SELECT 
 category,
 Gender,
 Count(transactions_id) as total_transaction
FROM retailsales
GROUP BY category , Gender
 ORDER BY 1;

 # 11.   Calculate Average sales for each month and calculate best selling Month for each year..
SELECT 
    Year (sale_date),
    month (sale_date),
	avg(total_sale) as Avg_sales
FROM retailsales
GROUP BY  
	year (sale_date) ,
	month(sale_date)
ORDER BY
	1,3 Desc
;

# 12. Find top 5 customer based on highest total sales
SELECT
	customer_id,
	sum(total_sale) as total_purchase,
    Rank() over ( Order by sum(total_sale) desc) as ranks
FROM retailsales
GROUP BY
	customer_id 
ORDER BY 
	ranks asc 
LIMIT 5
;

# 13.  find the number of unique customer who purchase the item from each category . 
SELECT 
	Category,
	count(Distinct customer_id) as un_customers
FROM retailsales
GROUP BY 
	1;
    
# 14. find which shift of timing have highest no of sales morning <12 , afternoon 12 to 17 , night > 17
SELECT 
	count(*) as no_of_sales,
	case 
		WHEN hour(sale_time) < 12 THEN "Morning"
        WHEN hour(sale_time) Between 12 and 17 THEN "Afternoon"
        ELSE "Night"
	END AS shift
FROM retailsales
GROUP BY
	shift
;
-------------------------------------
-- ___________ THE END  ____________



    

