-- Stored Procedure to add a new order

USE RestaurantReservationDB;
GO

CREATE PROCEDURE sp_AddNewOrder
    @ReservationId INT,
    @EmployeeId INT,
    @OrderDate DATETIME,
    @TotalAmount DECIMAL(10,2)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Reservations WHERE ReservationId = @ReservationId)
    BEGIN
        RAISERROR('Reservation does not exist.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Employees WHERE EmployeeId = @EmployeeId)
    BEGIN
        RAISERROR('Employee does not exist.', 16, 1);
        RETURN;
    END

    INSERT INTO Orders (ReservationId, EmployeeId, OrderDate, TotalAmount)
    VALUES (@ReservationId, @EmployeeId, @OrderDate, @TotalAmount);

    SELECT SCOPE_IDENTITY() AS NewOrderId;
END;
GO

-- Example usage
EXEC sp_AddNewOrder 1, 1, '2023-01-01 12:00:00', 100.00;
