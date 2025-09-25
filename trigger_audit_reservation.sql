-- Trigger to log an entry into AuditLog table whenever a table gets reserved

USE RestaurantReservationDB;
GO

CREATE TRIGGER trg_AuditReservation
ON Reservations
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditLog (RestaurantId, TableId, ReservationDate, ChangeDate)
    SELECT i.RestaurantId, i.TableId, i.ReservationDate, GETDATE()
    FROM inserted i;
END;
GO
