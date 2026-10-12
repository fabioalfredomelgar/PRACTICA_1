IF NOT EXISTS (SELECT 1 FROM [dbo].[PackageConfig] WHERE [TableName] = N'Customers')
    INSERT INTO [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES (N'Customers', 0);

IF NOT EXISTS (SELECT 1 FROM [dbo].[PackageConfig] WHERE [TableName] = N'Employees')
    INSERT INTO [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES (N'Employees', 0);

IF NOT EXISTS (SELECT 1 FROM [dbo].[PackageConfig] WHERE [TableName] = N'Products')
    INSERT INTO [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES (N'Products', 0);