
-- Extract Transformed data into sql server 
--and preforming following data query

--3. SQL Queries: Write SQL queries to answer the following questions:

--  - What was the total sales amount for each product in the last quarter (last 3 months)?


DECLARE @a DATETIME
SET @a = (SELECT MAX([Month]) FROM Product_by_sale);

select Product
	,sum(Total_sales) as Last_3_Month_sales from Product_by_sale
where [Month] >= DATEADD(M, -3, @a) 
group by Product



  -- - List the top 5 products by total sales amount for the entire dataset.

select top 5 Product,Total_sales from Product_by_sale
order by Total_sales desc


  -- - Calculate the monthly average sales for each product over the entire dataset.

-- Create a cte count number of sale month for each products
;with a as 
	(select Product
		,sum(case when [Month] is not null then 1 else 0 end) as Month_count 
		,sum([Total_sales]) as Total_sales
from Product_by_sale
group by Product)

select Product, Total_sales/ Month_count as Monthly_average_sales from a


