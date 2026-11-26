Create database Project_Data
use Project_Data
CREATE TABLE Customers(
Customer_ID INT PRIMARY KEY,
Customer_Name VARCHAR(100),
Gender VARCHAR(10),
Age INT,
City VARCHAR(50),
Region VARCHAR(20));

CREATE TABLE Products(
Product_ID INT PRIMARY KEY,
Product_Name VARCHAR(100),
Category VARCHAR(50),
Price DECIMAL(10,2));

CREATE TABLE Sales(
Sale_ID INT PRIMARY KEY,
Customer_ID INT,
Product_ID INT,
Quantity INT,
Sale_Date DATE,
FOREIGN KEY(Customer_ID) REFERENCES Customers(Customer_ID),
FOREIGN KEY(Product_ID) REFERENCES Products(Product_ID));

select * from Customers
select * from Products
select * from Sales

select count(*) from Customers
select count(*) from Products
select count(*) from Sales

select top 10 * from Customers
select top 10 * from Products
select top 10 * from Sales

select count(*) as Total_Count
from Sales

SELECT 'Customers' AS Table_Name, COUNT(*) AS Total_Records
FROM Customers
UNION ALL
SELECT 'Products', COUNT(*)
FROM Products
UNION ALL
SELECT 'Sales', COUNT(*)
FROM Sales;

-- Check Duplicate Values--

select customer_id, count(*) as Total_Customers
from Customers
group by Customer_ID
having count(*) > 1;

select Product_Id, count(*) as Total_Products
from Products
group by Product_ID
having count(*) > 1;

select Sale_id, count(*) as Total_Sales
from Sales
group by Sale_Id
having count(*) > 1;

select * from Sales 
select * from Products
select * from Customers

--To find missing Id's--

select s.* from sales s
left join Customers c
on s.Customer_ID = c.Customer_ID
where c.Customer_ID is null

select s.* from sales s
left join Products p
on s.Product_ID = p.Product_ID
where p.Product_ID is null

-- Checking Null Values --

select * from Customers
where Customer_ID is null
or Customer_Name is null 
or Gender is null
or age is null
or City is null
or Region is null

select * from Products
where Product_ID is null
or Product_Name is null
or Category is null
or Price is null

Select * from Sales
where Sale_ID is null 
or Customer_ID is null
or Product_ID is null
or Quantity is null
or Sale_ID is null

--Checking Invalid data--

select * from Customers
where age < 1 or age > 100;

select * from Products
where price < 0;

select * from Sales
where Quantity < 0;

Select * from Sales
Where Sale_Date > Cast(GETDATE() AS DATE);


select * from Customers
select * from Products
select * from Sales

--Total Revenue--

Select sum(cast(s.Quantity as bigint) * p.price) as Total_Revenue
from Sales s
inner join Products p
on s.Product_ID = p.Product_ID

--Category Wise Revenue--

Select p.Category,
       sum(cast(s.Quantity as bigint) * p.price) as Total_Revenue
from Sales s
Inner Join Products p
on s.Product_ID = p.Product_ID
group by p.Category
order by Total_Revenue Desc;

--Top 5 Categories--

Select top 5 p.Category,
       sum(cast(s.Quantity as bigint) * p.price) as Total_Revenue
from Sales s
Inner Join Products p
on s.Product_ID = p.Product_ID
group by p.Category
order by Total_Revenue Desc;

--Customer Segmentation--

with CustomerRevenue as (
   select c.Customer_ID, c.Customer_Name,
         sum(cast(s.Quantity as bigint) * p.price) as Total_Revenue
   from Customers c
   Inner Join Sales s
   on c.Customer_ID = s.Customer_ID
   Inner join Products p
   on s.Product_ID = p.Product_ID
   group by c.Customer_ID, c.Customer_Name
),
CustomerRanking as (
    Select *,
    NTILE(3) over(order by Total_Revenue Desc) as Revenue_Group
    from CustomerRevenue
)
select Customer_ID, Customer_Name, Total_Revenue,
case
    when Revenue_Group = 1 then 'High'
    when Revenue_Group = 2 then 'Medium'
    else 'Low'
    end as Customer_Segment
from CustomerRanking
Order by Total_Revenue desc;

--Top 3 Customers in Each region--

with CustomerRevenue as (
Select c.customer_ID, c.Customer_Name, c.Region,
      sum(cast(s.Quantity as bigint) * p.Price) as Total_Revenue
from Customers c
Inner join Sales s
on c.Customer_ID = s.Customer_ID
Inner Join Products p
on s.Product_ID = p.Product_ID
group by c.Customer_ID, c.Customer_Name, c.Region
),
CustomerRanking as (
  select *,
   rank() over(Partition by Region order by Total_revenue desc) as Customer_Rank
   from CustomerRevenue
)
Select Customer_ID,
       Customer_Name,
       Region,
       Total_Revenue,
       Customer_Rank
from CustomerRanking
where Customer_Rank <= 3
order by Region, Customer_Rank;

select * from Customers
select * from Products
select * from Sales

--Monthly Sales Analysis by City--

select c.City,       
       YEAR(s.Sale_Date) as Yearly_Sales,
       MONTH(s.Sale_Date) as Monthly_Sales,
       sum(cast(s.Quantity as bigint) * p.price) as Total_Revenue
from Sales s
Inner Join Products p
on s.Product_ID = p.Product_ID
Inner Join Customers c
on s.Customer_ID = c.Customer_ID
group by c.City,
         YEAR(s.Sale_Date),
         MONTH(s.Sale_Date)
    
order by Yearly_Sales,
         Monthly_Sales,
         Total_Revenue desc
         

