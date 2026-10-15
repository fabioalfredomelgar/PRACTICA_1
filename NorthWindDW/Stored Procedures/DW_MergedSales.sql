CREATE PROCEDURE [dbo].[DW_MergedSales]
AS
BEGIN
    UPDATE fs
    SET [OrderDateKey]     = sfs.[OrderDateKey]
        ,[RequiredDateKey] = sfs.[RequiredDateKey]
        ,[ShippedDateKey]  = sfs.[ShippedDateKey]
        ,[CustomerKey]     = sfs.[CustomerKey]
        ,[ProductKey]      = sfs.[ProductKey]
        ,[EmployeeKey]     = sfs.[EmployeeKey]
        ,[ShipperKey]      = sfs.[ShipperKey]
        ,[ShipLocationKey] = sfs.[ShipLocationKey]
        ,[UnitPrice]       = sfs.[UnitPrice]
        ,[Quantity]        = sfs.[Quantity]
        ,[Discount]        = sfs.[Discount]
        ,[AllocatedFreight]= sfs.[AllocatedFreight]
        ,[DaysToShip]      = sfs.[DaysToShip]
        ,[DaysLate]        = sfs.[DaysLate]
    FROM [dbo].[Sales] fs
    INNER JOIN [staging].[sales] sfs ON (fs.[OrderID] = sfs.[OrderID] AND fs.[ProductKey] = sfs.[ProductKey])
END
GO