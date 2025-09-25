-- Identify the most popular menu item for each restaurant for a given month
-- Parameter: Month (e.g., 1 for January)

USE RestaurantReservationDB;
GO

DECLARE @Month INT = 1;

WITH ItemCounts AS (
    SELECT mi.RestaurantId, mi.ItemId, mi.Name, SUM(oi.Quantity) AS TotalQuantity,
           ROW_NUMBER() OVER (PARTITION BY mi.RestaurantId ORDER BY SUM(oi.Quantity) DESC) AS RowNum
    FROM MenuItems mi
    JOIN OrderItems oi ON mi.ItemId = oi.ItemId
    JOIN Orders o ON oi.OrderId = o.OrderId
    WHERE MONTH(o.OrderDate) = @Month
    GROUP BY mi.RestaurantId, mi.ItemId, mi.Name
)
SELECT ic.RestaurantId, ic.ItemId, ic.Name, ic.TotalQuantity
FROM ItemCounts ic
WHERE ic.RowNum = 1;
