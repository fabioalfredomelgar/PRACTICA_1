CREATE PROCEDURE [dbo].[DW_MergeDimShipper]
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE ds
    SET [CompanyName] = ss.[CompanyName]
       ,[Phone]       = ss.[Phone]
    FROM [dbo].[DimShipper] ds
        INNER JOIN [staging].[shipper] ss ON ds.[ShipperID] = ss.[ShipperID];
END