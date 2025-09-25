-- Function to compute revenue made by a specific restaurant

USE RestaurantReservationDB;
GO

CREATE FUNCTION fn_CalculateRevenue (@RestaurantId INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Revenue DECIMAL(10,2);
    SELECT @Revenue = SUM(o.TotalAmount)
    FROM Orders o
    JOIN Reservations r ON o.ReservationId = r.ReservationId
    WHERE r.RestaurantId = @RestaurantId;
    RETURN ISNULL(@Revenue, 0);
END;
GO

-- Example usage
SELECT dbo.fn_CalculateRevenue(1) AS Revenue;
