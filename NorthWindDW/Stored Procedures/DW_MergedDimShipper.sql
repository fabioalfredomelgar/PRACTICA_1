CREATE PROCEDURE [dbo].[DW_MergedDimShipper]
AS
BEGIN
    UPDATE ds
    SET [ShipperID]    = ss.[ShipperID]
        ,[CompanyName] = ss.[CompanyName]
        ,[Phone]       = ss.[Phone]
    FROM [dbo].[DimShipper] ds
    INNER JOIN [staging].[shipper] ss ON (ds.[ShipperKey] = ss.[ShipperKey])
END
GO