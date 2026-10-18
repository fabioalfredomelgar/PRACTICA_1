CREATE PROCEDURE [dbo].[GetDimShipLocationChangesByRowVersion]
(
    @startRow BIGINT,
    @endRow   BIGINT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT
         -- Usamos ISNULL para evitar nulos y alinearnos con los valores 'Unknown' de tus restricciones DEFAULT
         ISNULL([ShipCity], N'Unknown')       AS [ShipCity]
        ,ISNULL([ShipRegion], N'Unknown')     AS [ShipRegion]
        ,ISNULL([ShipCountry], N'Unknown')    AS [ShipCountry]
        ,ISNULL([ShipPostalCode], N'Unknown') AS [ShipPostalCode]
    FROM [dbo].[Orders]
    WHERE [rowversion] > CONVERT(ROWVERSION, @startRow)
      AND [rowversion] <= CONVERT(ROWVERSION, @endRow);
END
GO
