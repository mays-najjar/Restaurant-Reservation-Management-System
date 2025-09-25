-- Function to compute the salary for a given employee

USE RestaurantReservationDB;
GO

CREATE FUNCTION fn_CalculateEmployeeSalary (@EmployeeId INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Salary DECIMAL(10,2) = 0;
    DECLARE @Position NVARCHAR(50);
    DECLARE @OrderCount INT;

    SELECT @Position = Position FROM Employees WHERE EmployeeId = @EmployeeId;
    SELECT @OrderCount = COUNT(*) FROM Orders WHERE EmployeeId = @EmployeeId;

    IF @Position = 'VIPOrdersWaiter' SET @Salary = @OrderCount * 5;
    ELSE IF @Position = 'StandardWaiter' SET @Salary = @OrderCount * 4;
    ELSE IF @Position = 'AssistantWaiter' SET @Salary = @OrderCount * 3;
    ELSE SET @Salary = 0;  

    RETURN @Salary;
END;
GO

-- Example usage
SELECT dbo.fn_CalculateEmployeeSalary(1) AS Salary;
