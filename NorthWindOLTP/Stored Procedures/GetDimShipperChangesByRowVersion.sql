CREATE PROCEDURE [dbo].[GetDimShipperChangesByRowVersion]
(
    @startRow BIGINT,
    @endRow   BIGINT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
         [ShipperID]    AS [ShipperID]
        ,[CompanyName]  AS [CompanyName]
        ,[Phone]        AS [Phone]
    FROM [dbo].[Shippers]
    WHERE [rowversion] > CONVERT(ROWVERSION, @startRow)
      AND [rowversion] <= CONVERT(ROWVERSION, @endRow);
END
GO