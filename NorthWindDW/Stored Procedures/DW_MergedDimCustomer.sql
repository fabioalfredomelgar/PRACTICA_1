CREATE PROCEDURE [dbo].[DW_MergedDimCustomer]
AS
BEGIN
    UPDATE dc
    SET [CustomerID]   = sc.[CustomerID]
        ,[CompanyName] = sc.[CompanyName]
        ,[ContactName] = sc.[ContactName]
        ,[ContactTitle]= sc.[ContactTitle]
        ,[Address]     = sc.[Address]
        ,[City]        = sc.[City]
        ,[Region]      = sc.[Region]
        ,[PostalCode]  = sc.[PostalCode]
        ,[Country]     = sc.[Country]
        ,[Phone]       = sc.[Phone]
        ,[Fax]         = sc.[Fax]
    FROM [dbo].[DimCustomer] dc
    INNER JOIN [staging].[customer] sc ON (dc.[CustomerKey] = sc.[CustomerKey])
END
GO