-- Calculate Average Order Amount made through a specific employee
-- Parameter: EmployeeId (e.g., 1)

USE RestaurantReservationDB;
GO

DECLARE @EmployeeId INT = 1;

SELECT AVG(TotalAmount) AS AverageOrderAmount
FROM Orders
WHERE EmployeeId = @EmployeeId;
