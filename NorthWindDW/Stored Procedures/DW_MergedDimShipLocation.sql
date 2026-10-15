CREATE PROCEDURE [dbo].[DW_MergedDimShipLocation]
AS
BEGIN
    UPDATE dsl
    SET [ShipCity]       = ssl.[ShipCity]
        ,[ShipRegion]    = ssl.[ShipRegion]
        ,[ShipCountry]   = ssl.[ShipCountry]
        ,[ShipPostalCode]= ssl.[ShipPostalCode]
    FROM [dbo].[DimShipLocation] dsl
    INNER JOIN [staging].[shiplocation] ssl ON (dsl.[ShipLocationKey] = ssl.[ShipLocationKey])
END
GO