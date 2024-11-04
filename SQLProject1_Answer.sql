select * from [dbo].[LITA Capstone DatasetSQL]
-----------Add Total Sales Column---------
ALTER TABLE [dbo].[LITA Capstone DatasetSQL] ADD Total_Sales AS ( Quantity * UnitPrice);

------------Retrive the Total Sales for each product------
SELECT Product, SUM(Total_Sales) AS TotalSalesAmount
FROM [dbo].[LITA Capstone DatasetSQL]
GROUP BY Product;

--------Sales Transaction in each region-----------
SELECT Region, COUNT(*) AS NumberOfSales
FROM [dbo].[LITA Capstone DatasetSQL]
GROUP BY Region;

-------Find the highest selling product by Total Sales Value-----
SELECT TOP 1 Product, SUM(Total_Sales) AS TotalSalesAmount
FROM [dbo].[LITA Capstone DatasetSQL]
GROUP BY Product
ORDER BY TotalSalesAmount DESC
;
------- Calculate Total Revenue Per Product----
SELECT Product, SUM(Quantity * UnitPrice) AS TotalRevenue
FROM [dbo].[LITA Capstone DatasetSQL]
GROUP BY Product;

-----calculate Monthly sales Totals for the current Year ------
SELECT 
    MONTH(OrderDate) AS Month, 
    SUM(Total_Sales) AS MonthlySalesTotal
FROM [dbo].[LITA Capstone DatasetSQL]
WHERE YEAR(OrderDate) = 2024
GROUP BY MONTH(OrderDate)
ORDER BY Month;

----Find The Top5 CUSTOMERS by Total Purchase Amount----
SELECT TOP 5 Customer_Id, SUM(Total_Sales) AS TotalPurchaseAmount
FROM [dbo].[LITA Capstone DatasetSQL]
GROUP BY Customer_Id
ORDER BY TotalPurchaseAmount DESC;

------Calculate the percentage of total sales contributed by each region----
SELECT 
    Region, 
    SUM(Total_Sales) AS RegionTotalSales, 
    (SUM(Total_Sales) * 100.0 / NULLIF((SELECT SUM(Total_Sales) FROM [dbo].[LITA Capstone DatasetSQL]), 0)) AS SalesPercentage
FROM [dbo].[LITA Capstone DatasetSQL]
GROUP BY Region
ORDER BY SalesPercentage DESC;

------identify product with no sales in the last quarter------
SELECT DISTINCT p.Product
FROM (SELECT DISTINCT Product FROM [dbo].[LITA Capstone DatasetSQL]) p
LEFT JOIN [dbo].[LITA Capstone DatasetSQL] s ON p.Product = s.Product 
  AND s.OrderDate >= '2024-07-01' -- Start of the last quarter (Q3 2024)
  AND s.OrderDate < '2024-10-01'  -- Start of the current quarter (Q4 2024)
WHERE s.Product IS NULL;