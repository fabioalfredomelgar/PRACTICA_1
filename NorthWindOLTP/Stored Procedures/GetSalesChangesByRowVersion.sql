CREATE PROCEDURE [dbo].[GetSalesChangesByRowVersion]
(
    @startRow BIGINT,
    @endRow   BIGINT
)
AS
BEGIN
    SET NOCOUNT ON;

    -- CTE para calcular cuántos productos (líneas) tiene cada orden y así prorratear el flete
    WITH OrderLinesCTE AS (
        SELECT 
            [OrderID],
            COUNT(1) AS [TotalLines]
        FROM [dbo].[Order Details]
        GROUP BY [OrderID]
    )
    SELECT 
         -- Claves operativas del OLTP para mapear contra tus dimensiones en el ETL
         o.[OrderDate]
        ,o.[RequiredDate]
        ,o.[ShippedDate]
        ,o.[CustomerID]
        ,d.[ProductID]
        ,o.[EmployeeID]
        ,o.[ShipVia]                                      AS [ShipperID]
        ,ISNULL(o.[ShipCity], N'Unknown')                 AS [ShipCity]
        ,ISNULL(o.[ShipRegion], N'Unknown')               AS [ShipRegion]
        ,ISNULL(o.[ShipCountry], N'Unknown')              AS [ShipCountry]
        ,ISNULL(o.[ShipPostalCode], N'Unknown')           AS [ShipPostalCode]
        
         -- Métricas base requeridas por tu FactSales
        ,o.[OrderID]                                      AS [OrderID]
        ,d.[UnitPrice]                                    AS [UnitPrice]
        ,d.[Quantity]                                     AS [Quantity]
        ,CONVERT(DECIMAL(5,4), d.[Discount])              AS [Discount]
        
         -- Cálculo del flete asignado por línea de producto
        ,CONVERT(DECIMAL(18,2), ISNULL(o.[Freight], 0) / l.[TotalLines]) AS [AllocatedFreight]
        
         -- Columnas opcionales para facilitar tus campos DaysToShip y DaysLate en el DW
        ,DATEDIFF(day, o.[OrderDate], o.[ShippedDate])    AS [DaysToShip]
        ,CASE 
            WHEN o.[ShippedDate] > o.[RequiredDate] THEN DATEDIFF(day, o.[RequiredDate], o.[ShippedDate])
            ELSE 0 
         END                                              AS [DaysLate]
    FROM [dbo].[Orders] o
    INNER JOIN [dbo].[Order Details] d ON o.[OrderID] = d.[OrderID]
    INNER JOIN OrderLinesCTE l ON o.[OrderID] = l.[OrderID]
    WHERE (o.[rowversion] > CONVERT(ROWVERSION, @startRow) AND o.[rowversion] <= CONVERT(ROWVERSION, @endRow))
       OR (d.[rowversion] > CONVERT(ROWVERSION, @startRow) AND d.[rowversion] <= CONVERT(ROWVERSION, @endRow));
END
GO