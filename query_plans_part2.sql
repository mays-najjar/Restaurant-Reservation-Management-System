-- Query Plans Part 2: Execution plans after adding indexes

USE RestaurantReservationDB;
GO

-- 1. Popular Menu Item
SET SHOWPLAN_TEXT ON;
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
GO
SET SHOWPLAN_TEXT OFF;
GO

-- 2. Restaurant Popularity
SET SHOWPLAN_TEXT ON;
GO
SELECT r.Name AS RestaurantName, COUNT(res.ReservationId) AS ReservationCount,
       RANK() OVER (ORDER BY COUNT(res.ReservationId) DESC) AS PopularityRank
FROM Restaurants r
LEFT JOIN Reservations res ON r.RestaurantId = res.RestaurantId
GROUP BY r.RestaurantId, r.Name
ORDER BY PopularityRank;
GO
SET SHOWPLAN_TEXT OFF;
GO

-- 3. CTE Reservations Orders
SET SHOWPLAN_TEXT ON;
GO
WITH OrderCounts AS (
    SELECT ReservationId, COUNT(*) AS OrderCount
    FROM Orders
    GROUP BY ReservationId
    HAVING COUNT(*) >= 2
)
SELECT r.ReservationId, r.ReservationDate, oc.OrderCount
FROM Reservations r
JOIN OrderCounts oc ON r.ReservationId = oc.ReservationId;
GO
SET SHOWPLAN_TEXT OFF;
GO

-- 4. View Reservations
SET SHOWPLAN_TEXT ON;
GO
SELECT * FROM vw_ReservationsDetails;
GO
SET SHOWPLAN_TEXT OFF;
GO

-- 5. View Employees
SET SHOWPLAN_TEXT ON;
GO
SELECT * FROM vw_EmployeesDetails;
GO
SET SHOWPLAN_TEXT OFF;
GO
