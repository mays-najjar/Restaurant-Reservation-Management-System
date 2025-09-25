-- Identify reservations which have 2 or more orders using CTEs

USE RestaurantReservationDB;
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
