Use retail;
SELECT * FROM retail.blinkit1;

SELECT count(*) FROM retail.blinkit1;

-- Data cleaning

select distinct Item_Fat_Content from blinkit1;

set sql_safe_updates = 0;

update blinkit1
set Item_Fat_Content = 
case
when Item_Fat_Content = 'reg' then 'Regular'
when Item_Fat_Content in ('LF' , 'low fat') then 'Low Fat' 
else Item_Fat_Content end;

-- TOTAL SALES:

Select sum(Sales) as Total_sales from blinkit1;
Select round(sum(Sales)/1000000,3) as Total_sales from blinkit1; -- converted into milion

-- AVERAGE SALES

Select round(avg(Sales),0) as Average_sales from blinkit1;

-- NO OF ITEMS

Select count(*) as No_of_items from blinkit1;

-- AVG RATING

Select round(avg(Rating),2) as Average_rating  from blinkit1;

-- Total Sales by Fat Content

Select Item_Fat_Content, round(sum(Sales),2)  As Total_Sales
from blinkit1
group by Item_Fat_Content
order by Total_Sales desc;

-- Total Sales by Item Type

Select Item_Type, round(sum(Sales),2)  As Total_Sales
from blinkit1
group by Item_Type
order by Total_Sales desc;

-- Fat Content by Outlet location type for Total Sales

Select Item_Fat_Content,Outlet_Location_Type, round(sum(Sales),2)  As Total_Sales
from blinkit1
group by Item_Fat_Content, Outlet_Location_Type
order by Total_Sales desc;

    SELECT
    Outlet_Location_Type,
    SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Sales ELSE 0 END) AS Low_Fat,
    SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Sales ELSE 0 END) AS Regular
FROM blinkit1
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type DESC;


Select * from blinkit1;

-- Total Sales by Outlet Establishment

Select Outlet_Establishment_Year, round(sum(Sales),2)  As Total_Sales
from blinkit1
group by Outlet_Establishment_Year
order by Total_Sales desc;

 -- Percentage of Sales by Outlet Size
 Select Outlet_Size, sum(Sales) as Total_sales_per_outlet_size,
 round(sum(Sales)/ (Select sum(Sales) as Total_sales from blinkit1)*100,2) as Sales_percentage
 from blinkit1
 group by Outlet_Size;
 
 
 -- Sales by Outlet Location
 
 Select Outlet_Location_Type, sum(Sales) as Total_sales
 from blinkit1
 group by Outlet_Location_Type
 order by Total_sales desc;
 
 -- All Metrics by Outlet Type:
SELECT Outlet_Type, 
SUM(Sales)  AS Total_Sales,
		round(AVG(Sales),2)  AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		round(AVG(Rating),2)  AS Avg_Rating,
		round(AVG(Item_Visibility),2)  AS Avg_Item_Visibility
FROM blinkit1
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;
