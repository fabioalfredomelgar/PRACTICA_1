CREATE PROCEDURE [dbo].[DW_MergeDimProduct]
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dp
    SET [ProductName]         = sp.[ProductName]
       ,[QuantityPerUnit]     = sp.[QuantityPerUnit]
       ,[CurrentListPrice]    = sp.[CurrentListPrice]
       ,[Discontinued]        = sp.[Discontinued]
       ,[CategoryID]          = sp.[CategoryID]
       ,[CategoryName]        = sp.[CategoryName]
       ,[CategoryDescription] = sp.[CategoryDescription]
       ,[SupplierID]          = sp.[SupplierID]
       ,[SupplierCompanyName] = sp.[SupplierCompanyName]
       ,[SupplierContactName] = sp.[SupplierContactName]
       ,[SupplierCity]        = sp.[SupplierCity]
       ,[SupplierCountry]     = sp.[SupplierCountry]
    FROM [dbo].[DimProduct] dp
        INNER JOIN [staging].[product] sp ON dp.[ProductID] = sp.[ProductID];
END