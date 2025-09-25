-- List of Reservations for a specific customer
-- Parameter: CustomerId (e.g., 1)

USE RestaurantReservationDB;
GO

DECLARE @CustomerId INT = 1;

SELECT r.ReservationId, r.ReservationDate, r.PartySize, rest.Name AS RestaurantName, t.Capacity AS TableCapacity
FROM Reservations r
JOIN Restaurants rest ON r.RestaurantId = rest.RestaurantId
JOIN Tables t ON r.TableId = t.TableId
WHERE r.CustomerId = @CustomerId;
