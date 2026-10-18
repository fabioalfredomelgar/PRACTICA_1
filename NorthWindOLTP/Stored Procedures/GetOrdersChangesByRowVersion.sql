CREATE PROCEDURE [dbo].[GetOrdersChangesByRowVersion]
(
    @startRow BIGINT,
    @endRow BIGINT
)
AS
BEGIN
    SELECT od.[OrderID]
        ,od.[ProductID]
        ,o.[CustomerID]
        ,o.[EmployeeID]
        ,o.[ShipVia]
        ,[OrderDate]    = CONVERT(DATE, o.[OrderDate])
        ,[RequiredDate] = CONVERT(DATE, o.[RequiredDate])
        ,[ShippedDate]  = CONVERT(DATE, o.[ShippedDate])
        ,[ShipCity]       = ISNULL(o.[ShipCity], N'Unknown')
        ,[ShipRegion]     = ISNULL(o.[ShipRegion], N'Unknown')
        ,[ShipCountry]    = ISNULL(o.[ShipCountry], N'Unknown')
        ,[ShipPostalCode] = ISNULL(o.[ShipPostalCode], N'Unknown')
        ,[UnitPrice] = CONVERT(DECIMAL(18,2), od.[UnitPrice])
        ,od.[Quantity]
        ,[Discount] = CONVERT(DECIMAL(5,4), od.[Discount])
        ,[AllocatedFreight] = CONVERT(DECIMAL(18,2),
            ISNULL(o.[Freight], 0) *
            (od.[UnitPrice] * od.[Quantity] * (1 - od.[Discount])) /
            NULLIF(SUM(od.[UnitPrice] * od.[Quantity] * (1 - od.[Discount]))
                   OVER (PARTITION BY od.[OrderID]), 0))
        ,[DaysToShip] = DATEDIFF(DAY, o.[OrderDate], o.[ShippedDate])
        ,[DaysLate]   = DATEDIFF(DAY, o.[RequiredDate], o.[ShippedDate])
    FROM [dbo].[OrderDetails] od
        INNER JOIN [dbo].[Orders] o ON od.[OrderID] = o.[OrderID]
    WHERE (od.[rowversion] > CONVERT(ROWVERSION, @startRow) AND od.[rowversion] <= CONVERT(ROWVERSION, @endRow))
       OR (o.[rowversion]  > CONVERT(ROWVERSION, @startRow) AND o.[rowversion]  <= CONVERT(ROWVERSION, @endRow))
END