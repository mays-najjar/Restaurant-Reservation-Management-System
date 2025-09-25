-- Stored Procedure to generate report of tables reserved within a specified date range

USE RestaurantReservationDB;
GO

CREATE PROCEDURE sp_ResrvedTablesReport
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    SELECT r.ReservationId, r.ReservationDate, r.PartySize,
           rest.Name AS RestaurantName, rest.Address AS RestaurantAddress
    FROM Reservations r
    JOIN Restaurants rest ON r.RestaurantId = rest.RestaurantId
    WHERE r.ReservationDate BETWEEN @StartDate AND @EndDate;
END;
GO

-- Example usage
EXEC sp_ResrvedTablesReport '2023-01-01', '2023-12-31';
