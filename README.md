# Customer Sales Analysis using SQL Server

## Project Overview
This project analyzes customer sales data using Microsoft SQL Server to identify revenue trends, top-performing product categories, and valuable customer segments.

## Dataset Details

The project contains three tables:

| Table | Description |
|---|---|
| Customers | Customer details, city, and region |
| Products | Product names, categories, and prices |
| Sales | Sales transactions, quantities, and dates |

**Records:**
- Customers: 500
- Products: 45
- Sales: 10,000

## SQL Concepts Used
- INNER JOIN
- GROUP BY
- Aggregate Functions (SUM)
- Common Table Expressions (CTEs)
- CASE WHEN
- Window Functions (NTILE, RANK)
- YEAR() and MONTH()
- ORDER BY

## Analysis Performed

1. Overall Revenue Analysis
2. Category-wise Revenue Analysis
3. Top 5 Revenue-generating Categories
4. Customer Segmentation (High, Medium, Low)
5. Top 3 Customers by Region
6. Monthly Sales Analysis by City

## Key Business Insights

- Total revenue generated: 1,155,631,886
- Electronics is the highest revenue-generating category.
- The top 5 categories contribute approximately 66.8% of total revenue.
- Customers were divided into three revenue-based segments using NTILE(3).
- The top 3 customers were identified separately for each region.

## Tools Used
- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- GitHub

## Project Files
- `Customer_Sales_Analysis_1.sql` – Complete SQL queries used for analysis.

## Author
Vikas D A
