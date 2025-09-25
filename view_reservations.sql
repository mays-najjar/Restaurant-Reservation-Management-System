-- View for Reservations with Restaurants and Customers

USE RestaurantReservationDB;
GO

CREATE VIEW vw_ReservationsDetails AS
SELECT r.ReservationId, r.ReservationDate, r.PartySize,
       rest.Name AS RestaurantName, rest.Address AS RestaurantAddress,
       c.FirstName + ' ' + c.LastName AS CustomerName, c.Email AS CustomerEmail
FROM Reservations r
JOIN Restaurants rest ON r.RestaurantId = rest.RestaurantId
JOIN Customers c ON r.CustomerId = c.CustomerId;
GO

-- To use the view
SELECT * FROM vw_ReservationsDetails;
