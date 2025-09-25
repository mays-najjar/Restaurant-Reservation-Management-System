-- List of Ordered Menu Items for a specific reservation
-- Parameter: ReservationId (e.g., 1)

USE RestaurantReservationDB;
GO

DECLARE @ReservationId INT = 1;

SELECT DISTINCT mi.ItemId, mi.Name, mi.Description, mi.Price
FROM Orders o
JOIN OrderItems oi ON o.OrderId = oi.OrderId
JOIN MenuItems mi ON oi.ItemId = mi.ItemId
WHERE o.ReservationId = @ReservationId;
