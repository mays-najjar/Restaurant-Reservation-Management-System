-- Stored Procedure that retrieves all tables which have future reservations

USE RestaurantReservationDB;
GO

CREATE PROCEDURE sp_FutureReservations
AS
BEGIN
    CREATE TABLE #FutureTables (
        TableId INT,
        RestaurantId INT
    );

    INSERT INTO #FutureTables (TableId, RestaurantId)
    SELECT DISTINCT t.TableId, t.RestaurantId
    FROM Tables t
    JOIN Reservations r ON t.TableId = r.TableId
    WHERE r.ReservationDate > GETDATE();

    SELECT ft.TableId, r.Name AS RestaurantName, r.Address AS RestaurantAddress
    FROM #FutureTables ft
    JOIN Restaurants r ON ft.RestaurantId = r.RestaurantId;

    DROP TABLE #FutureTables;
END;
GO

-- Example usage
EXEC sp_FutureReservations;
