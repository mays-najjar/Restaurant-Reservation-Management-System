-- List of Managers
USE RestaurantReservationDB;
GO

SELECT e.EmployeeId, e.FirstName, e.LastName, r.Name AS RestaurantName
FROM Employees e
JOIN Restaurants r ON e.RestaurantId = r.RestaurantId
WHERE e.Position = 'Manager';
