CREATE PROCEDURE [dbo].[GetShipLocationChangesByRowVersion]
(
    @startRow BIGINT,
    @endRow BIGINT
)
AS
BEGIN
    SELECT DISTINCT
         [ShipCity]       = ISNULL(o.[ShipCity], N'Unknown')
        ,[ShipRegion]     = ISNULL(o.[ShipRegion], N'Unknown')
        ,[ShipCountry]    = ISNULL(o.[ShipCountry], N'Unknown')
        ,[ShipPostalCode] = ISNULL(o.[ShipPostalCode], N'Unknown')
    FROM [dbo].[Orders] o
    WHERE o.[rowversion] > CONVERT(ROWVERSION, @startRow)
      AND o.[rowversion] <= CONVERT(ROWVERSION, @endRow)
END