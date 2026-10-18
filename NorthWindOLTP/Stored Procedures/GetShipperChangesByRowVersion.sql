CREATE PROCEDURE [dbo].[GetShipperChangesByRowVersion]
(
    @startRow BIGINT,
    @endRow BIGINT
)
AS
BEGIN
    SELECT sh.[ShipperID]
        ,sh.[CompanyName]
        ,sh.[Phone]
    FROM [dbo].[Shippers] sh
    WHERE sh.[rowversion] > CONVERT(ROWVERSION, @startRow)
      AND sh.[rowversion] <= CONVERT(ROWVERSION, @endRow)
END