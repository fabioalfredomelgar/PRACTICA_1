CREATE PROCEDURE [dbo].[DW_MergeFactSales]
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE f
    SET [OrderDateKey]    = CONVERT(INT, CONVERT(CHAR(8), so.[OrderDate], 112))
       ,[RequiredDateKey] = CONVERT(INT, CONVERT(CHAR(8), so.[RequiredDate], 112))
       ,[ShippedDateKey]  = ISNULL(CONVERT(INT, CONVERT(CHAR(8), so.[ShippedDate], 112)), 19000101)
       ,[CustomerKey]     = dc.[CustomerKey]
       ,[EmployeeKey]     = de.[EmployeeKey]
       ,[ShipperKey]      = dsh.[ShipperKey]
       ,[ShipLocationKey] = dl.[ShipLocationKey]
       ,[UnitPrice]       = so.[UnitPrice]
       ,[Quantity]        = so.[Quantity]
       ,[Discount]        = so.[Discount]
       ,[AllocatedFreight] = so.[AllocatedFreight]
       ,[DaysToShip]      = so.[DaysToShip]
       ,[DaysLate]        = so.[DaysLate]
    FROM [dbo].[FactSales] f
        INNER JOIN [dbo].[DimProduct] dp ON f.[ProductKey] = dp.[ProductKey]
        INNER JOIN [staging].[orders] so ON f.[OrderID] = so.[OrderID] AND dp.[ProductID] = so.[ProductID]
        INNER JOIN [dbo].[DimCustomer] dc ON dc.[CustomerID] = so.[CustomerID]
        INNER JOIN [dbo].[DimEmployee] de ON de.[EmployeeID] = so.[EmployeeID]
        INNER JOIN [dbo].[DimShipper] dsh ON dsh.[ShipperID] = so.[ShipVia]
        INNER JOIN [dbo].[DimShipLocation] dl
            ON dl.[ShipCity] = so.[ShipCity] AND dl.[ShipRegion] = so.[ShipRegion]
           AND dl.[ShipCountry] = so.[ShipCountry] AND dl.[ShipPostalCode] = so.[ShipPostalCode];
END