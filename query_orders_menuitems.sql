-- List of Orders and Menu Items for a specific reservation
-- Parameter: ReservationId (e.g., 78)

USE RestaurantReservationDB;
GO

DECLARE @ReservationId INT = 78;

SELECT o.OrderId, o.OrderDate, o.TotalAmount, mi.Name AS MenuItemName, oi.Quantity
FROM Orders o
JOIN OrderItems oi ON o.OrderId = oi.OrderId
JOIN MenuItems mi ON oi.ItemId = mi.ItemId
WHERE o.ReservationId = @ReservationId;
