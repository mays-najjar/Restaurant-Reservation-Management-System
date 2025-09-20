# Restaurant Reservation Management System Database

This repository contains the complete SQL scripts for designing and implementing a relational database for a Restaurant Reservation Management System using MS SQL Server.

## 📋 Project Overview

The system manages restaurants, menu items, orders, reservations, employees, customers, and tables. It supports various queries, procedures, functions, and triggers for efficient operations.

## 🗄️ Database Design

### Entity Relationship Diagram (ERD)

**📊 Visual ER Diagram Files:**
- `restaurant_erd.png` - High-resolution PNG image

**📝 Detailed Documentation:**
- `ER_Diagram.md` - Comprehensive ER diagram documentation with:
  - Complete entity specifications with data types
  - Business rules and constraints
  - Cardinality and participation details
  - Key specifications (Primary/Foreign keys)
  - Implementation notes

### Database Schema

The database consists of 9 main entities:

1. **Restaurants** - Restaurant information and details
2. **MenuItems** - Food and beverage items offered
3. **Customers** - Customer contact and profile information
4. **Tables** - Restaurant table configurations
5. **Reservations** - Customer reservations with table assignments
6. **Employees** - Restaurant staff information
7. **Orders** - Customer orders linked to reservations
8. **OrderItems** - Individual items within orders
9. **AuditLog** - Audit trail for reservation changes

### Key Features

- **Comprehensive Constraints**: Data integrity through CHECK, UNIQUE, and NOT NULL constraints
- **Business Logic**: Employee salary calculation based on position and order count
- **Audit Trail**: Automatic logging of all reservation changes
- **Performance Optimization**: Strategic indexing for query performance
- **Data Validation**: Server-side validation for all business rules

## 📁 File Structure

```
├── schema.sql                    # Database schema creation
├── seed.sql                      # Data seeding scripts
├── ER_Diagram.md                 # Detailed ER diagram documentation
├── restaurant_erd.drawio         # Visual ER diagram (Draw.io format)
├── restaurant_erd.png            # Visual ER diagram (PNG format)
├── restaurant_erd.pdf            # Visual ER diagram (PDF format)
├── README.md                     # This file
├── TODO.md                       # Project task tracking
│
├── Functions/
│   ├── fn_CalculateRevenue.sql   # Restaurant revenue calculation
│   └── fn_CalculateEmployeeSalary.sql # Employee salary calculation
│
├── Stored Procedures/
│   ├── sp_AddNewOrder.sql        # Add new orders
│   ├── sp_ResrvedTablesReport.sql # Reserved tables report
│   └── sp_FutureReservations.sql # Future reservations query
│
├── Views/
│   ├── view_employees.sql        # Employee details with restaurant info
│   └── view_reservations.sql     # Reservation details with customer info
│
├── Triggers/
│   └── trigger_audit_reservation.sql # Audit log trigger
│
├── Complex Queries/
│   ├── query_reservations_customer.sql # Customer reservations
│   ├── query_managers.sql        # Manager employees
│   ├── query_orders_menuitems.sql # Orders with menu items
│   ├── query_ordered_menuitems.sql # Menu items by reservation
│   ├── query_avg_order_amount.sql # Average order by employee
│   ├── query_restaurant_popularity.sql # Restaurant popularity ranking
│   ├── query_popular_menuitem.sql # Popular menu items analysis
│   └── cte_reservations_orders.sql # Reservations with multiple orders
│
└── Performance/
    ├── indexes.sql               # Database indexes
    ├── query_plans_part1.sql     # Query plans before indexing
    └── query_plans_part2.sql     # Query plans after indexing
```

## 🚀 Setup Instructions

### Prerequisites
- Microsoft SQL Server (2019 or later recommended)
- SQL Server Management Studio (SSMS)



### Business Rules Implemented

1. **Employee Salary Calculation:**
   - VIPOrdersWaiter: Orders × 5
   - StandardWaiter: Orders × 4
   - AssistantWaiter: Orders × 3
   - Manager: Fixed salary

2. **Reservation Constraints:**
   - Party size ≤ table capacity
   - Future reservation dates only
   - No double-booking of tables

3. **Order Validation:**
   - Orders linked to active reservations
   - Menu items must be available
   - Calculated totals from order items

### Advanced SQL Features

- **Stored Procedures:** For complex business operations
- **User-Defined Functions:** For calculations and validations
- **Views:** For simplified data access
- **Triggers:** For automatic audit logging
- **CTEs:** For complex hierarchical queries
- **Window Functions:** For analytics and ranking
- **Indexing:** For optimal query performance

## 📈 Performance Optimization

- **Strategic Indexing:** On foreign keys and frequently queried columns
- **Query Plan Analysis:** Before and after indexing comparison
- **Composite Indexes:** For multi-column query optimization
- **Full-Text Search:** On menu item names and descriptions

## 🔍 Sample Queries

### Popular Menu Items Analysis
```sql
-- Identify most popular menu items per restaurant per month
SELECT * FROM query_popular_menuitem;
```

### Restaurant Popularity Ranking
```sql
-- Rank restaurants by reservation frequency
SELECT * FROM query_restaurant_popularity;
```

### Employee Performance
```sql
-- Calculate employee salary based on orders handled
SELECT EmployeeId, dbo.fn_CalculateEmployeeSalary(EmployeeId) AS Salary
FROM Employees;
```

## 📝 Implementation Notes

1. **Data Integrity:** All relationships properly enforced with foreign keys
2. **Audit Trail:** Automatic logging of reservation changes
3. **Soft Deletes:** Important entities use IsActive flags
4. **Calculated Fields:** Order totals computed from line items
5. **Business Logic:** Complex rules in stored procedures
6. **Performance:** Optimized with appropriate indexes


## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is for educational purposes. Please ensure proper attribution when using the code.
