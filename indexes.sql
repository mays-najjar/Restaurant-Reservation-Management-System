-- Create Indexes to optimize queries

USE RestaurantReservationDB;
GO

-- Index on Reservations for customer queries
CREATE INDEX idx_Reservations_CustomerId ON Reservations(CustomerId);

-- Index on Employees for position queries
CREATE INDEX idx_Employees_Position ON Employees(Position);

-- Index on Orders for reservation and employee
CREATE INDEX idx_Orders_ReservationId ON Orders(ReservationId);
CREATE INDEX idx_Orders_EmployeeId ON Orders(EmployeeId);

-- Index on OrderItems for item queries
CREATE INDEX idx_OrderItems_ItemId ON OrderItems(ItemId);

-- Index on MenuItems for restaurant
CREATE INDEX idx_MenuItems_RestaurantId ON MenuItems(RestaurantId);

-- Index on Reservations for date range queries
CREATE INDEX idx_Reservations_Date ON Reservations(ReservationDate);

-- Index on Orders for date
CREATE INDEX idx_Orders_Date ON Orders(OrderDate);
