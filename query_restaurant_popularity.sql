-- Rank restaurants by the reservation frequency

USE RestaurantReservationDB;
GO

SELECT r.Name AS RestaurantName, COUNT(res.ReservationId) AS ReservationCount,
       RANK() OVER (ORDER BY COUNT(res.ReservationId) DESC) AS PopularityRank
FROM Restaurants r
LEFT JOIN Reservations res ON r.RestaurantId = res.RestaurantId
GROUP BY r.RestaurantId, r.Name
ORDER BY PopularityRank;
