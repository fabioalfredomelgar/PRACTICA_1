
:r .\Clean.data.sql
:r .\Region.data.sql
:r .\Categories.data.sql
:r .\Shippers.data.sql
:r .\Suppliers.data.sql
:r .\Customers.data.sql
:r .\Territories.data.sql
ALTER TABLE [dbo].[Employees] NOCHECK CONSTRAINT [FK_Employees_Employees];
:r .\Employees.data.sql
ALTER TABLE [dbo].[Employees] NOCHECK CONSTRAINT [FK_Employees_Employees];
:r .\Products.data.sql
:r .\EmployeeTerritories.data.sql
:r .\Orders.data.sql
:r .\OrderDetails.data.sql
-- :r .\CustomerCustomerDemo.data.sql
-- :r .\CustomerDemographics.data.sql
