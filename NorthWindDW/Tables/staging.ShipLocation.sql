CREATE TABLE [staging].[DimShipLocation](
    [ShipLocationKey] [int] NOT NULL,
    [ShipCity] [nvarchar](15) NOT NULL,
    [ShipRegion] [nvarchar](15) NOT NULL,
    [ShipCountry] [nvarchar](15) NOT NULL,
    [ShipPostalCode] [nvarchar](10) NOT NULL,
    [LoadDate] [datetime] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [staging].[DimShipLocation] ADD CONSTRAINT [DF_staging_DimShipLocation_City] DEFAULT (N'Unknown') FOR [ShipCity]
GO

ALTER TABLE [staging].[DimShipLocation] ADD CONSTRAINT [DF_staging_DimShipLocation_Region] DEFAULT (N'Unknown') FOR [ShipRegion]
GO

ALTER TABLE [staging].[DimShipLocation] ADD CONSTRAINT [DF_staging_DimShipLocation_Country] DEFAULT (N'Unknown') FOR [ShipCountry]
GO

ALTER TABLE [staging].[DimShipLocation] ADD CONSTRAINT [DF_staging_DimShipLocation_Postal] DEFAULT (N'Unknown') FOR [ShipPostalCode]
GO

ALTER TABLE [staging].[DimShipLocation] ADD CONSTRAINT [DF_staging_DimShipLocation_LoadDate] DEFAULT (getdate()) FOR [LoadDate]
GO