-- View for Employees with Restaurants

USE RestaurantReservationDB;
GO

CREATE VIEW vw_EmployeesDetails AS
SELECT e.EmployeeId, e.FirstName + ' ' + e.LastName AS EmployeeName, e.Position,
       r.Name AS RestaurantName, r.Address AS RestaurantAddress
FROM Employees e
JOIN Restaurants r ON e.RestaurantId = r.RestaurantId;
GO

-- To use the view
USE RestaurantReservationDB;
GO
SELECT * FROM vw_EmployeesDetails;
