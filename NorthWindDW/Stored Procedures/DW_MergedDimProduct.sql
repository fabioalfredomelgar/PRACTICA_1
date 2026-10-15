CREATE PROCEDURE [dbo].[DW_MergedDimProduct]
AS
BEGIN
    UPDATE dp
    SET [ProductID]           = sp.[ProductID]
        ,[ProductName]        = sp.[ProductName]
        ,[QuantityPerUnit]    = sp.[QuantityPerUnit]
        ,[CurrentListPrice]   = sp.[CurrentListPrice]
        ,[Discontinued]       = sp.[Discontinued]
        ,[CategoryID]         = sp.[CategoryID]
        ,[CategoryName]       = sp.[CategoryName]
        ,[CategoryDescription]= sp.[CategoryDescription]
        ,[SupplierID]         = sp.[SupplierID]
        ,[SupplierCompanyName]= sp.[SupplierCompanyName]
        ,[SupplierContactName]= sp.[SupplierContactName]
        ,[SupplierCity]       = sp.[SupplierCity]
        ,[SupplierCountry]    = sp.[SupplierCountry]
    FROM [dbo].[DimProduct] dp
    INNER JOIN [staging].[product] sp ON (dp.[ProductKey] = sp.[ProductKey])
END
GO