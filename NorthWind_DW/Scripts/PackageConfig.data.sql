IF NOT EXISTS (SELECT 1 FROM [dbo].[PackageConfig] WHERE [TableName] = N'Customers')
    INSERT INTO [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES (N'Customers', 0);

IF NOT EXISTS (SELECT 1 FROM [dbo].[PackageConfig] WHERE [TableName] = N'Employees')
    INSERT INTO [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES (N'Employees', 0);

IF NOT EXISTS (SELECT 1 FROM [dbo].[PackageConfig] WHERE [TableName] = N'Products')
    INSERT INTO [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES (N'Products', 0);

IF NOT EXISTS (SELECT 1 FROM [dbo].[PackageConfig] WHERE [TableName] = N'Shippers')
    INSERT INTO [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES (N'Shippers', 0);

IF NOT EXISTS (SELECT 1 FROM [dbo].[PackageConfig] WHERE [TableName] = N'Orders')
    INSERT INTO [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES (N'Orders', 0);

IF NOT EXISTS (SELECT 1 FROM [dbo].[PackageConfig] WHERE [TableName] = N'ShipLocations')
    INSERT INTO [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES (N'ShipLocations', 0);