select * from [dbo].[CustomerSubscription]
----Total Number of Customer from each region------
SELECT Region, COUNT(CustomerID) AS NumberOfCustomers
FROM [dbo].[CustomerSubscription]
GROUP BY Region;

---------- Find the most popular subscription Type by the number of customers-----
SELECT TOP 1 SubscriptionType, COUNT(CustomerID) AS NumberOfCustomers
FROM [dbo].[CustomerSubscription]
GROUP BY SubscriptionType
ORDER BY NumberOfCustomers DESC

--------- Find Customers who cancelled their subscription within 6 months---------
SELECT CustomerID, CustomerName, Region, SubscriptionType, SubscriptionStart, SubscriptionEnd, Canceled, Revenue,
       DATEDIFF(day, SubscriptionStart, SubscriptionEnd) AS DaysDifference
FROM [dbo].[CustomerSubscription]
WHERE Canceled = 1;

SELECT CustomerID, CustomerName, Region, SubscriptionType, SubscriptionStart, SubscriptionEnd, Canceled, Revenue
FROM [dbo].[CustomerSubscription]
WHERE Canceled = 1
  AND DATEDIFF(day, SubscriptionStart, SubscriptionEnd) <= 180;

-----------Calculate the average subscription duration for all customers-----
SELECT AVG(DATEDIFF(day, SubscriptionStart, SubscriptionEnd)) AS AverageSubscriptionDuration
FROM [dbo].[CustomerSubscription];

-----------Find Customers with subscription longer than 12 months----

SELECT CustomerID, CustomerName, Region, SubscriptionType, SubscriptionStart, SubscriptionEnd, Canceled, Revenue
FROM [dbo].[CustomerSubscription]
WHERE DATEDIFF(month, SubscriptionStart, SubscriptionEnd) > 12;

----------------- Calculate Total Revenue by subscription Type-----
SELECT SubscriptionType, SUM(Revenue) AS TotalRevenue
FROM [dbo].[CustomerSubscription]
GROUP BY SubscriptionType;

----- Find the top 3 regions by subscription Cancellation------
SELECT TOP 3 Region, COUNT(CustomerID) AS CancellationCount
FROM [dbo].[CustomerSubscription]
WHERE Canceled = 1
GROUP BY Region
ORDER BY CancellationCount DESC

----------Find the total Number of Active and cancelled subscriptions------
SELECT 
    SUM(CASE WHEN Canceled = 0 THEN 1 ELSE 0 END) AS ActiveSubscriptions,
    SUM(CASE WHEN Canceled = 1 THEN 1 ELSE 0 END) AS CanceledSubscriptions
FROM [dbo].[CustomerSubscription];